//
//  CitationRow.swift
//  VistaCite!
//
//  Created by Brennan Jacobs on 5/11/22.
//

import SwiftUI

struct CitationRow: View {
    @ObservedObject var citation: Citation
    var body: some View {
        Text(citation.url.absoluteString)
    }
}

struct CitationRow_Previews: PreviewProvider {
    static var previews: some View {
        CitationRow(citation: Citation(url: URL(string: "example.com")!))
    }
}
