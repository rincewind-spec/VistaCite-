//
//  Citation.swift
//  VistaCite!
//
//  Created by Brennan Jacobs on 5/11/22.
//

import Foundation
import SwiftUI
public class Citation: Codable, ObservableObject, Identifiable
{
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
        var whoisListing: String
        var hasWhois = true
        id = UUID()
        accessDate = Date()
        do {whoisListing = try Process.run(URL(fileURLWithPath: "/usr/bin/whois"), arguments: [String(contentsOf: url)]).standardOutput as! String}
        catch
        {
            hasWhois = false
        }
        if hasWhois == false
        {
            self.publisher = url.absoluteString
            self.journal = url.absoluteString
        }
        
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
func whoisParser(whoisListing: String)
{
    let whoisLines = whoisListing.components(separatedBy: "\n")
    var publisher: String
    var journal: String
    for line in whoisLines
    {
        if line.contains("Registrant Organization: ")
        {
            publisher = String(line[line.firstIndex(of: ":")!...])
        }
    }
}
