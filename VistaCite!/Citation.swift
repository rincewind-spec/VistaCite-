//
//  Citation.swift
//  VistaCite!
//
//  Created by Brennan Jacobs on 5/11/22.
//

import Foundation
import SwiftUI
import SwiftSoup
import DomainParser
public class Citation: Codable, ObservableObject, Identifiable, Hashable
{
    public required init(from decoder: Decoder) throws
    {
        let filer = try decoder.container(keyedBy: CodingKeys.self)
        authors = try filer.decode([Author].self, forKey: .authors)
        id = try filer.decode(UUID.self, forKey: .id)
        accessDate = try filer.decode(Date.self, forKey: .accessDate)
        publishDate = try filer.decode(Date.self, forKey: .publishDate)
        url = try filer.decode(URL.self, forKey: .url)
        publisher = try filer.decode(String.self, forKey: .publisher)
        journal = try filer.decode(String.self, forKey: .journal)
        title = try filer.decode(String.self, forKey: .title)
    }
    
    public func encode(to encoder: Encoder) throws
    {
        var filer = encoder.container(keyedBy: CodingKeys.self)
        try filer.encode(authors, forKey: .authors)
        try filer.encode(id, forKey: .id)
        try filer.encode(accessDate, forKey: .accessDate)
        try filer.encode(publishDate, forKey: .publishDate)
        try filer.encode(url, forKey: .url)
        try filer.encode(publisher, forKey: .publisher)
        try filer.encode(journal, forKey: .journal)
        try filer.encode(title, forKey: .title)
    }
    
    public static func == (lhs: Citation, rhs: Citation) -> Bool
    {
        return lhs.url == rhs.url
    }
    public func hash(into hasher: inout Hasher)
    {
        hasher.combine(url)
    }
    @Published public var authors: [Author]
    @Published public var id: UUID
    @Published public var accessDate: Date
    @Published public var publishDate: Date
    @Published public var url: URL
    @Published public var publisher: String
    @Published public var journal: String
    @Published public var title: String
    public init(url: URL)
    {
        self.url = url
        let whois = Process()
        let hostGetter = URLComponents(url: url, resolvingAgainstBaseURL: true)
        let domainParser: DomainParser
        do
        {   try
            domainParser = DomainParser()
            whois.arguments = [(domainParser.parse(host: (hostGetter?.host)!)?.domain)!]
        }
        catch
        {
            whois.arguments = [(hostGetter?.host)!]
        }
        whois.executableURL = URL(fileURLWithPath: "/usr/bin/whois")
        let whoisPipe = Pipe()
        whois.standardOutput = whoisPipe
        var whoisListing = ""
        var hasWhois = true
        var journalParserOutput: (String, String)
        id = UUID()
        accessDate = Date()
        publishDate = Date()
        do {try whois.run()}
        catch
        {
            hasWhois = false
        }
        if hasWhois == false
        {
            publisher = url.absoluteString
            journal = ""
            title = ""
        }
        else
        {
            let whoisData = whoisPipe.fileHandleForReading.readDataToEndOfFile()
            whoisListing = String(decoding: whoisData, as: UTF8.self)
            publisher = whoisParser(whoisListing: whoisListing)
            journalParserOutput = journalParser(url: url)
            journal = journalParserOutput.0
            title = journalParserOutput.1
        }
        authors = [Author(authorName: "")]
        
    }
    enum CodingKeys: CodingKey
    {
        case authors, id, accessDate, publishDate, url, publisher, journal, title
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
                metaElement = try document.select("meta").first()!
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
