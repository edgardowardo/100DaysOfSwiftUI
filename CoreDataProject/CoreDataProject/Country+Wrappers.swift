//
//  Country+Wrappers.swift
//  CoreDataProject
//
//  Created by EDGARDO AGNO on 20/11/2019.
//  Copyright © 2019 EDGARDO AGNO. All rights reserved.
//

import Foundation

extension Country {
    public var wrappedShortName: String {
        shortName ?? "Unknown Country"
    }

    public var wrappedFullName: String {
        fullName ?? "Unknown Country"
    }
    
    public var candyArray: [Candy] {
        let set = candy as? Set<Candy> ?? []
        return set.sorted {
            $0.wrappedName < $1.wrappedName
        }
    }
}
