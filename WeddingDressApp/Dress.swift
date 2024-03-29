//
//  Dress.swift
//  WeddingDressApp
//
//  Created by Karla Rimac on 10.12.2023..
//

import SwiftUI

struct Dress: Identifiable {
    var id: String
    var name: String
    var description: String
    var color: String
}
extension Dress: Equatable {
    static func == (lhs: Dress, rhs: Dress) -> Bool {
        return lhs.id == rhs.id
    }
}
