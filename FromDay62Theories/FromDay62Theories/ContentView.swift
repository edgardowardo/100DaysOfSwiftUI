//
//  ContentView.swift
//  FromDay62Theories
//
//  Created by EDGARDO AGNO on 25/11/2019.
//  Copyright © 2019 EDGARDO AGNO. All rights reserved.
//

import SwiftUI

struct ContentView: View {
    var body: some View {
        NavigationView {
            Form {
                Section(header: Text("Day 62")) {
                    NavigationLink("Custom binding", destination: CustomBindingView())
                    NavigationLink("Action sheet", destination: ActionSheetSampleView())
                }
                Section(header: Text("Day 63")) {
                    NavigationLink("Image filter", destination: ImageFiltersSampleView())
                }
            }
            .navigationBarTitle("> 62")
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
