//
//  CitationRow.swift
//  VistaCite!
//
//  Created by Brennan Jacobs on 5/11/22.
//

import SwiftUI

struct CitationRow: View {
    @ObservedObject var citation: Citation
    @Binding var citationStyle: CitationStyle
    var citationNumber: Int
    var body: some View {
        Text("\(citationNumber + 1). \(citation.CitationFormatter(citationStyle: citationStyle))")
    }
}

struct CitationRow_Previews: PreviewProvider {
    static var previews: some View {
        CitationRow(citation: Citation(url: URL(string: "https://arstechnica.com/gadgets/2022/05/next-gen-nvidia-rtx-4000-series-gpus-are-reportedly-coming-in-the-next-few-months/")!), citationStyle: .constant(.apa7), citationNumber: 1)
    }
}
