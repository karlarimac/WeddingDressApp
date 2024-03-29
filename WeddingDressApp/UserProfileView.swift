//
//  UserProfileView.swift
//  WeddingDressApp
//
//  Created by Karla Rimac on 08.12.2023..
//

import SwiftUI

struct UserProfileView: View {
    var email: String
    var onLogout: () -> Void

    var body: some View {
        VStack {
          

            Image(systemName: "person.circle")
                .resizable()
                .aspectRatio(contentMode: .fill)
                .frame(width: 320, height: 100)
                .clipShape(Circle())
                .padding(.bottom, 20)
            
            Text("This is YOU")
                .font(.title)
                .fontWeight(.bold)
                .padding(.bottom, 10)

          
            VStack(alignment: .leading, spacing: 10) {
                
               // Text("Email: \(email)")
                   // .foregroundColor(.gray)
            }
            .padding(.bottom, 20)

            Spacer()

            Button(action: {
        
                ContentView().logout()
            }, label: {
                Text("Logout")
                    .font(.headline)
                    .foregroundColor(.white)
                    .padding()
                    .background(LinearGradient(gradient: Gradient(colors: [.pink, .purple]), startPoint: .leading, endPoint: .trailing))
                    .cornerRadius(10)
            })
        }
        .frame(height: 300)
        .padding()
        .background(Color.white)
        .cornerRadius(20)
        .shadow(radius: 5)
    }
}


struct UserProfileView_Previews: PreviewProvider {
    static var previews: some View {
        UserProfileView(email: ContentView().email, onLogout: {})
    }
}
