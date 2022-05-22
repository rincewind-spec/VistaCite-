//
//  Exporter.swift
//  VistaCite!
//
//  Created by Brennan Jacobs on 5/22/22.
//

import Foundation
import AppKit
func copyOut(_ string: String)
{
    let pasteBoard = NSPasteboard.general
    pasteBoard.clearContents()
    pasteBoard.setString(string, forType: .string)
}
