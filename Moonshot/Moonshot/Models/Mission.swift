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
    let launchDate: Date?
    let crew: [CrewRole]
    let description: String
}

extension Mission {
    struct CrewRole: Codable {
        let name: String
        let role: String
    }
}

extension Mission {
    var displayName: String {
        "Apollo \(id)"
    }

    var image: String {
        "apollo\(id)"
    }
    
    var formattedLaunchDate: String {
        if let launchDate = launchDate {
            let formatter = DateFormatter()
            formatter.dateStyle = .long
            return formatter.string(from: launchDate)
        } else {
            return "N/A"
        }
    }
}
