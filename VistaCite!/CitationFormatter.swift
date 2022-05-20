//
//  CitationFormatter.swift
//  VistaCite!
//
//  Created by Brennan Jacobs on 5/19/22.
//

import Foundation
public extension String.StringInterpolation
{
    mutating func appendInterpolation(citation: Citation, citationStyle: CitationStyle)
    {
        let dateFormatter = DateFormatter()
        var rtnString = ""
        if citationStyle == .mla9
        {
            dateFormatter.dateFormat = "dd MMM yyyy"
            for author in citation.authors
            {
                rtnString += author.firstName + author.lastName + ", "
            }
            rtnString = String(rtnString.dropLast(2)) + ". "
            rtnString += "'\(citation.title)' *\(citation.journal)*, \(dateFormatter.string(from: citation.publishDate)), \(citation.publisher), [\(citation.url.absoluteString)](\(citation.url)). \(dateFormatter.string(from: citation.accessDate))"
        }
        else if citationStyle == .apa7
        {
            dateFormatter.dateFormat = "(yyyy, MM dd)"
            if citation.authors.count > 1
            {
                rtnString = citation.publisher
            }
            else
            {
                rtnString = citation.authors[0].lastName + ", " + String(citation.authors[0].firstName.first!)
            }
            rtnString += ". " + dateFormatter.string(from: citation.publishDate) + ". " + "*\(citation.title)*" + ". " + citation.journal + ". " + "[\(citation.url.absoluteString)](\(citation.url))"
        }
        appendInterpolation(rtnString)
    }
}
