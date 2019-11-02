//
//  GameView.swift
//  MooTable
//
//  Created by EDGARDO AGNO on 31/10/2019.
//  Copyright © 2019 EDGARDO AGNO. All rights reserved.
//

import SwiftUI

struct GameView: View {
    let game: Game
    
    var body: some View {
        List(game.questions, id: \.self) {
            QuestionView(question: $0)
        }.onAppear {
            UITableView.appearance().separatorStyle = .none
            
            print("\(self.game.questionsCount) \(self.game.friendsCount) \(self.game.mooCount)")
            print("\(self.game)")
            
            DispatchQueue.main.asyncAfter(deadline: .now() + 0.5, execute: self.start)
        }
    }
}

extension GameView {
    func start() {

    }
}

struct GameView_Previews: PreviewProvider {
    static var previews: some View {
        let game = Game(questionsCount: 5, friendsCount: 5)
        return GameView(game: game)
    }
}
