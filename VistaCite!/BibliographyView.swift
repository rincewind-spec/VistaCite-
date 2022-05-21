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
                List(bibliography.citations, id: \.id)
                    {
                        citation in
                        NavigationLink(destination: CitationView(citation: citation), label:
                        {
                            CitationRow(citation: citation, citationStyle: $bibliography.citationStyle, citationNumber: bibliography.citations.firstIndex(of: citation)!)
                            //Text("\(bibliography.citations.firstIndex(of: citation)! + 1). \(citation.CitationFormatter(citationStyle: bibliography.citationStyle))")
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
                                Text("APA 7").tag(CitationStyle.apa7)
                            })
                    TextField("Add Citation", text: $bibliography.citationURL)
                        .frame(width: 300.0)
                        .onSubmit
                    {
                            bibliography.citations.append(Citation(url: URL(string: bibliography.citationURL)!))
                            bibliography.citationURL = ""
                        }
                }
            })
    }
}

struct BibliographyView_Previews: PreviewProvider {
    static var previews: some View {
        BibliographyView(bibliography: Bibliography(citationStyle: .mla9))
    }
}
