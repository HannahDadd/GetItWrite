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
		VStack(spacing: 10) {
			Image("Broken").resizable().aspectRatio(contentMode: .fit).padding()
			Text("Something's not write...").font(.largeTitle).bold()
				.frame(maxWidth: .infinity, alignment: .leading)
			ExpandableText(heading: "Error Code", text: error.localizedDescription, headingPreExpand: "View Error Information")
			Spacer()
			StretchedButton(text: "Retry", action: retryHandler)
		}.padding()
    }
}
