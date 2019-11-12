//
//  Mission.swift
//  Moonshot
//
//  Created by EDGARDO AGNO on 12/11/2019.
//  Copyright © 2019 EDGARDO AGNO. All rights reserved.
//

import Foundation

struct Mission: Codable, Identifiable {
    let id: Int
    let launchDate: String?
    let crew: [CrewRole]
    let description: String
}

extension Mission {
    struct CrewRole: Codable {
        let name: String
        let role: String
    }
}
