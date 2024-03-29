
//  DataManager.swift
//  WeddingDressApp
//
//  Created by Karla Rimac on 08.12.2023..


import SwiftUI
import Firebase

class DataManager: ObservableObject {
    @Published var dresses: [Dress] = []
    
    init() {
        fetchdresses()
    }
    
    func fetchdresses() {
        dresses.removeAll()
        let db = Firestore.firestore()
        let ref = db.collection("Dresses")
        ref.getDocuments { snapshot, error in
            guard error == nil else {
                print(error!.localizedDescription)
                return
            }
            
            if let snapshot = snapshot {
                for document in snapshot.documents {
                    let data = document.data()
                    
                    let id = data["id"] as? String ?? ""
                    let name = data["Name"] as? String ?? ""
                    let description = data["Description"] as? String ?? ""
                    let color = data["Color"] as? String ?? ""
                   

                    
                    let dress = Dress(id: id, name: name, description: description, color: color)
                    self.dresses.append(dress)
                }
            }
        }
    }
    
    func addDress(dressName: String) {
        let db = Firestore.firestore()
        let ref = db.collection("Dresses").document(dressName)
        ref.setData(["Name": dressName, "id" : 10]) { error in
            if let error = error {
                print(error.localizedDescription)
            }
        }
    }
}
