//
//  ContentView.swift
//  GroceryList
//
//  Created by Darrien Huntley on 12/25/20.
//

import SwiftUI

struct ContentView: View {
    
    @State private var isPresented : Bool = false
    @ObservedObject private var storeListVM = StoreListViewModel()
    
//    private func deleteStoreItem(at indexSet: IndexSet) {
//        indexSet.forEach { index in
//            let storeItem = storeItemListVM.storeItems[index]
//            storeItemListVM.deleteStoreItem(storeId: store.storeId, storeItemId: storeItem.storeItemId)
//        }
//        
//    }
    
    var body: some View {
        
        VStack {
            List(storeListVM.stores, id : \.storeId) { store in
                NavigationLink(destination: StoreItemsListView(store: store)) {
                    StoreCell(store: store)
                }
                
            }
            .listStyle(PlainListStyle())
        }
        // on dismiss reload screen ***
        .sheet(isPresented: $isPresented, onDismiss: {
            storeListVM.getAll()
        },content: {
            AddStoreView()
        })
        .navigationBarItems(trailing: Button(action: {
            isPresented = true
        }, label: {
            Image(systemName: "plus")
        }))
        .navigationTitle("Grocery App")
        .embedInNavigationView()
        .onAppear() {
            storeListVM.getAll()
        }
        
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}

struct StoreCell : View {
    
    let store : StoreViewModel
    
    var body: some View {
        VStack(alignment: .leading , spacing: 8) {
            Text(store.name)
                .font(.headline)
            Text(store.address)
                .font(.body)
        }
    }
}
