//
//  SingersView.swift
//  CoreDataProject
//
//  Created by EDGARDO AGNO on 20/11/2019.
//  Copyright © 2019 EDGARDO AGNO. All rights reserved.
//

import SwiftUI

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

struct SingersView: View {
    
    @Environment(\.managedObjectContext) var moc
    @State var lastNameFilter = "A"
    
    var body: some View {
        VStack {
            FilteredListView(filter: lastNameFilter)
            
            Button("Add Examples") {
                let taylor = Singer(context: self.moc)
                taylor.firstName = "Taylor"
                taylor.lastName = "Swift"
                
                let ed = Singer(context: self.moc)
                ed.firstName = "Ed"
                ed.lastName = "Sheeran"
                
                let adele = Singer(context: self.moc)
                adele.firstName = "Adele"
                adele.lastName = "Adkins"
                
                try? self.moc.save()
            }
            
            Button("Show A") {
                self.lastNameFilter = "A"
            }
            
            Button("Show S") {
                self.lastNameFilter = "S"
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
