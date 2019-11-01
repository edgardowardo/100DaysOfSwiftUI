//
//  Game.swift
//  MooTable
//
//  Created by EDGARDO AGNO on 01/11/2019.
//  Copyright © 2019 EDGARDO AGNO. All rights reserved.
//

import SwiftUI

struct Game {
    let questionsCount: Int
    let friendsCount: Int
    let mooCount: Int
    let questions: [Question]

    init(questionsCount: Int,
         friendsCount: Int) {

        self.questionsCount = questionsCount
        
        if questionsCount == .max {
            self.mooCount = 12
            self.friendsCount = 12
        } else {
            self.mooCount = Int.random(in: 1...12)
            self.friendsCount = friendsCount
        }

        var questions = [Question]()
        for i in 0 ..< self.friendsCount {
            for j in 0 ..< self.mooCount {
                questions.append(.init(friendsCount: i+1,
                                       mooCount: j+1,
                                       maxAnswer: self.friendsCount * self.mooCount))
            }
        }
        questions.shuffle()
        
        if questionsCount == .max {
            self.questions = questions
        } else {
            self.questions = Array(questions.prefix(questionsCount))
        }
    }
}
