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
	let project: Project

	var body: some View {
		switch result {
		case .success(let critiques):
					List {
						ForEach(critiques, id: \.id) { i in
							CritiqueView(critique: i)
						}
					}.listStyle(PlainListStyle())
				.navigationBarTitle(project.title, displayMode: .inline)
		case .failure(let error):
			ErrorView(error: error, retryHandler: loadPosts)
		case nil:
			ProgressView().onAppear(perform: loadPosts)
		}
	}

	private func loadPosts() {
		session.loadCritiques(id: project.id) {
			result = $0
		}
	}
}
