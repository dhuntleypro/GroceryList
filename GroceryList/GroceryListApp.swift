//
//  GroceryListApp.swift
//  GroceryList
//
//  Created by Darrien Huntley on 12/25/20.
//

import SwiftUI
import Firebase

@main
struct GroceryListApp: App {
    
    init() {
        FirebaseApp.configure() 
    }
    var body: some Scene {
        WindowGroup {
            ContentView()
        }
    }
}
