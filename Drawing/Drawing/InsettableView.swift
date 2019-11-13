//
//  InsettableView.swift
//  Drawing
//
//  Created by EDGARDO AGNO on 13/11/2019.
//  Copyright © 2019 EDGARDO AGNO. All rights reserved.
//

import SwiftUI

struct InsettableView: View {
    let insettable: Bool
    var body: some View {
        VStack {
            if insettable {
                Circle()
                    .strokeBorder(Color.blue, lineWidth: 40)
            }
            if !insettable {
                Circle()
                    .stroke(Color.blue, lineWidth: 40)
            }
        }
    }
}

struct InsettableView_Previews: PreviewProvider {
    static var previews: some View {
        InsettableView(insettable: true)
    }
}
