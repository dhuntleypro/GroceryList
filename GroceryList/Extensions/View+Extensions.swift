//
//  View+Extensions.swift
//  GroceryList
//
//  Created by Darrien Huntley on 12/25/20.
//

import Foundation
import SwiftUI

extension View {
    func embedInNavigationView() -> some View {
        NavigationView { self }
    }
}
