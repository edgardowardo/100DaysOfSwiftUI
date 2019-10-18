//
//  ContentView.swift
//  WeeAngles
//
//  Created by EDGARDO AGNO on 11/10/2019.
//  Copyright © 2019 EDGARDO AGNO. All rights reserved.
//

import SwiftUI

enum Angle: Equatable {
    case degree(value: Double)
    case radian(value: Double)
    case gradian
}

extension Angle {
    var description: String {
        switch self {
        case .degree: return "Degree"
        case .radian: return "Radian"
        case .gradian: return "Gradian"
        }
    }
    
    func convert(to target: Angle) -> Double {
        switch self {
        case .degree(let degree):
            switch target {
            case .degree: return 0 //fatalError()
            case .radian: return degree * .pi / 180
            default:
                return 0
            }
        case .radian(let radian):
            switch target {
            case .degree: return radian * 180 / .pi
            case .radian: return 0 //fatalError()
            default:
                return 0
            }
        default:
            return 0
        }
    }
}

struct ContentView: View {
    @State private var textInput = ""
    @State private var indexInput = 0
    @State private var indexOutput = 1
    let angles: [Angle] = [.degree(value: 0), .radian(value: 0), .gradian]
    
    var body: some View {
        let indexInputShim = Binding (
            get: { self.indexInput },
            set: {
                if $0 == self.indexOutput {
                    self.indexOutput = self.indexInput
                }
                self.indexInput = $0
        }
        )
        let indexOutputShim = Binding (
            get: { self.indexOutput },
            set: {
                if $0 == self.indexInput {
                    self.indexInput = self.indexOutput
                }
                self.indexOutput = $0
        }
        )
        return NavigationView {
            return Form {
                Section(header: Text("Input")) {
                    TextField("0", text: $textInput)
                        .keyboardType(.decimalPad)
                    Picker("Input Angle", selection: indexInputShim) {
                        ForEach(0 ..< angles.count) {
                            Text("\(self.angles[$0].description)")
                        }
                    }.pickerStyle(SegmentedPickerStyle())
                }
                
                Section(header: Text("Output")) {
                    Picker("Output Angle", selection: indexOutputShim) {
                        ForEach(0 ..< angles.count) {
                            Text("\(self.angles[$0].description)")
                        }
                    }.pickerStyle(SegmentedPickerStyle())
                    Text("\(inputAngle.convert(to: angles[self.indexOutput]), specifier: "%.2f")")
                        .font(.largeTitle)
                }
            }.navigationBarTitle("WeeAngles")
        }
    }
}

extension ContentView {
    var inputAngle: Angle {
        switch angles[indexInput] {
        case .degree: return .degree(value: Double(textInput) ?? 0)
        case .radian: return .radian(value: Double(textInput) ?? 0)
        case .gradian: return .gradian
        }
    }
}


struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
