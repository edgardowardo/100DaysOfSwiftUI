//
//  ContentView.swift
//  CoreDataProject
//
//  Created by EDGARDO AGNO on 20/11/2019.
//  Copyright © 2019 EDGARDO AGNO. All rights reserved.
//

import SwiftUI

struct ContentView: View {
    var body: some View {
        NavigationView {
            List {
                NavigationLink("Singers Specific Predicate", destination: SingersView())
                NavigationLink("Candies by Country", destination: CandiesByCountryView())
                NavigationLink("Day 59 Challenge", destination: ChallengeView())
            }
            .navigationBarTitle("Day 58")
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
