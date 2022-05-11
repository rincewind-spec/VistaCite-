//
//  Bibliography.swift
//  VistaCite!
//
//  Created by Brennan Jacobs on 5/11/22.
//

import Foundation
public class Bibliography: Codable, ObservableObject
{
    var citationStyle: CitationStyle
    var citations: [Citation]
    public init(citationStyle: CitationStyle)
    {
        citations = Array<Citation>()
        self.citationStyle = citationStyle
    }
}
public enum CitationStyle: Codable
{
    case mla9
    case apa9
}
