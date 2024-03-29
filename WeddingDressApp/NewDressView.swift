//
//  NewDressView.swift
//  WeddingDressApp
//
//  Created by Karla Rimac on 08.12.2023..
//
import SwiftUI

struct NewDressView: View {
    @EnvironmentObject var dataManager: DataManager
    @State private var newdress = ""
    
    var body: some View {
        VStack {
            TextField("dress", text: $newdress)
            
            Button {
                dataManager.addDress(dressName: newdress)
            } label: {
                Text("Save")
            }
        }
        .padding()
    }
}

struct NewdressView_Previews: PreviewProvider {
    static var previews: some View {
        NewDressView()
    }
}
