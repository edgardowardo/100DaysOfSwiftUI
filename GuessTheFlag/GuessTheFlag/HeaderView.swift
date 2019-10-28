//
//  HeaderView.swift
//  GuessTheFlag
//
//  Created by EDGARDO AGNO on 28/10/2019.
//  Copyright © 2019 EDGARDO AGNO. All rights reserved.
//

import SwiftUI

struct HeaderView: View {
    let countryQuery: String
    let score: Int
    let questionCount: Int
    
    var body: some View {
        ZStack {
            VStack {
                HStack {
                    Spacer()
                }
                Text("Tap the flag of")
                Text(countryQuery)
                    .font(.largeTitle)
                    .fontWeight(.heavy)
            }
            HStack {
                Spacer()
                VStack {
                       Text("Score")
                           .font(.callout)
                       Text("\(score) / \(questionCount)")
                           .font(.body)
                           .fontWeight(.heavy)
                   }
            }
            .padding()
        }
        .animation(nil)
    }
}

struct HeaderView_Previews: PreviewProvider {
    static var previews: some View {
        HeaderView(countryQuery: "UK", score: 1, questionCount: 1)
    }
}
