//
//  SettingsView.swift
//  VistaCite!
//
//  Created by Brennan Jacobs on 5/22/22.
//

import SwiftUI

struct SettingsView: View {
    @AppStorage("citationStyleDefault") var citationStyleDefault: CitationStyle = .mla9
    var body: some View {
        Form
        {
        Picker("Default Citation Style:", selection: $citationStyleDefault, content:
                {
                    Text("MLA 9").tag(CitationStyle.mla9)
                    Text("APA 7").tag(CitationStyle.apa7)
                })
        }
        .padding(.all)
        .frame(width: 200.0)
    }
}

struct SettingsView_Previews: PreviewProvider {
    static var previews: some View {
        SettingsView()
    }
}
