//
//  DecisionView.swift
//  MooTable
//
//  Created by EDGARDO AGNO on 29/10/2019.
//  Copyright © 2019 EDGARDO AGNO. All rights reserved.
//

import SwiftUI

struct DecisionView: View {
    let yesTitle: String
    let noTitle: String
    let yesHandler: ()->Void
    let noHandler: ()->Void
    
    var body: some View {
        VStack {
            Spacer()
            HStack {
                Button(action: yesHandler) {
                    Text("\(yesTitle) ✅")
                        .fontWeight(.bold)
                }.foregroundColor(.green)
                Spacer()
                Button(action: noHandler) {
                    Text("\(noTitle) ❌")
                        .fontWeight(.bold)
                }.foregroundColor(.red)
            }
            .padding()
        }
        .transition(.opacity)
    }
}

struct DecisionView_Previews: PreviewProvider {
    static var previews: some View {
        DecisionView(yesTitle: "Moo", noTitle: "Boo", yesHandler: {
            print("yes")
        }) {
            print("no")
        }
    }
}
