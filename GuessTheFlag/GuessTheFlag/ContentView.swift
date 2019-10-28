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
    @State private var questionCount = 0
    @State private var score = 0
    @State private var indexTapped = 0
    @State private var state = AnswerResult.none

    var body: some View {
        print("state=\(state)")
        return ZStack {
            Color.clear.edgesIgnoringSafeArea(.all)
                .overlay(Color.clear.modifier(AnimatableGradient(from: AnswerResult.none.gradient, to: state.gradient, pct: state == .none ? 0 : 1 )))
            
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
                    .clipShape(Rectangle())
                    .overlay(Rectangle().stroke(Color.black, lineWidth: 1))
                    .shadow(color: .black, radius: 2)
                    .opacity(self.flagOpacity(for: number))
                    .rotation3DEffect(.degrees(self.rotationAmount(for: number)), axis: (x: 0, y: 1, z: 0), anchor: .leading, anchorZ: 0, perspective: 0.5)
                }
                Text("Your score is \(score) / \(questionCount)")
                    .foregroundColor(.white)
                Spacer()
                if !state.scoreTitle.isEmpty {
                    Text("\(state.scoreTitle)!, that's the flag of \(countries[indexTapped])")
                        .foregroundColor(.white)
                        .font(.largeTitle)
                        .fontWeight(.black)
                        .multilineTextAlignment(.center)
                        .padding()
                    Button("Continue") {
                        withAnimation(.easeInOut(duration: 1.0)) {
                            self.askQuestion()
                        }
                    }
                }
            }
        }
    }
    
    func flagTapped(_ index: Int) {
        indexTapped = index
        questionCount += 1
        if index == correctAnswer {
            score += 1
            state = .win
        } else {
            state = .lose
        }
    }
    
    func askQuestion() {
        countries.shuffle()
        correctAnswer = Int.random(in: 0...2)
        state = .none
    }
    
    func flagOpacity(for index: Int) -> Double {
        guard state != .none
            else { return 1 }
        return index == correctAnswer ? 1 : 0.25
    }
    
    func rotationAmount(for index: Int) -> Double {
        print("index=\(index) == correctAnswer=\(correctAnswer); state=\(state)")
        switch state {
        case .none, .lose: return 0
        case .win: return index == correctAnswer ? 360 : 0
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
