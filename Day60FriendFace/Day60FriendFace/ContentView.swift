//
//  ContentView.swift
//  Day60FriendFace
//
//  Created by EDGARDO AGNO on 22/11/2019.
//  Copyright © 2019 EDGARDO AGNO. All rights reserved.
//

import SwiftUI

struct User: Codable, Identifiable {
    let id: String
    let isActive: Bool
    let name: String
    let age: Int
    let company: String
    let email: String
    let address: String
    let about: String
    let registered: String
    let tags: [String]
    let friends: [Friend]
}

extension User {
    struct Friend: Codable {
        let id: String
        let name: String
    }
}

struct ContentView: View {
    
    @State var users = [User]()
    
    var body: some View {
        NavigationView {
            List(users) { item in
                VStack(alignment: .leading) {
                    Text(item.name)
                        .font(.headline)
                    Text(item.company)
                }
            }
            .onAppear(perform: loadData)
            .navigationBarTitle("Friendly Faces")
        }
    }
}

extension ContentView {
    
    func loadData() {
           guard let url = URL(string: "https://www.hackingwithswift.com/samples/friendface.json") else {
               print("Invalid URL")
               return
           }
           
           let request = URLRequest(url: url)
           
           URLSession.shared.dataTask(with: request) { data, response, error in
               if let data = data {
                   if let decodedResponse = try? JSONDecoder().decode([User].self, from: data) {
                       // we have good data – go back to the main thread
                       DispatchQueue.main.async {
                           // update our UI
                           self.users = decodedResponse
                       }

                       // everything is good, so we can exit
                       return
                   }
               }

               // if we're still here it means there was a problem
               print("Fetch failed: \(error?.localizedDescription ?? "Unknown error")")
               
           }.resume()
       }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
