//
//  VistaCite_App.swift
//  VistaCite!
//
//  Created by rincewind-spec on 5/10/22.
//

import SwiftUI

@main
struct VistaCite_App: App {
    @AppStorage("citationStyleDefault") var citationStyleDefault: CitationStyle = .mla9
    var body: some Scene {
        DocumentGroup(newDocument: VistaBibliography(bibliography: Bibliography(citationStyle: citationStyleDefault)), editor: {file in ContentView(document: file.$document)})
        Settings
        {
            SettingsView()
        }
    }
}
