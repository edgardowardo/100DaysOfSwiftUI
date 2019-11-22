//
//  FilteredListView.swift
//  Day60FriendFace
//
//  Created by EDGARDO AGNO on 22/11/2019.
//  Copyright © 2019 EDGARDO AGNO. All rights reserved.
//

import SwiftUI
import CoreData

struct FilteredListView<T: NSManagedObject, Content: View>: View {
        
    var fetchRequest: FetchRequest<T>
    var objects: FetchedResults<T> { fetchRequest.wrappedValue }

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
