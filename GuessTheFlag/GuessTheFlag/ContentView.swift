//
//  ContentView.swift
//  GuessTheFlag
//
//  Created by EDGARDO AGNO on 14/10/2019.
//  Copyright © 2019 EDGARDO AGNO. All rights reserved.
//

import SwiftUI

struct ContentView: View {
    
    @State private var countries = ["Estonia", "France", "Germany", "Ireland", "Italy", "Nigeria", "Poland", "Russia", "Spain", "UK", "US"].shuffled()
    @State private var correctAnswer = Int.random(in: 0...2)
    @State private var showingScore = false
    @State private var scoreTitle = ""
    @State private var questionCount = 0
    @State private var score = 0
    @State private var indexTapped = 0
    @State private var state = AnswerResult.none
    @State private var animate = false

    var body: some View {
        return ZStack {
            Color.clear.edgesIgnoringSafeArea(.all)
                .overlay(Color.clear.modifier(AnimatableGradient(from: AnswerResult.none.gradient, to: state.gradient, pct: animate ? 1 : 0 )))
            
            VStack(spacing: 30 ) {
                VStack {
                    HStack {
                        Spacer()
                    }
                    Text("Tap the flag of")
                        .foregroundColor(.white)
                    Text(countries[correctAnswer])
                        .foregroundColor(.white)
                        .font(.largeTitle)
                        .fontWeight(.heavy)
                }
                ForEach(0 ..< 3) { number in
                    Button(action: {
                        withAnimation(.easeInOut(duration: 1.0)) {
                            self.flagTapped(number)
                        }
                    }) {
                        Image(self.countries[number])
                            .renderingMode(.original)
                    }
                    .clipShape(Capsule())
                    .overlay(Capsule().stroke(Color.black, lineWidth: 1))
                    .shadow(color: .black, radius: 2)
                }
                Text("Your score is \(score) / \(questionCount)")
                    .foregroundColor(.white)
                Spacer()
            }
        }
        .alert(isPresented: $showingScore) {
            Alert(title: Text(scoreTitle), message: Text("That's the flag of \(countries[indexTapped])"), dismissButton: .default(Text("Continue")) {
                withAnimation(.easeInOut(duration: 1.0)) {
                    self.askQuestion()
                }
            })
        }
    }
    
    func flagTapped(_ number: Int) {
        indexTapped = number
        questionCount += 1
        if number == correctAnswer {
            scoreTitle = "Correct"
            score += 1
            state = .win
        } else {
            scoreTitle = "Wrong"
            state = .lose
        }
        animate.toggle()
        showingScore = true
    }
    
    func askQuestion() {
        countries.shuffle()
        correctAnswer = Int.random(in: 0...2)
        animate.toggle()
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
