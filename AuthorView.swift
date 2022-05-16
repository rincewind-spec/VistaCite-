//
//  AuthorView.swift
//  VistaCite!
//
//  Created by Brennan Jacobs on 5/15/22.
//

import SwiftUI

struct AuthorView: View {
    @ObservedObject var author: Author
    var authorNumber: Int
    var body: some View
    {
        VStack
        {
            TextField("Author \(authorNumber + 1) First Name", text: $author.firstName)
            TextField("Author \(authorNumber + 1) Last Name", text: $author.lastName)
        }
    }
}

struct AuthorView_Previews: PreviewProvider {
    static var previews: some View {
        AuthorView(author: Author(authorName: "John Smith"), authorNumber: 3)
    }
}
