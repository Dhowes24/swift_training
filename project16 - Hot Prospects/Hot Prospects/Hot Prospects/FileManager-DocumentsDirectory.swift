//
//  FileManager-DocumentsDirectory.swift
//  Hot Prospects
//
//  Created by Derek Howes on 5/19/22.
//

import Foundation

extension FileManager {
    static var documentsDirectory: URL {
        let paths = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)
        return paths[0]
    }
}
