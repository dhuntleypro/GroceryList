//
//  FirestoreManager.swift
//  GroceryList
//
//  Created by Darrien Huntley on 12/25/20.
//

import SwiftUI
import Firebase
import FirebaseFirestoreSwift

class FirestoreManager {
    
    private var db : Firestore
    
    init() {
        db = Firestore.firestore()
    }
    
    func deleteStoreItem(storeId: String, storeItemId: String, completion: @escaping (Error?) -> Void) {
         
        db.collection("stores")
            .document(storeId)
            .collection("items")
            .document(storeItemId)
            .delete { (error) in
                    completion(error)
            }

    }
    func getStoreItemsBy(storeId: String, completion: @escaping (Result<[StoreItem]?, Error>) -> Void) {
        db.collection("stores")
            .document(storeId)
            .collection("items")
            .getDocuments { (snapshot, error) in
                if let error = error {
                    completion(.failure(error))
                } else {
                    if let snapshot = snapshot {
                        let items: [StoreItem]? = snapshot.documents.compactMap { doc in
                            var storeItem = try? doc.data(as: StoreItem.self)
                            storeItem?.id = doc.documentID
                            return storeItem
                        }
                        
                        completion(.success(items))
                    }
                }
            }
        
    }
    
    
    func getStoreById(storeId: String, completion: @escaping (Result<Store?, Error>) -> Void) {
        let ref = db.collection("stores").document(storeId)
        ref.getDocument { (snapshot, error) in
            
            if let error = error {
                completion(.failure(error))
            } else {
                
                if let snapshot = snapshot {
                    var store: Store? = try? snapshot.data(as: Store.self)
                    if store != nil {
                        store!.id = snapshot.documentID
                        completion(.success(store))
                    }
                }
            }
        }
    }
    
    
    func updateStore(storeId: String , storeItem: StoreItem, completion: @escaping (Result<Store?, Error>) -> Void) {
        
        do {
            
            let _ = try db.collection("stores").document(storeId).collection("items").addDocument(from: storeItem)
            
            self.getStoreById(storeId: storeId) { result in
                switch result {
                    case .success(let store):
                        completion(.success(store))
                        
                    case .failure(let error):
                        completion(.failure(error))
                }
            }
        } catch let error {
            completion(.failure(error))
        }
    }
    
    
//    func updateStore(storeId: String, values: [AnyHashable: Any],  completion: @escaping (Result<Store?, Error>) -> Void) {
//
//        let ref = db.collection("stores").document(storeId)
//
//        ref.updateData(
//            ["items": FieldValue.arrayUnion((values["items"] as? [String]) ?? [])]
//        ) { error in
//
//            if let error = error {
//                completion(.failure(error))
//            } else {
//                //                ref.getDocument { (snapshot, error) in
//                //                    if let error  = error {
//                //                        completion(.failure(error))
//                //                    } else {
//                //                        if let snapshot = snapshot {
//                //                            var store: Store? = try? snapshot.data(as: Store.self)
//                //                            if store != nil {
//                //                                store!.id = snapshot.documentID
//                //                                completion(.success(store))
//                //                            }
//                //                        }
//                //                    }
//                //                }
//
//                self.getStoreById(storeId: storeId) { result in
//                    switch result {
//                    case .success(let store):
//                        completion(.success(store))
//
//                    case .failure(let error):
//                        completion(.failure(error))
//                    }
//                }
//            }
//        }
//    }
    
    // Gets all data from Documents
    func getAllStores(completion: @escaping (Result<[Store]?, Error>) -> Void) {
        db.collection("stores")
            .getDocuments { (snapshot, error) in
                if let error = error {
                    completion(.failure(error))
                } else {
                    if let snapshot = snapshot {
                        let stores: [Store]? = snapshot.documents.compactMap { doc in
                            var store = try? doc.data(as: Store.self)
                            if store != nil {
                                store!.id = doc.documentID
                            }
                            return store
                        }
                        
                        completion(.success(stores))
                    }
                }
            }
    }
    
    func save(store: Store, completion: @escaping (Result<Store?, Error>) -> Void) {
        do {
            let ref = try db.collection("stores").addDocument(from: store)
            ref.getDocument { (snapshot, error) in
                guard let snapshot = snapshot, error == nil else {
                    completion(.failure(error!))
                    return
                }
                
                let store = try? snapshot.data(as: Store.self)
                completion(.success(store))
            }
        } catch let error{
            completion(.failure(error))
        }
    }
}
