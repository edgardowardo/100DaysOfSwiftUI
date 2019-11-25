//
//  ActionSheetSampleView.swift
//  FromDay62Theories
//
//  Created by EDGARDO AGNO on 25/11/2019.
//  Copyright © 2019 EDGARDO AGNO. All rights reserved.
//

import SwiftUI

struct ActionSheetSampleView: View {
    @State private var showingActionSheet = false
    @State private var backgroundColor = Color.gray
    
    var body: some View {
        Text("Tap me")
            .frame(width: 300, height: 300)
            .background(backgroundColor)
            .onTapGesture {
                self.showingActionSheet = true
            }
         .actionSheet(isPresented: $showingActionSheet) {
             ActionSheet(title: Text("Change background"), message: Text("Select a new color"), buttons: [
                 .default(Text("Red")) { self.backgroundColor = .red },
                 .default(Text("Green")) { self.backgroundColor = .green },
                 .default(Text("Blue")) { self.backgroundColor = .blue },
                 .cancel()
             ])
         }
    }
}

struct ActionSheetSampleView_Previews: PreviewProvider {
    static var previews: some View {
        ActionSheetSampleView()
    }
}
