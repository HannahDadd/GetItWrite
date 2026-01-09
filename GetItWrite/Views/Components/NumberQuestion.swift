//
//  NumberQuestion.swift
//  Get It Write
//
//  Created by Hannah Dadd on 08/08/2025.
//

import SwiftUI

struct NumberSection: View {
    var text: String
    @Binding var response: Int
    
    var body : some View {
        VStack {
            Text(text).bold().frame(maxWidth: .infinity, alignment: .leading)
            TextField("\(text)", value: $response, format: .number)
                .textFieldStyle(.roundedBorder)
                .padding()
        }
    }
}
