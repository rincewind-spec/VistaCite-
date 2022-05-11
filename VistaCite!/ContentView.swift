//
//  ContentView.swift
//  VistaCite!
//
//  Created by rincewind-spec on 5/10/22.
//

import SwiftUI

struct ContentView: View {
    @Binding var document: VistaBibliography

    var body: some View {
        Spacer()
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView(document: .constant( VistaBibliography(bibliography: Bibliography(citationStyle: .mla9))))
    }
}
