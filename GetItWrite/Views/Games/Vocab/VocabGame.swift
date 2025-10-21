//
//  VocabGame.swift
//  Get It Write
//
//  Created by Hannah Dadd on 21/10/2025.
//

import SwiftUI

struct VocabGame: View {
    let words = GlobalVariables.vocabMap.shuffled().prefix(upTo: 4)
    
    var body: some View {
        VStack {
            Text(" is the definition of")
        }
    }
}
