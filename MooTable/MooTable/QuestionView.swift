//
//  QuestionView.swift
//  MooTable
//
//  Created by EDGARDO AGNO on 02/11/2019.
//  Copyright © 2019 EDGARDO AGNO. All rights reserved.
//

import SwiftUI

struct QuestionView: View {
    let question: Question
    @State internal var lines = [""]

    var body: some View {
        VStack {
            FriendsView(showCount: false,
                        friendsCount: question.friendsCount)
            Text(lines[0])
            HStack {
                ForEach(question.choices, id: \.self) { choice in
                    Button(action: {
                        print("\(choice)")
                    }) {
                        Text("\(choice)")
                    }
                }
            }
        }
        .onAppear {
            self.lines[0] = "\(self.question.friendsCount) mooltiply by \(self.question.mooCount) moos is"
//            self.append("\(self.question.friendsCount) mooltiply by \(self.question.mooCount) moos is", at: 0)
        }
    }
}

extension QuestionView: AnimatableParagraph {
    func append(_ char: String.Element, at index: Int) {
        lines[index].append(char)
    }
}

struct QuestionView_Previews: PreviewProvider {
    static var previews: some View {
        let question = Question(friendsCount: 12, mooCount: 12, maxAnswer: 144)
        return QuestionView(question: question)
    }
}
