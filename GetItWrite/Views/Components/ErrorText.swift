//
//  ErrorText.swift
//  Get It Write
//
//  Created by Hannah Dadd on 15/08/2025.
//

import SwiftUI

struct ErrorText: View {
    var errorMessage: String
    
    var body : some View {
        Text(errorMessage).foregroundColor(Color.red).fixedSize(horizontal: false, vertical: true)
    }
}
