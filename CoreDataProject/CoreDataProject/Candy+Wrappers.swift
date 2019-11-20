//
//  Candy+Wrappers.swift
//  CoreDataProject
//
//  Created by EDGARDO AGNO on 20/11/2019.
//  Copyright © 2019 EDGARDO AGNO. All rights reserved.
//

import Foundation

extension Candy {
    public var wrappedName: String {
        name ?? "Unknown Candy"
    }
}
