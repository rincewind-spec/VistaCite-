//
//  CitationView.swift
//  VistaCite!
//
//  Created by Brennan Jacobs on 5/12/22.
//

import SwiftUI

struct CitationView: View {
    @Binding var citation: Citation
    var body: some View {
        Text(/*@START_MENU_TOKEN@*/"Hello, World!"/*@END_MENU_TOKEN@*/)
    }
}

struct CitationView_Previews: PreviewProvider {
    static var previews: some View {
        CitationView(citation: .constant(Citation(url: URL(string: "https://arstechnica.com/science/2022/05/unvaccinated-north-korea-reports-omicron-outbreak-raising-fears-of-new-variants/")!)))
    }
}
