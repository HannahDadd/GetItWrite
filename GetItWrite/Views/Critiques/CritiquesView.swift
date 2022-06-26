//
//  CritiquesView.swift
//  GetItWrite
//
//  Created by Hannah Billingsley-Dadd on 27/04/2022.
//

import SwiftUI

struct CritiquesView: View {
	@EnvironmentObject var session: FirebaseSession
	@State private var result: Result<[Critique], Error>?

	var body: some View {
		switch result {
		case .success(let critiques):
			List {
				if critiques.count == 0 {
					VStack(alignment: .leading, spacing: 24) {
						Text("You have no critiques.").font(.title2)
						Text("Select 'Swap' on the side bar 👈 to find new critique partners. Use the 'Messages' 💬 to chat and tap the pen icon in the right corner to send them your work ✏️")
					}
				}
				ForEach(critiques, id: \.id) { i in
					CritiqueView(critique: i)
				}
			}.listStyle(.plain)
				.navigationBarTitle("Critiques", displayMode: .inline)
		case .failure(let error):
			ErrorView(error: error, retryHandler: loadPosts)
		case nil:
			ProgressView().onAppear(perform: loadPosts)
		}
	}

	private func loadPosts() {
		session.loadCritiques() {
			result = $0
		}
	}
}
