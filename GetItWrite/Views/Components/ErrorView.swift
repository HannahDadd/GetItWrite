//
//  ErrorView.swift
//  GetItWrite
//
//  Created by Hannah Billingsley-Dadd on 20/02/2022.
//

import SwiftUI

struct ErrorView: View {

    let error: Error
    let retryHandler: () -> Void

    var body: some View {
        Text(error.localizedDescription)
    }
}
