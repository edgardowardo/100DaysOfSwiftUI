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

    @State var showLoading = false
    @State var showFilters = false
    @State var filterValue = ""
    let filters = NSPredicate.Operator.allCases
    @State var indexOfFilter = 0
    let activeFilters = NSPredicate.FlagOperator.allCases
    @State var indexOfActiveFilter = 0

    var body: some View {
        LoadingView(isShowing: $showLoading) {
            NavigationView {
                Form {
                    if self.showFilters {
                        Section(header: Text("Filters")) {
                            
                            Picker("Active filter", selection: self.$indexOfActiveFilter) {
                                ForEach(0..<self.activeFilters.count) {
                                    Text("\(self.activeFilters[$0].displayedString)")
                                }
                            }
                            .pickerStyle(SegmentedPickerStyle())
                            
                            Picker("Filter by", selection: self.$indexOfFilter) {
                                ForEach(0..<self.filters.count) {
                                    Text("\(self.filters[$0].displayedString)")
                                }
                            }
                            .pickerStyle(SegmentedPickerStyle())
                            
                            TextField("Enter name to filter", text: self.$filterValue)
                        }
                    }
                    Section {
                        FilteredListView(
                            filterKey: "name",
                            filterValue: self.filterValue,
                            filterOperator: self.filters[self.indexOfFilter],
                            flagKey: "isActive",
                            flagOperator: self.activeFilters[self.indexOfActiveFilter],
                            sortDescriptors: [NSSortDescriptor(keyPath: \User.name,
                                                               ascending: true)])
                        { (user: User) in
                            NavigationLink(destination: UserDetailView(user: user)) {
                                HStack {
                                    InitialsView(name: user.wrappedName, isActive: user.isActive)
                                        .frame(width: 40, height: 40)
                                    VStack(alignment: .leading) {
                                        Text(user.wrappedName)
                                            .font(.headline)
                                        Text(user.wrappedCompany)
                                    }
                                }
                            }
                        }
                    }
                }
                .onAppear(perform: self.loadData)
                .navigationBarTitle("Friends")
                .navigationBarItems(trailing: Button(action: {
                    self.showFilters.toggle()
                }) {
                    Image(systemName: "line.horizontal.3.decrease.circle\(self.showFilters ? ".fill" : "")")
                })
            }
        }
    }
}

private let loadKey = "loadKey"

extension ContentView {
    
    func loadData() {
        guard UserDefaults.standard.string(forKey: loadKey) == nil
            else { return }
        
        guard let url = URL(string: "https://www.hackingwithswift.com/samples/friendface.json") else {
            print("Invalid URL")
            return
        }

        let request = URLRequest(url: url)
        showLoading = true
        
        URLSession.shared.dataTask(with: request) { data, response, error in
            if let data = data {
                if let decodedResponse = try? JSONDecoder().decode([UserJSON].self, from: data) {
                    DispatchQueue.main.async {
                        // map the users
                        let users = decodedResponse.map{ $0.user(for: self.moc) }
                        // assign the related friend's user that's just been created above
                        for user in users {
                            for friend in user.friendArray {
                                friend.friend = users.first { $0.wrappedId == friend.wrappedId }
                            }
                        }
                        try? self.moc.save()
                        
                        UserDefaults.standard.set("loaded", forKey: loadKey)
                        self.showLoading = false
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
