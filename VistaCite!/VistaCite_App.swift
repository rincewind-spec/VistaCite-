//
//  VistaCite_App.swift
//  VistaCite!
//
//  Created by rincewind-spec on 5/10/22.
//

import SwiftUI

@main
struct VistaCite_App: App {
    var body: some Scene {
        DocumentGroup(newDocument: VistaCite_Document()) { file in
            ContentView(document: file.$document)
        }
    }
}
