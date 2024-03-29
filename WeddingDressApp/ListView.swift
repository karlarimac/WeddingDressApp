//
//  ListView.swift
//  WeddingDressApp
//
//  Created by Karla Rimac on 08.12.2023..
//
import SwiftUI


struct ListView: View {
    @EnvironmentObject var dataManager: DataManager
    @State private var selectedDress: Dress? = nil
    @State private var isLoading: Bool = true

    var body: some View {
        NavigationView {
            Group {
                if isLoading {
                    LoadingView()
                } else {
                    List(dataManager.dresses) { dress in
                        NavigationLink(destination: DressDetailView(dress: dress)) {
                            ZStack {
                                LinearGradient(gradient: Gradient(colors: [.pink, .purple]), startPoint: .leading, endPoint: .trailing)
                                    .cornerRadius(12)
                                
                                Text(dress.name)
                                    .font(.headline)
                                    .padding(10)
                                    .foregroundColor(.white)
                            }
                            .frame(maxWidth: .infinity, alignment: .leading)
                            .padding(EdgeInsets(top: 5, leading: 10, bottom: 5, trailing: 10))
                        }
                    }.listRowInsets(EdgeInsets())
                }
            }
            .navigationTitle("Dresses")
            .navigationBarItems(trailing: HStack {
                NavigationLink(destination: UserProfileView(email: ContentView().email, onLogout: {
                  
                })) {
                    Image(systemName: "person.circle")
                        .foregroundColor(.black)
                        .font(.title)
                }
            })
        }
        .background(LinearGradient(gradient: Gradient(colors: [.black, .purple]), startPoint: .top, endPoint: .bottom))
        .edgesIgnoringSafeArea(.all)
        .onAppear {
           
            DispatchQueue.main.asyncAfter(deadline: .now() + 2) {
                isLoading = false
            }
        }
    }
}

struct LoadingView: View {
    @State private var dots = ""

    var body: some View {
        
        VStack {
            Spacer()
            Text("Loading\(dots)")
                .font(.headline)
                .offset(y: -100)
                .foregroundColor(.purple)
                .onAppear {
                    animateDots()
                }
            Spacer()
        }
        .frame(width: 500, height: 1000)
        .background(Color.black)
    }

    func animateDots() {
        for index in 0...4 {
            DispatchQueue.main.asyncAfter(deadline: .now() + Double(index) * 0.5) {
                dots += "."
            }
        }
    }
}



struct DressDetailView: View {
    var dress: Dress

    var body: some View {
        VStack(spacing: 20) {
            InfoContainer(title: "Name", content: dress.name, backgroundColor: .white)
            InfoContainer(title: "Color", content: dress.color, backgroundColor: .white)
            InfoContainer(title: "Description", content: dress.description, backgroundColor: .white, foregroundColor: .black)


            Spacer()
        }
        .padding()
        .background(LinearGradient(gradient: Gradient(colors: [.pink, .purple]), startPoint: .top, endPoint: .bottom))
        .cornerRadius(20)
        .shadow(radius: 5)
        .navigationTitle("Dress Details")
    }
}

struct InfoContainer: View {
    var title: String
    var content: String
    var backgroundColor: Color
    var foregroundColor: Color = .black

    var body: some View {
        HStack {
            Text("\(title):")
                .font(.headline)
                .foregroundColor(foregroundColor)
                .padding(.trailing, 5)

            Text(content)
                .font(.subheadline)
                .foregroundColor(foregroundColor)
        }
        .padding(10)
        .background(backgroundColor)
        .cornerRadius(12)
        .overlay(
            RoundedRectangle(cornerRadius: 12)
                .stroke(Color.black, lineWidth: 2)
        )
    }
}

struct ListView_Previews: PreviewProvider {
    static var previews: some View {
        NavigationView {
            ListView()
                .environmentObject(DataManager())
        }
    }
}
