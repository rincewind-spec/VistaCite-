//
//  CitationView.swift
//  VistaCite!
//
//  Created by Brennan Jacobs on 5/12/22.
//

import SwiftUI

struct CitationView: View {
    @ObservedObject var citation: Citation
    var body: some View {
        Form
        {
            Text("Authors: ").font(.title2)
            ForEach($citation.authors)
            {
                author in
                    TextField("Author First Name", text: author.firstName)
                    TextField("Author Last Name", text: author.lastName)
            }
            .frame(width: 300.0)
            Button(action: {citation.authors.append(Author(authorName: ""))}, label: {Text("Add Author")})
            Text("Dates: ").font(.title2)
            DatePicker("Date accessed:", selection: $citation.accessDate, displayedComponents: [.date])
                .frame(width: 200.0)
            DatePicker("Date published:", selection: $citation.publishDate, displayedComponents: [.date])
                .frame(width: 200.0)
            Text("Metadata: ").font(.title2)
                TextField("Article Title", text: $citation.title)
                TextField("Article Journal", text: $citation.journal)
                TextField("Journal Publisher", text: $citation.publisher)
            
        }
        .frame(width: 500.0)
    }
}

struct CitationView_Previews: PreviewProvider {
    static var previews: some View {
        CitationView(citation: Citation(url: URL(string: "https://arstechnica.com/science/2022/05/unvaccinated-north-korea-reports-omicron-outbreak-raising-fears-of-new-variants/")!))
    }
}
