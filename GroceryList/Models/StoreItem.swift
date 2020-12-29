//
//  StoreItem.swift
//  GroceryList
//
//  Created by Darrien Huntley on 12/27/20.
//

import SwiftUI

struct StoreItem: Codable {
    var id : String?
    var name: String = ""
    var price: Double = 0.0
    var quantity: Int = 0

}

extension StoreItem {
    
    static func from(_ storeItemVS: StoreItemViewState) -> StoreItem {
        return StoreItem(
            name: storeItemVS.name ,
            price: Double(storeItemVS.price) ?? 0.0 ,
            quantity: Int(storeItemVS.quantity) ?? 0
        
        
        )
        
    }
}
