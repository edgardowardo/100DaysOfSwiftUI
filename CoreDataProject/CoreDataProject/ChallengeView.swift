//
//  ChallengeView.swift
//  CoreDataProject
//
//  Created by EDGARDO AGNO on 21/11/2019.
//  Copyright © 2019 EDGARDO AGNO. All rights reserved.
//

import SwiftUI


struct ChallengeView: View {
    
    @Environment(\.managedObjectContext) var moc

    @State var indexOfSort = 0
    @State var isAscending = true
    let sortOrders = [("First name", \Singer.firstName), ("Last name", \Singer.lastName)]

    @State var indexOfFilter = 0
    @State var filterValue = "S"
    let filters = NSPredicate.Operator.allCases
      
    var body: some View {
        Form {

            Section(header: Text("Sort order")) {
                Picker("Sort by", selection: $indexOfSort) {
                    ForEach(0..<sortOrders.count) {
                        Text("\(self.sortOrders[$0].0)")
                    }
                }
                .pickerStyle(SegmentedPickerStyle())

                Toggle(isOn: $isAscending) {
                    Text("Ascending")
                }
            }
            
            Section(header: Text("Filter")) {
                Picker("Filter by", selection: $indexOfFilter) {
                    ForEach(0..<filters.count) {
                        Text("\(self.filters[$0].displayedString)")
                    }
                }
                .pickerStyle(SegmentedPickerStyle())
                
                TextField("Value", text: $filterValue)
            }
            
            Section(header: Text("Singers")) {
                FilteredList(filterKey: "lastName",
                             filterValue: filterValue,
                             filterOperator: filters[indexOfFilter],
                             sortDescriptors: [ NSSortDescriptor(keyPath: sortOrders[indexOfSort].1,
                                                                 ascending: isAscending)])
                { (singer: Singer) in
                    Text("\(singer.wrappedFirstName) \(singer.wrappedLastName)")
                }
            }
        }
        .navigationBarTitle("Day 59 Challenge", displayMode: .inline)
    }
}

struct ChallengeView_Previews: PreviewProvider {
    static var previews: some View {
        ChallengeView()
    }
}
