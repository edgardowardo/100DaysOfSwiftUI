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
Can you "moo"ltiply and count our moos?
"""

private let stepperText = """
Moorvellous!
Click + to meet my friends
and select the number of questions
"""

struct Onboarding: View {
    @State private var mamaMooSays = ""
    @State private var showMooBoo = false
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
            VStack(spacing: 20) {
                Spacer()
                
                Image("cow")
                    .animation(.default)
                
                Text(mamaMooSays)
                    .fontWeight(.heavy)
                    .animation(nil)

                if showFriends {
                    VStack(spacing: 20) {
                        Stepper(value: friendsCountShim, in: 1...11) {
                            FriendsView(friendsCount: friendsCount, friends: friends)
                        }
                    }
                    .animation(.default)
                }
                
                Spacer()
            }
            if showMooBoo {
                DecisionView(yesHandler: {
                    withAnimation {
                        self.mamaMooSays = ""
                        DispatchQueue.main.asyncAfter(deadline: .now() + 0.75) {
                            self.append(stepperText)
                            self.showMooBoo = false
                            DispatchQueue.main.asyncAfter(deadline: .now() + Double(stepperText.count) * typeDelay) {
                                withAnimation {
                                    self.showFriends = true
                                }
                            }
                        }
                    }
                }) {
                    print("no")
                }
            }
        }
        .onAppear(perform: appear)
        .multilineTextAlignment(.center)
        .font(.title)
        .padding()
    }
}

private let typeDelay = 0.01

extension Onboarding {
    
    func appear() {
        append(intro)
        
        DispatchQueue.main.asyncAfter(deadline: .now() + Double(intro.count) * typeDelay) {
            withAnimation {
                self.showMooBoo = true
            }
        }
    }
    
    func append(_ text: String) {
        guard !text.isEmpty
            else { return }
        var arrayText = Array(text)
        mamaMooSays.append(arrayText[0])
        arrayText.removeFirst()
        DispatchQueue.main.asyncAfter(deadline: .now() + typeDelay) {
            self.append(String(arrayText))
        }
    }
}

struct Onboarding_Previews: PreviewProvider {
    static var previews: some View {
        Onboarding()
    }
}
