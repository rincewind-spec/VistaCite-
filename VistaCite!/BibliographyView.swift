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
        ScrollView
        {
            /*List(bibliography.citations)
            {
                
            }*/
        }
    }
}

struct BibliographyView_Previews: PreviewProvider {
    static var previews: some View {
        BibliographyView(bibliography: .constant( Bibliography(citationStyle: .mla9)))
    }
}
