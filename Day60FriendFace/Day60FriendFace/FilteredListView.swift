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
        List(objects, id: \.self) { item in
            self.content(item)
        }
    }
    
    static private func predicateNamed(
        _ filterKey: String,
        _ filterValue: String,
        _ filterOperator: NSPredicate.Operator) -> NSPredicate {
        NSPredicate(format: "%K \(filterOperator.rawValue) %@", filterKey, filterValue)
    }
    
    static private func predicateFlag(
        _ flagKey: String,
        _ flagOperator: NSPredicate.FlagOperator) -> NSPredicate {
        let isActive = NSNumber( value: flagOperator == .all ? false : Bool.init(flagOperator.rawValue)! )
        return NSPredicate(format: "%K == %@", "isActive", isActive)
    }

    init(filterKey: String,
         filterValue: String,
         filterOperator: NSPredicate.Operator,
         flagKey: String,
         flagOperator: NSPredicate.FlagOperator,
         sortDescriptors: [NSSortDescriptor],
         @ViewBuilder content: @escaping (T) -> Content) {
                
        let predicate: NSPredicate?
        
        switch (filterOperator, flagOperator) {
        case (.all, .all):
            predicate = nil
        case (_, .all):
            predicate = Self.predicateNamed(filterKey, filterValue, filterOperator)
        case (.all, _):
            predicate = Self.predicateFlag(flagKey, flagOperator)
        default:
            let name = Self.predicateNamed(filterKey, filterValue, filterOperator)
            let flag = Self.predicateFlag(flagKey, flagOperator)
            predicate = NSCompoundPredicate.init(type: .and, subpredicates: [name, flag])
        }
        
        fetchRequest = FetchRequest<T>(entity: T.entity(),
                                       sortDescriptors: sortDescriptors,
                                       predicate: predicate)
        self.content = content
    }
}

extension NSPredicate {
    enum FlagOperator: String, CaseIterable {
        case all = "All"
        case `true` = "true"
        case `false` = "false"
    }
}

extension NSPredicate.FlagOperator {
    var displayedString: String {
        switch self {
        case .all: return "All"
        case .true: return "Active"
        case .false: return "Inactive"
        }
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
