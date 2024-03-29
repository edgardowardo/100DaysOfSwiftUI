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
                Section(header: Text("Day 65")) {
                    NavigationLink("Image Filter Sepia", destination: ImageFilterSepiaView())
                }
                
                Section(header: Text("Day 64")) {
                    NavigationLink("Coordinator + Image Saver", destination: CoordinatorExplainedView())
                }

                Section(header: Text("Day 63")) {
                    NavigationLink("Image filter (none)", destination: ImageFiltersSampleView(filter: .none))
                    NavigationLink("Image filter (sepia)", destination: ImageFiltersSampleView(filter: .sepia))
                    NavigationLink("Image filter (pixelate)", destination: ImageFiltersSampleView(filter: .pixelate))
                    NavigationLink("Image filter (crystalize)", destination: ImageFiltersSampleView(filter: .crystalize))
                    NavigationLink("Image filter (twirl)", destination: ImageFiltersSampleView(filter: .twirl))
                    NavigationLink("Image picker View Representable wrapper", destination: ImagePickerSampleView())
                }
                Section(header: Text("Day 62")) {
                    NavigationLink("Custom binding", destination: CustomBindingView())
                    NavigationLink("Action sheet", destination: ActionSheetSampleView())
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
