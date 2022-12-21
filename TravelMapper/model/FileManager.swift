//
//  FileManager.swift
//  TravelMapper
//
//  Created by Prabh Simran Singh on 18/10/22.
//

import Foundation

extension FileManager{
    static var documentsDirectory: URL {
            let paths = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)
            return paths[0]
    }
}
