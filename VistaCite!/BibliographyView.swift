//
//  BibliographyView.swift
//  VistaCite!
//
//  Created by Brennan Jacobs on 5/11/22.
//

import SwiftUI

struct BibliographyView: View {
    @ObservedObject var bibliography: Bibliography
    var body: some View {
        NavigationView
            {
                List(bibliography.citations)
                    {
                        citation in
                        NavigationLink(destination: CitationView(citation: citation), label:
                        {
                            CitationRow(citation: citation, citationNumber: bibliography.citations.firstIndex(of: citation)!)
                        }
                        )
                    }
            }
            .toolbar(content:
                        {
                HStack(alignment: .top)
                {
                    Picker("Citation Style", selection: $bibliography.citationStyle, content:
                            {
                                Text("MLA 9").tag(CitationStyle.mla9)
                                Text("APA 9").tag(CitationStyle.apa9)
                            })
                    TextField("Add Citation", text: $bibliography.citationURL)
                        .frame(width: 200.0)
                        .onSubmit {
                            bibliography.citations.append(Citation(url: URL(string: bibliography.citationURL)!))
                            bibliography.citationURL = ""
                        }
                }
            })
            .navigationTitle("VistaCite")
    }
}

struct BibliographyView_Previews: PreviewProvider {
    static var previews: some View {
        BibliographyView(bibliography: Bibliography(citationStyle: .mla9))
    }
}
