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
    @State private var isShowingFlags = false

    var body: some View {
        return ZStack {
            Color.clear.edgesIgnoringSafeArea(.all)
                .overlay(Color.clear.modifier(AnimatableGradient(from: AnswerResult.none.gradient, to: state.gradient, pct: isAnswered ? 1 : 0 )))
                .animation(.easeInOut(duration: 1))
            
            VStack(spacing: 30 ) {

                HeaderView(countryQuery: countries[correctAnswer], score: score, questionCount: questionCount)
                
                if isShowingFlags {
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
                        .opacity(self.flagOpacity(for: number))
                        .transition(.opacity)
                        .animation(.default)
                    }
                }
                Spacer()
                if isAnswered {
                    VStack {
                        Text("\(state.scoreTitle)!, that's the flag of \(countries[indexTapped])")
                            .font(.largeTitle)
                            .fontWeight(.black)
                            .multilineTextAlignment(.center)
                            .padding()
                        Button("Continue") {
                            self.isShowingFlags = false
                            DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) {
                                self.askQuestion()
                                self.isShowingFlags = true
                            }
                        }
                        .foregroundColor(.blue)
                    }
                    .animation(.default)
                }
            }
            .foregroundColor(.white)
            .onAppear {
                self.isShowingFlags = true
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
