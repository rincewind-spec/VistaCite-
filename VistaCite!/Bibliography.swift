//
//  Bibliography.swift
//  VistaCite!
//
//  Created by Brennan Jacobs on 5/11/22.
//

import Foundation
import SwiftUI
public class Bibliography: Codable, ObservableObject
{
    
    public required init(from decoder: Decoder) throws
    {
        let filer = try decoder.container(keyedBy: CodingKeys.self)
        citationStyle = try filer.decode(CitationStyle.self, forKey: .citationStyle)
        citationURL = try filer.decode(String.self, forKey: .citationURL)
        citations = try filer.decode([Citation].self, forKey: .citations)
    }
    
    public func encode(to encoder: Encoder) throws {
        var filer = encoder.container(keyedBy: CodingKeys.self)
        try filer.encode(citationStyle, forKey: .citationStyle)
        try filer.encode(citationURL, forKey: .citationURL)
        try filer.encode(citations, forKey: .citations)
    }
    @Published var citationStyle: CitationStyle
    @Published var citations: [Citation]
    @Published var citationURL: String
    public init(citationStyle: CitationStyle)
    {
        citations = Array<Citation>()
        self.citationStyle = citationStyle
        citationURL = ""
    }
    enum CodingKeys: CodingKey
    {
        case citationStyle, citations, citationURL
    }
    public func BibliographyFormatter() -> String
    {
        var rtnString = ""
        for i in 0..<citations.count
        {
            rtnString += "\(i + 1). " + citations[i].CitationFormatter(citationStyle: citationStyle) + "\n"
        }
        return rtnString
    }
    public func delete(atOffsets: IndexSet)
    {
        citations.remove(atOffsets: atOffsets)
    }
}
public enum CitationStyle: Int, Codable
{
    case mla9 = 1
    case apa7 = 2
}
