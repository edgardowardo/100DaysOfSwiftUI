//
//  ContentView.swift
//  AdaptiveHeaderView
//
//  Created by EDGARDO AGNO on 04/12/2019.
//  Copyright © 2019 EDGARDO AGNO. All rights reserved.
//

import SwiftUI

struct Hour: Identifiable, Hashable {
    let id: Int
    let hour: String
}

struct ContentView: View {
    
//    let hours = ["20", "21", "22", "23", "00", "01", "02", "03", "04"].enumerated()
    let hours = [
        Hour(id: 0, hour: "20"),
        Hour(id: 1, hour: "21"),
        Hour(id: 2, hour: "22"),
        Hour(id: 3, hour: "23"),
        Hour(id: 4, hour: "00"),
        Hour(id: 5, hour: "01"),
        Hour(id: 6, hour: "02"),
        Hour(id: 7, hour: "03")
    ]
    
    var body: some View {
        VStack {
            ZStack {
                ForEach(hours, id: \.self) { hh in
                    Text(self.day(of: hh.hour))
//                        .offset(x: hh.id * 20)
//                        .offset(x: 20)
                }
            }
            
            HStack {
                ForEach(hours, id: \.self) {
                    Text("\($0.hour)")
                }
            }
        }
    }
    
    func day(of hour: String) -> String {
        if hour == "20" {
            return "TODAY"
        } else if hour == "00" {
            return "Thu, 05 Dec"
        } else {
            return ""
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
