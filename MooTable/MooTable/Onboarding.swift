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

private let moorvelous = """
Moorvellous!
Click + to meet my friends
"""

struct Onboarding: View {
    @State private var mamaMooSays = ""
    @State private var showMooBoo = false

    var body: some View {
        
        ZStack {
            VStack(spacing: 20) {
                Spacer()
                
                Image("cow")
                    .animation(.default)
                
                Text(mamaMooSays)
                    .fontWeight(.heavy)
                
                Spacer()
            }
            if showMooBoo {
                DecisionView(yesHandler: {
                    withAnimation {
                        self.mamaMooSays = ""
                        DispatchQueue.main.asyncAfter(deadline: .now() + 0.75) {
                            self.append(moorvelous)
                            self.showMooBoo = false
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

private let typeDelay = 0.1

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
