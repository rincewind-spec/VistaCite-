//
//  CitationRow.swift
//  VistaCite!
//
//  Created by Brennan Jacobs on 5/11/22.
//

import SwiftUI

struct CitationRow: View {
    @ObservedObject var citation: Citation
    var citationNumber: Int
    var body: some View {
        Text("\(citationNumber + 1)" + citation.url.absoluteString)
    }
}

struct CitationRow_Previews: PreviewProvider {
    static var previews: some View {
        CitationRow(citation: Citation(url: URL(string: "example.com")!), citationNumber: 1)
    }
}
