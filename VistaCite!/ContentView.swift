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
        TextEditor(text: $document.text)
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView(document: .constant(VistaBibliography()))
    }
}
