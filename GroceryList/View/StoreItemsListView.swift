//
//  StoreItemsListView.swift
//  GroceryList
//
//  Created by Darrien Huntley on 12/25/20.
//

import SwiftUI
// import Combine

struct StoreItemsListView: View {
    
    
    var store: StoreViewModel
    @StateObject private var storeItemListVM = StoreItemListViewModel()
    
    @State private var storeItemVS = StoreItemViewState()
    
    private func deleteStoreItem(at indexSet: IndexSet) {
        indexSet.forEach { index in
            let storeItem = storeItemListVM.storeItems[index]
            storeItemListVM.deleteStoreItem(storeId: store.storeId, storeItemId: storeItem.storeItemId)
        }
        
    }
    
    var body: some View {
        VStack {
            TextField("Enter Item Name", text: $storeItemVS.name)
                .textFieldStyle(RoundedBorderTextFieldStyle())
                .padding()
            
            
            TextField("Price", text: $storeItemVS.price)
                .textFieldStyle(RoundedBorderTextFieldStyle())
                .padding()
            
            TextField("Quantity", text: $storeItemVS.quantity)
                .textFieldStyle(RoundedBorderTextFieldStyle())
                .padding()
            
            Button("save") {
                storeItemListVM.addItemToStore(storeId: store.storeId, storeItemVS: storeItemVS) { error in
                    if error == nil {
                        storeItemVS = StoreItemViewState()
                        storeItemListVM.getStoreItemBy(storeId: store.storeId)
                    }
                    
                }
            }
            //  if let store = storeItemListVM.store {
            
            List {
                
                ForEach(storeItemListVM.storeItems, id: \.storeItemId) { storeItem in
                    Text(storeItem.name)
                }.onDelete(perform: deleteStoreItem)
            }
            
            
            
        }
        //   }
        
        Spacer()
            
            .onAppear() {
                
                //  storeItemListVM.getStoreById(storeId: store.storeId)
                storeItemListVM.getStoreItemBy(storeId: store.storeId)
            }
    }
}

struct StoreItemsListView_Previews: PreviewProvider {
    static var previews: some View {
        StoreItemsListView(store: StoreViewModel(store: Store(id: "123", name: "haha", address: "addy", items: nil)))
    }
}
