//
//  BibliographyView.swift
//  VistaCite!
//
//  Created by Brennan Jacobs on 5/11/22.
//

import SwiftUI

struct BibliographyView: View {
    @Binding var bibliography: Bibliography
    @State var citationURL = ""
    var body: some View {
        VStack {
            HStack
            {
                TextField("Add Citation", text: $citationURL)
                    .frame(width: 200.0)
                Button("Add Citation", action:
                    {
                        bibliography.citations.append(Citation(url: URL(string: citationURL)!))
                        citationURL = ""
                    
                    })
            }
            
            if $bibliography.citations.isEmpty == false
            {
            NavigationView
            {
                ForEach($bibliography.citations)
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
