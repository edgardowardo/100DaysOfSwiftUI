//
//  SingersView.swift
//  CoreDataProject
//
//  Created by EDGARDO AGNO on 20/11/2019.
//  Copyright © 2019 EDGARDO AGNO. All rights reserved.
//

import SwiftUI
import CoreData

extension Singer {
    var wrappedFirstName: String { firstName ?? "Unknown" }
    var wrappedLastName: String { lastName ?? "Unknown" }
}

struct FilteredListView: View {
    var fetchRequest: FetchRequest<Singer>
    
    init(filter: String) {
        fetchRequest = FetchRequest<Singer>(entity: Singer.entity(), sortDescriptors: [], predicate: NSPredicate(format: "lastName BEGINSWITH %@", filter))
    }
    
    var body: some View {
        List(fetchRequest.wrappedValue, id: \.self) { singer in
            Text("\(singer.wrappedFirstName) \(singer.wrappedLastName)")
        }
    }
}

struct FilteredList<T: NSManagedObject, Content: View>: View {
        
    var fetchRequest: FetchRequest<T>
    var objects: FetchedResults<T> { fetchRequest.wrappedValue }

    // this is our content closure; we'll call this once for each item in the list
    let content: (T) -> Content

    var body: some View {
        List(objects, id: \.self) { singer in
            self.content(singer)
        }
    }

    init(filterKey: String,
         filterValue: String,
         filterOperator: NSPredicate.Operator,
         sortDescriptors: [NSSortDescriptor],
         @ViewBuilder content: @escaping (T) -> Content) {
                
        fetchRequest = FetchRequest<T>(entity: T.entity(),
                                       sortDescriptors: sortDescriptors,
                                       predicate: (filterOperator == .all) ? nil : NSPredicate(format: "%K \(filterOperator.rawValue) %@",
                                        filterKey, filterValue))
        self.content = content
    }
}

extension NSPredicate {
    enum Operator: String, CaseIterable {
        case all = "ALL"
        case begins = "BEGINSWITH"
        case contains = "CONTAINS"
        case equal = "=="
    }
}

extension NSPredicate.Operator {
    var displayedString: String {
        switch self {
        case .all: return "All"
        case .begins: return "Begins with"
        case .contains: return "Containing"
        case .equal: return "Equals"
        }
    }
}

struct SingersView: View {
    
    @Environment(\.managedObjectContext) var moc
    @State var lastNameFilter = "A"
    
    var body: some View {
        Form {

            Section(header: Text("Filtered Singers")) {
                FilteredListView(filter: lastNameFilter)
            }
            
            Section(header: Text("Filtered Generics")) {
                FilteredList(filterKey: "lastName", filterValue: lastNameFilter, filterOperator: .begins, sortDescriptors: []) { (singer: Singer) in
                    Text("\(singer.wrappedFirstName) \(singer.wrappedLastName)")
                }
            }

            Section(header: Text("Options")) {
                Button("Add Examples") {
                    let appleSisters = Singer(context: self.moc)
                    appleSisters.firstName = "Appleton"
                    appleSisters.lastName = "Sisters"
                    
                    let samsmith = Singer(context: self.moc)
                    samsmith.firstName = "Sam"
                    samsmith.lastName = "Smith"
                    
                    let taylor = Singer(context: self.moc)
                    taylor.firstName = "Taylor"
                    taylor.lastName = "Swift"

                    let ed = Singer(context: self.moc)
                    ed.firstName = "Ed"
                    ed.lastName = "Sheeran"

                    let adele = Singer(context: self.moc)
                    adele.firstName = "Adele"
                    adele.lastName = "Adkins"
                    
                    let abba = Singer(context: self.moc)
                    abba.firstName = "Abba"
                    abba.lastName = "Abba"
                    
                    try? self.moc.save()
                }
                
                Button("Show A") {
                    self.lastNameFilter = "A"
                }
                
                Button("Show S") {
                    self.lastNameFilter = "S"
                }
            }
        }
        .navigationBarTitle("Singers Predicate", displayMode: .inline)
    }
}

struct SingersView_Previews: PreviewProvider {
    static var previews: some View {
        SingersView()
    }
}
