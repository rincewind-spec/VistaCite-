//
//  BibliographyView.swift
//  VistaCite!
//
//  Created by Brennan Jacobs on 5/11/22.
//

import SwiftUI

struct BibliographyView: View {
    @Binding var bibliography: Bibliography
    var body: some View {
        VStack {
            HStack
            {
                TextField("Add Citation", text: $bibliography.citationURL)
                    .frame(width: 200.0)
                    .onSubmit {
                        bibliography.citations.append(Citation(url: URL(string: bibliography.citationURL)!))
                        bibliography.citationURL = ""
                    }
            }
            
            if bibliography.citations.isEmpty == false
            {
            NavigationView
            {
                ForEach(bibliography.citations)
                    {
                        citation in
                        NavigationLink(destination: CitationView(citation: citation), label:
                        {
                            CitationRow(citation: citation)
                        }
                        )
                    }
            }
                
            }
        }
        .padding(.all)
    }
}

struct BibliographyView_Previews: PreviewProvider {
    static var previews: some View {
        BibliographyView(bibliography: .constant( Bibliography(citationStyle: .mla9)))
    }
}
