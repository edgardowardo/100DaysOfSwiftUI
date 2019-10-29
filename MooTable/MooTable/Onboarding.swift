//
//  Onboarding.swift
//  MooTable
//
//  Created by EDGARDO AGNO on 29/10/2019.
//  Copyright © 2019 EDGARDO AGNO. All rights reserved.
//

import SwiftUI

struct Onboarding: View {
    var body: some View {
        VStack {
            Spacer()
            Image("cow")
            Text("Good mooorning! \n My name is Mama moo!")
                .font(.title)
                .multilineTextAlignment(.center)
            Spacer()
            Text("Click anywhere to continue")
        }
        .padding()
    }
}

struct Onboarding_Previews: PreviewProvider {
    static var previews: some View {
        Onboarding()
    }
}
