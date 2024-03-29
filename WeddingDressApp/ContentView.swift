//
//  ContentView.swift
//  WeddingDressApp
//
//  Created by Karla Rimac on 08.12.2023..
//

import SwiftUI
import Firebase

struct ContentView: View {
    @State public var email = ""
    @State private var password = ""
    @State private var userIsLoggedIn = false
//    @State private var showOverlay = true
    @State private var showAlert = false
   
    var body: some View {
            NavigationView {
                if userIsLoggedIn {
                    ListView()
                } else {
                    content
                }
            }.alert(isPresented: $showAlert) {
                Alert(
                    title: Text("Registration Successful"),
                    message: Text("Your account has been created successfully."),
                    dismissButton: .default(Text("OK"))
        
        )}
                    }
                    


    
    func isUserLoggedIn() {
        Auth.auth().addStateDidChangeListener { auth, user in
            userIsLoggedIn = user != nil
        }
    }

    
    var content: some View {
        ZStack {
            Color.black
            
            RoundedRectangle(cornerRadius: 30, style: .continuous)
                .foregroundStyle(.linearGradient(colors: [.purple, .pink], startPoint: .topLeading, endPoint: .bottomTrailing))
                .frame(width: 1000, height: 400)
                .rotationEffect(.degrees(135))
                .offset(y: -350)
            
            RoundedRectangle(cornerRadius: 30, style: .continuous)
                .foregroundStyle(.linearGradient(colors: [.purple, .pink], startPoint: .topLeading, endPoint: .bottomTrailing))
                .frame(width: 1000, height: 400)
                .rotationEffect(.degrees(200))
                .offset(y: -350)
            
            VStack(spacing: 30) {
                Text("Wedding Dress App")
                    .foregroundColor(.white)
                    .font(.system(size: 40, weight: .bold, design: .rounded))
                    .offset(x: -70, y: -100)
                
                TextField("Email", text: $email)
                    .foregroundColor(.white)
                    .textFieldStyle(.plain)
                    .placeholder(when: email.isEmpty) {
                        Text("Email")
                            .foregroundColor(.white)
                            .bold()
                    }
                
                Rectangle()
                    .frame(width: 350, height: 1)
                    .foregroundColor(.white)
                
                SecureField("Password", text: $password)
                    .foregroundColor(.white)
                    .textFieldStyle(.plain)
                    .placeholder(when: password.isEmpty) {
                        Text("Password")
                            .foregroundColor(.white)
                            .bold()
                    }
                
                Rectangle()
                    .frame(width: 350, height: 1)
                    .foregroundColor(.white)
                
                Button {
                    register()
                } label: {
                    Text("Sign up")
                        .bold()
                        .frame(width: 200, height: 40)
                        .background(
                            RoundedRectangle(cornerRadius: 10, style: .continuous)
                                .fill(.linearGradient(colors: [.purple, .pink], startPoint: .top, endPoint: .bottomTrailing))
                        )
                        .foregroundColor(.white)
                }
                
                .padding(.top)
                .offset(y: 100)
                
            
                
                Button {
                    login()
                } label: {
                    
                    NavigationLink(destination: LoginView(userIsLoggedIn: $userIsLoggedIn)) {
                        Text("Already have an account? ")
                            .bold()
                            .foregroundColor(.white)
                    }
                    
                }
                .padding(.top)
                .offset(y: 110)

            }
            .onAppear {
                isUserLoggedIn()}
            .frame(width: 350)
            .onAppear {
                Auth.auth().addStateDidChangeListener { auth, user in
                    if user != nil {
                        userIsLoggedIn.toggle()
                    }
                }
            }
        }
        .ignoresSafeArea()
    }
    
    func login() {
        Auth.auth().signIn(withEmail: email, password: password) { result, error in
            if error != nil {
                print(error!.localizedDescription)
            }
        }
    }
    
    
    func register() {
        Auth.auth().createUser(withEmail: email, password: password) { result, error in
            if let error = error {
                print(error.localizedDescription)
            } else {
                
                print("Registration successful")
                
                
                email = ""
                password = ""
                
                // Show a popup message
                showAlert = true
                    }
                }
            }
        
    

    
    func logout() {
        do {
            try Auth.auth().signOut()
            isUserLoggedIn()
        } catch let signOutError as NSError {
            print("Error signing out: \(signOutError.localizedDescription)")
        }
    }
    
}


    


struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}

extension View {
    func placeholder<Content: View>(
        when shouldShow: Bool,
        alignment: Alignment = .leading,
        @ViewBuilder placeholder: () -> Content) -> some View {

        ZStack(alignment: alignment) {
            placeholder().opacity(shouldShow ? 1 : 0)
            self
        }
    }
}
