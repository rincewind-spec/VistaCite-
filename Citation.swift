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
