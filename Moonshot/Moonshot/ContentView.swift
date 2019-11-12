//
//  ContentView.swift
//  Moonshot
//
//  Created by EDGARDO AGNO on 12/11/2019.
//  Copyright © 2019 EDGARDO AGNO. All rights reserved.
//

import SwiftUI

struct ContentView: View {
    
    let astronauts: [Astronaut] = Bundle.main.decode("astronauts.json")
    let missions: [Mission] = Bundle.main.decode("missions.json")
    @State private var showLaunchDates = true
    
    var body: some View {
        NavigationView {
            List(missions) { mission in
                NavigationLink(destination: MissionView(mission: mission, astronauts: self.astronauts)) {
                    Image(mission.image)
                        .resizable()
                        .scaledToFit()
                        .frame(width: 44, height: 44)

                    VStack(alignment: .leading) {
                        Text(mission.displayName)
                            .font(.headline)
                        Text(self.showLaunchDates ? mission.formattedLaunchDate : mission.displayedCrew)
                    }
                }
            }
            .navigationBarTitle("Moonshot")
            .navigationBarItems(trailing: Button(action: {
                self.showLaunchDates.toggle()
            }) { Image(systemName: self.showLaunchDates ? "clock" : "person.3") })
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
