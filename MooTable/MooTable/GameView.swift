//
//  GameView.swift
//  MooTable
//
//  Created by EDGARDO AGNO on 31/10/2019.
//  Copyright © 2019 EDGARDO AGNO. All rights reserved.
//

import SwiftUI

struct QuestionView: View {
    let question: Question

    var body: some View {
        VStack {
            FriendsView(showCount: false,
                        friendsCount: question.friendsCount)
        }
    }
}

struct GameView: View {
    let game: Game
    @State private var showStart = false
    @State private var showInstruct = false
    @State internal var lines = ["", ""]
    
    var body: some View {
        ZStack {
            VStack(spacing: 50) {
                if !showStart {
                    Spacer()
                }
                
                FriendsView(showCount: false,
                            friendsCount: game.friendsCount)
                if showInstruct {
                    Text(lines[0])
                        .fontWeight(.heavy)
                        .animation(nil)
                }

                Spacer()
            }
        }.onAppear {
            self.showStart = true
            print("\(self.game.questionsCount) \(self.game.friendsCount) \(self.game.mooCount)")
            print("\(self.game)")
            
            DispatchQueue.main.asyncAfter(deadline: .now() + 0.5, execute: self.start)
        }
    }
}

extension GameView {
    func start() {
        showStart = true
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.75, execute: instruct)
    }
    
    func instruct() {
        showInstruct = true
        append(instruction, at: 0)
    }
    
    private var instruction: String {
        return  """
        If each of us moo \(game.mooCount) times. How many total moos are there?
        """
    }
}

extension GameView: AnimatableParagraph {
    func append(_ char: String.Element, at index: Int) {
        lines[index].append(char)
    }
}

struct GameView_Previews: PreviewProvider {
    static var previews: some View {
        let game = Game(questionsCount: 5, friendsCount: 5)
        return GameView(game: game)
    }
}
