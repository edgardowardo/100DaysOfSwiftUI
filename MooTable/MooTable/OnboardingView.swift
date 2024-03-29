//
//  OnboardingView.swift
//  MooTable
//
//  Created by EDGARDO AGNO on 29/10/2019.
//  Copyright © 2019 EDGARDO AGNO. All rights reserved.
//

import SwiftUI

private let intro = """
Hi! I'm Mama Moo.
I moo a lot with my family.
Can you mooltiply and count our moos?
"""

private let stepperText = """
Moorvellous! Click + to meet my family
"""

private let pickerText = """
How many questions?
"""

struct OnboardingView: View {
    @State internal var lines = ["", ""]
    
    @State private var showMooBoo = false
    @State private var showStart = false
    @State private var showGame = false

    @State private var showQuestionsCount = false
    @State private var indexQuestions = 0
    let questionCounts = [5, 10, 20, .max]

    @State private var showFriends = false
    @State private var friendsCount = 4
    
    var body: some View {
        ZStack {
            VStack(spacing: 50) {
                if !showGame {
                    Spacer()
                }

                HStack {
                    Spacer()
                    Image("cow")
                        .resizable()
                        .frame(width: showGame ? 30 : 150, height: showGame ? 30 : 150)
                        .opacity(showGame ? 0 : 1)
                    if !showGame {
                        Spacer()
                    }
                }

                VStack(spacing: 10) {
                    Text(lines[0])
                        .fontWeight(.heavy)
                        .animation(nil)
                    
                    if showFriends {
                        VStack(spacing: 20) {
                            Stepper(value: $friendsCount, in: 1...11) {
                                FriendsView(showCount: true,
                                            friendsCount: friendsCount)
                            }
                        }
                    }
                }

                VStack {
                    Text(lines[1])
                        .fontWeight(.heavy)
                        .animation(nil)
                    if showQuestionsCount {
                        Picker("Questions", selection: $indexQuestions) {
                               ForEach(0 ..< questionCounts.count) {
                                   Text("\(self.questionCounts[$0] == .max ? "All" : "\(self.questionCounts[$0] )")")
                               }
                           }
                           .pickerStyle(SegmentedPickerStyle())
                    }
                }
                
                Spacer()
            }
            if showMooBoo {
                DecisionView(yesTitle: "Mooltiply", noTitle: "Boo", yesHandler: countMoos) {}
            }
            if showStart {
                DecisionView(yesTitle: "Start", noTitle: "Cancel", yesHandler: startGame) {}
            }
            if showGame {
                GameView(game: Game(questionsCount: self.questionCounts[self.indexQuestions],
                                    friendsCount: self.friendsCount + 1))
            }
        }
        .onAppear(perform: appear)
        .multilineTextAlignment(.center)
        .font(.title)
        .padding()
        .animation(.default)
    }
}

extension OnboardingView: AnimatableParagraph {
    func append(_ char: String.Element, at index: Int) {
        lines[index].append(char)
    }
}

extension OnboardingView {
    
    func startGame() {
        showStart = false
        showQuestionsCount = false
        showFriends = false
        lines[0] = ""
        lines[1] = ""
        showGame = true
    }
    
    func showStepper() {
        self.append(stepperText, at: 0)
        self.showMooBoo = false
        DispatchQueue.main.asyncAfter(deadline: .now() + Double(stepperText.count) * typeDelay) {
            withAnimation {
                self.showFriends = true
                self.append(pickerText, at: 1)
            }
            DispatchQueue.main.asyncAfter(deadline: .now() + Double(pickerText.count) * typeDelay) {
                withAnimation {
                    self.showQuestionsCount = true
                    self.showStart = true
                }
            }
        }
    }
    
    func countMoos() {
        withAnimation {
            self.lines[0] = ""
            DispatchQueue.main.asyncAfter(deadline: .now() + 0.75, execute: showStepper)
        }
    }
    
    func appear() {
        append(intro, at: 0)
        
        DispatchQueue.main.asyncAfter(deadline: .now() + Double(intro.count) * typeDelay) {
            withAnimation {
                self.showMooBoo = true
            }
        }
    }
}

struct Onboarding_Previews: PreviewProvider {
    static var previews: some View {
        OnboardingView()
    }
}
