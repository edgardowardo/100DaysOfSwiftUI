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
    @State private var isAnswered = false

    var body: some View {
        print("state=\(state)")
        return ZStack {
            Color.clear.edgesIgnoringSafeArea(.all)
                .overlay(Color.clear.modifier(AnimatableGradient(from: AnswerResult.none.gradient, to: state.gradient, pct: isAnswered ? 1 : 0 )))
                .animation(.easeInOut(duration: 1))
            
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
                .animation(nil)
                ForEach(0 ..< 3) { number in
                    Button(action: {
                        self.flagTapped(number)
                    }) {
                        Image(self.countries[number])
                            .renderingMode(.original)
                    }
                    .clipShape(Rectangle())
                    .overlay(Rectangle().stroke(Color.black, lineWidth: 1))
                    .shadow(color: .black, radius: 2)
                    .rotation3DEffect(.degrees(self.rotationAmount(for: number)), axis: (x: 0, y: 1, z: 0), anchor: .leading, anchorZ: 0, perspective: 0.5)
                    .animation(self.isAnswered ? .default : nil)
                    .opacity(self.flagOpacity(for: number))
                    .animation(.default)
                }
                Text("Your score is \(score) / \(questionCount)")
                    .foregroundColor(.white)
                Spacer()
                if isAnswered {
                    VStack {
                        Text("\(state.scoreTitle)!, that's the flag of \(countries[indexTapped])")
                            .foregroundColor(.white)
                            .font(.largeTitle)
                            .fontWeight(.black)
                            .multilineTextAlignment(.center)
                            .padding()
                        Button("Continue") {
                            self.askQuestion()
                        }
                    }
                    .animation(.default)
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
        isAnswered.toggle()
    }
    
    func askQuestion() {
        countries.shuffle()
        correctAnswer = Int.random(in: 0...2)
        isAnswered.toggle()
    }
    
    func flagOpacity(for index: Int) -> Double {
        guard isAnswered
            else { return 1 }
        return index == correctAnswer ? 1 : 0.25
    }
    
    func rotationAmount(for index: Int) -> Double {
        print("isAnswered=\(isAnswered); index=\(index) == correctAnswer=\(correctAnswer); state=\(state)")
        guard isAnswered
            else { return 0 }
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
