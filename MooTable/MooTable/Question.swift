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
    let maxAnswer: Int
    let answer: Int
    let choices: [Int]
    var playerAnswer: Int?
    
    init(friendsCount: Int,
         mooCount: Int,
         maxAnswer: Int) {
        self.friendsCount = friendsCount
        self.mooCount = mooCount
        let answer = friendsCount * mooCount
        self.answer = answer
        self.maxAnswer = maxAnswer
        var tempChoices = [Int](repeatElement(0, count: maxAnswer)).enumerated().compactMap { answer == $0.offset + 1 ? nil : $0.offset + 1  }
        tempChoices.shuffle()
        var arrayChoices = Array(tempChoices.prefix(2))
        arrayChoices.append(answer)
        arrayChoices.shuffle()
        self.choices = arrayChoices
    }
}

extension Question: Hashable {
    static func == (lhs: Question, rhs: Question) -> Bool {
        return lhs.friendsCount == rhs.friendsCount && lhs.mooCount == rhs.mooCount
    }
}
