//
//  FileManager-DocumentsDirectory.swift
//  Flashzilla
//
//  Created by Derek Howes on 5/23/22.
//

import Foundation

extension FileManager {
    static var documentsDirectory: URL {
        let paths = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)
        return paths[0]
    }
}
