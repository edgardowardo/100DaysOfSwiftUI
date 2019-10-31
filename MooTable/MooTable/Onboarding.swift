//
//  Onboarding.swift
//  MooTable
//
//  Created by EDGARDO AGNO on 29/10/2019.
//  Copyright © 2019 EDGARDO AGNO. All rights reserved.
//

import SwiftUI

private let intro = """
Hi! I'm Mama Moo.
I moo a lot with my friends.
Can you mooltiply and count our moos?
"""

private let stepperText = """
Moorvellous! Click + to meet my friends
"""

private let pickerText = """
then select the number of questions
"""

enum MamaSays {
    case mamaSays, mamaSays2
}

struct Onboarding: View {
    @State private var mamaMooSays = ""
    @State private var mamaMooSays2 = ""
    
    @State private var showMooBoo = false
    @State private var showStart = false

    @State private var showQuestionsCount = false
    @State private var indexQuestions = 0
    let questionCounts = [5, 10, 20, .max]

    @State private var showFriends = false
    @State private var friendsCount = 5
    @State private var friends = [Int](repeating: 0, count: 5)
    
    var body: some View {
        let friendsCountShim = Binding(
            get: { self.friendsCount },
            set: {
                if self.friendsCount < $0 {
                    self.friends.append(0)
                } else {
                    self.friends.removeLast()
                }
                self.friendsCount = $0
            }
        )
        return ZStack {
            VStack(spacing: 50) {
                Spacer()
                
                Image("cow")

                VStack(spacing: 10) {
                    Text(mamaMooSays)
                        .fontWeight(.heavy)
                        .animation(nil)
                    
                    if showFriends {
                        VStack(spacing: 20) {
                            Stepper(value: friendsCountShim, in: 1...11) {
                                FriendsView(friendsCount: friendsCount, friends: friends)
                            }
                        }
                    }
                }

                VStack {
                    Text(mamaMooSays2)
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
                DecisionView(yesTitle: "Count Moos", noTitle: "Boo", yesHandler: countMoos) {}
            }
            if showStart {
                DecisionView(yesTitle: "Start", noTitle: "Cancel", yesHandler: {}) {}
            }
        }
        .onAppear(perform: appear)
        .multilineTextAlignment(.center)
        .font(.title)
        .padding()
        .animation(.default)
    }
}

private let typeDelay = 0.1

extension Onboarding {
    
    func showStepper() {
        self.append(stepperText, mamaSays: .mamaSays)
        self.showMooBoo = false
        DispatchQueue.main.asyncAfter(deadline: .now() + Double(stepperText.count) * typeDelay) {
            withAnimation {
                self.showFriends = true
                self.append(pickerText, mamaSays: .mamaSays2)
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
            self.mamaMooSays = ""
            DispatchQueue.main.asyncAfter(deadline: .now() + 0.75, execute: showStepper)
        }
    }
    
    func appear() {
        append(intro, mamaSays: .mamaSays)
        
        DispatchQueue.main.asyncAfter(deadline: .now() + Double(intro.count) * typeDelay) {
            withAnimation {
                self.showMooBoo = true
            }
        }
    }
    
    func append(_ text: String, mamaSays: MamaSays) {
        guard !text.isEmpty
            else { return }
        var arrayText = Array(text)
        switch mamaSays {
        case .mamaSays: mamaMooSays.append(arrayText[0])
        case .mamaSays2: mamaMooSays2.append(arrayText[0])
        }
        arrayText.removeFirst()
        DispatchQueue.main.asyncAfter(deadline: .now() + typeDelay) {
            self.append(String(arrayText), mamaSays: mamaSays)
        }
    }
}

struct Onboarding_Previews: PreviewProvider {
    static var previews: some View {
        Onboarding()
    }
}
