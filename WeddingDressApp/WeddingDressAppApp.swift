//
//  WeddingDressAppApp.swift
//  WeddingDressApp
//
//  Created by Karla Rimac on 08.12.2023..
//

import SwiftUI
import Firebase

@main
struct WeddingDressApp: App {
    @StateObject var dataManager = DataManager()
    
    
    init() {
        FirebaseApp.configure()
    }
    
    var body: some Scene {
        WindowGroup {
            ContentView().environmentObject(dataManager)
            
        }
    }
}
