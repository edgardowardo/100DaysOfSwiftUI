//
//  ContentView.swift
//  Day60FriendFace
//
//  Created by EDGARDO AGNO on 22/11/2019.
//  Copyright © 2019 EDGARDO AGNO. All rights reserved.
//

import SwiftUI

struct ContentView: View {
        
    @Environment(\.managedObjectContext) var moc
    @State var showActive = true
    @State var showFilters = false
    
    var body: some View {
        NavigationView {
            Form {
                if showFilters {
                    Section(header: Text("Filters")) {
                        Toggle("Show active", isOn: $showActive)
                    }
                }
                Section {
                    FilteredListView(
                        filterKey: "name",
                        filterValue: "A",
                        filterOperator: .all,
                        sortDescriptors: [NSSortDescriptor(keyPath: \User.name,
                                                           ascending: true)])
                    { (user: User) in
                        NavigationLink(destination: Text("\(user.wrappedName)")) {
                            VStack(alignment: .leading) {
                                Text(user.wrappedName)
                                    .font(.headline)
                                Text(user.wrappedCompany)
                            }
                        }
                    }
                }
            }
            .onAppear(perform: loadData)
            .navigationBarTitle("Friendly Faces")
            .navigationBarItems(trailing: Button(action: {
                self.showFilters.toggle()
            }) {
                Image(systemName: "line.horizontal.3.decrease.circle\(self.showFilters ? ".fill" : "")")
            })
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
                if let decodedResponse = try? JSONDecoder().decode([UserJSON].self, from: data) {
                    DispatchQueue.main.async {
                        _ = decodedResponse.map{ $0.user(for: self.moc) }
                        try? self.moc.save()
                    }
                    return
                }
            }
            print("Fetch failed: \(error?.localizedDescription ?? "Unknown error")")
        }.resume()
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
