//
//  CitationView.swift
//  VistaCite!
//
//  Created by Brennan Jacobs on 5/12/22.
//

import SwiftUI

struct CitationView: View {
    @Binding var citation: Citation
    var body: some View {
        Form
        {
            Text("Authors: ").font(.title2)
            ForEach($citation.authors)
            {
                author in
                HStack
                {
                    Text("Author first name:")
                    TextField("Author First Name", text: author.firstName)
                    Text("Last name:")
                    TextField("Author Last Name", text: author.lastName)
                }
            }
            Text("Dates: ").font(.title2)
            DatePicker("Date accessed:", selection: $citation.accessDate, displayedComponents: [.date])
            DatePicker("Date published:", selection: $citation.publishDate, displayedComponents: [.date])
            HStack
            {
                Text("Article title:")
                TextField("Article Title", text: $citation.title)
            }
            HStack
            {
                Text("Journal of article:")
                TextField("Article Journal", text: $citation.journal)
            }
            HStack
            {
                Text("Publisher of journal:")
                TextField("Journal publisher", text: $citation.publisher)
            }
            
        }
    }
}

struct CitationView_Previews: PreviewProvider {
    static var previews: some View {
        CitationView(citation: .constant(Citation(url: URL(string: "https://arstechnica.com/science/2022/05/unvaccinated-north-korea-reports-omicron-outbreak-raising-fears-of-new-variants/")!)))
    }
}
