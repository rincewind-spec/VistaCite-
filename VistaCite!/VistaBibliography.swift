//
//  VistaCite_Document.swift
//  VistaCite!
//
//  Created by rincewind-spec on 5/10/22.
//

import SwiftUI
import UniformTypeIdentifiers

extension UTType {
    static var VistaBibliography: UTType {
        UTType(importedAs: "org.vistamarschool.student.VistaCite.VistaBibliography")
    }
}

class VistaBibliography: FileDocument, Codable, ObservableObject {
    static let fileExtension = "VSTC"
    var bibliography: Bibliography

    init(bibliography: Bibliography) {
        self.bibliography = bibliography
    }

    static var readableContentTypes: [UTType] { [.VistaBibliography] }

    required init(configuration: ReadConfiguration) throws {
        guard let data = configuration.file.regularFileContents
        else {
            throw CocoaError(.fileReadCorruptFile)
        }
        let bibliography = try JSONDecoder().decode(Bibliography.self, from: data)
        self.bibliography = bibliography
    }
    
    func fileWrapper(configuration: WriteConfiguration) throws -> FileWrapper {
        let data = try JSONEncoder().encode(self.bibliography)
        return .init(regularFileWithContents: data)
    }
}

