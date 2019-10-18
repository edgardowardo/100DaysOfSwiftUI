//
//  ContentView.swift
//  RockPaperScissors
//
//  Created by EDGARDO AGNO on 18/10/2019.
//  Copyright © 2019 EDGARDO AGNO. All rights reserved.
//

import SwiftUI

struct ContentView: View {
    let moves = ["💍","🧻","✂️"]
    @State private var score = 0
    @State private var questionCount = 0
    @State private var appMove = Int.random(in: 0...2)
    @State private var shouldWin = false
    @State private var scoreTitle = ""
    @State private var showAlert = false
    @State private var message = ""
    
    var body: some View {
        ZStack {
            VStack(spacing: 50) {
                Text("App's move")
                Text(showAlert ? moves[appMove] : "❓")
                Text("Choose your move")
                ForEach(0 ..< 3) { index in
                    Button(action: {
                        self.tapped(index)
                    }) {
                        Text(self.moves[index])
                    }
                }
                Text("Your score is \(score) / \(questionCount)")
                    .font(.callout)
            }
        }
        .alert(isPresented: $showAlert) {
                Alert(title: Text(scoreTitle),
                      message: Text(message),
                      dismissButton:.default(Text("Continue")) {
                    self.askQuestion()
                })
            }
        .font(.largeTitle)

    }
    
    private func tapped(_ index: Int) {
        questionCount += 1
        let userMove = index
        if userMove == 0 && appMove == 2 {
            shouldWin = true
        } else if appMove == 0 && userMove == 2 {
            shouldWin = false
        } else {
            shouldWin = (appMove < userMove)
        }
        score += shouldWin ? 1 : 0
        if appMove == userMove {
            scoreTitle = "Draw 🎨"
            message = "You both picked \(moves[appMove])"
        } else {
            scoreTitle = shouldWin ? "You're a winner baby! ✅" :  "Sachay away! ❌"
            let result = shouldWin ? "wins" : "loses"
            message = "Your \(moves[userMove]) \(result) against \(moves[appMove])"
        }
        showAlert = true
    }
    
    func askQuestion() {
        appMove = Int.random(in: 0...2)
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
