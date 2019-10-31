//
//  AnimatableParagraph.swift
//  MooTable
//
//  Created by EDGARDO AGNO on 31/10/2019.
//  Copyright © 2019 EDGARDO AGNO. All rights reserved.
//

import SwiftUI

let typeDelay = 0.1

protocol AnimatableParagraph {
    var lines: [String] { get set }
    func append(_ char: String.Element, at index: Int)
    func append(_ text: String, at index: Int)
}

extension AnimatableParagraph {
    func append(_ text: String, at index: Int) {
        guard !text.isEmpty
            else { return }
        var arrayText = Array(text)
        append(arrayText[0], at: index)
        
        arrayText.removeFirst()
        DispatchQueue.main.asyncAfter(deadline: .now() + typeDelay) {
            self.append(String(arrayText), at: index)
        }
    }
}
