//
//  BibliographyView.swift
//  VistaCite!
//
//  Created by Brennan Jacobs on 5/11/22.
//

import SwiftUI

struct BibliographyView: View {
    @Binding var bibliography: Bibliography
    @State var citationURL: String
    var body: some View {
        VStack {
            HStack
            {
                TextField("Add citation", text: $citationURL)
                Button("Add Citation", action:
                    {
                        bibliography.citations.append(Citation(url: URL(string: citationURL)!))
                        citationURL = ""
                    
                    })
            }
            if !bibliography.citations.isEmpty
            {
            NavigationView
            {
                List(content: bibliography.citations)
                {
                    citation in nav
                }
            }
                
            }
        }
    }
}

struct BibliographyView_Previews: PreviewProvider {
    static var previews: some View {
        BibliographyView(bibliography: .constant( Bibliography(citationStyle: .mla9)))
    }
}
