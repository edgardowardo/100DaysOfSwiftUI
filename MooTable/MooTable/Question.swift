//
//  Question.swift
//  MooTable
//
//  Created by EDGARDO AGNO on 01/11/2019.
//  Copyright © 2019 EDGARDO AGNO. All rights reserved.
//

import SwiftUI

struct Question {
    let friendsCount: Int
    let mooCount: Int
}

extension Question: Hashable {
    static func == (lhs: Question, rhs: Question) -> Bool {
        return lhs.friendsCount == rhs.friendsCount && lhs.mooCount == rhs.mooCount
    }
}
