//
//  VistaCite_Document.swift
//  VistaCite!
//
//  Created by rincewind-spec on 5/10/22.
//

import SwiftUI
import UniformTypeIdentifiers

extension UTType {
    static var bibDoc: UTType {
        UTType(importedAs: "org.vistamarschool.student.VistaCite-.VistaBibliography")
    }
}

struct VistaBibliography: FileDocument, Codable {
    static let fileExtension = "VSTC"
    var text: String

    init(text: String = "Hello, world!") {
        self.text = text
    }

    static var readableContentTypes: [UTType] { [.bibDoc] }

    init(configuration: ReadConfiguration) throws {
        guard let data = configuration.file.regularFileContents
        else {
            throw CocoaError(.fileReadCorruptFile)
        }
        let string = try JSONDecoder().decode(VistaBibliography.self, from: data)
        self = string
    }
    
    func fileWrapper(configuration: WriteConfiguration) throws -> FileWrapper {
        let data = try JSONEncoder().encode(self)
        return .init(regularFileWithContents: data)
    }
}

