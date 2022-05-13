//
//  Citation.swift
//  VistaCite!
//
//  Created by Brennan Jacobs on 5/11/22.
//

import Foundation
import SwiftUI
import SwiftSoup
public class Citation: Codable, ObservableObject, Identifiable, Hashable
{
    public static func == (lhs: Citation, rhs: Citation) -> Bool
    {
        return lhs.url == rhs.url
    }
    public func hash(into hasher: inout Hasher)
    {
        hasher.combine(url)
    }
    public var authors: [Author]
    public var id: UUID
    public var accessDate: Date
    public var publishDate: Date
    public var url: URL
    public var publisher: String
    public var journal: String
    public var title: String
    public init(url: URL)
    {
        self.url = url
        var whoisListing = ""
        var hasWhois = true
        var journalParserOutput: (String, String)
        id = UUID()
        accessDate = Date()
        publishDate = Date()
        do {whoisListing = try Process.run(URL(fileURLWithPath: "/usr/bin/whois"), arguments: [String(contentsOf: url)]).standardOutput as! String}
        catch
        {
            hasWhois = false
        }
        if hasWhois == false
        {
            publisher = self.url.absoluteString
            journal = ""
            title = ""
        }
        else
        {
            publisher = whoisParser(whoisListing: whoisListing)
            journalParserOutput = journalParser(url: self.url)
            journal = journalParserOutput.0
            title = journalParserOutput.1
        }
        authors = [Author(authorName: "")]
        
    }
    
}
public class Author: Codable, ObservableObject, Identifiable
{
    public var firstName: String
    public var lastName: String
    public var id: UUID
    public init(authorName: String)
    {
        id = UUID()
        let names = authorName.components(separatedBy: " ")
        if names.count == 2
        {
            firstName = names[0]
            lastName = names[1]
        }
        else
        {
            firstName = "Check"
            lastName = "Author"
        }
    }
}
fileprivate func whoisParser(whoisListing: String) -> String
{
    let whoisLines = whoisListing.components(separatedBy: "\n")
    var publisher = ""
    for line in whoisLines
    {
        if line.contains("Registrant Organization: ")
        {
            publisher = String(String(line[line.firstIndex(of: ":")!...]).dropFirst(2))
            break
        }
    }
    return publisher
}
fileprivate func journalParser(url: URL) -> (String, String)
{
    var journal: String
    var title: String
    var hasWebPage = true
    var isWebPageParsed = true
    var webPage = ""
    var document: Document = Document("")
    var titleElement: Element
    var metaElement: Element
    do
    {
        webPage = try String(contentsOf: url)
    }
    catch
    {
        hasWebPage = false
    }
    if hasWebPage == false
    {
        journal = url.absoluteString
        title = ""
    }
    else
    {
        do
        {
            document = try SwiftSoup.parse(webPage)
        }
        catch
        {
            isWebPageParsed = false
        }
        if isWebPageParsed == false
        {
            journal = url.absoluteString
            title = ""
        }
        else
        {
            do
            {
                titleElement = try document.select("title").first()!
                title = try titleElement.text()
            }
            catch
            {
                title = ""
            }
            do
            {
                metaElement = try document.select("og|site_name").first()!
                journal = try metaElement.attr("content")
            }
            catch
            {
                journal = url.absoluteString
            }
        }
        
    }
    return (journal, title)
}
