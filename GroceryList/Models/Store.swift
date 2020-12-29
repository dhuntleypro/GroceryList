//
//  Store.swift
//  GroceryList
//
//  Created by Darrien Huntley on 12/25/20.
//

import SwiftUI

struct Store: Codable {
    var id: String?
    let name: String
    let address: String
    var items: [String]?
}
