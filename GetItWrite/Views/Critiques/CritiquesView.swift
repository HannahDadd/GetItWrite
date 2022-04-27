//
//  CritiquesView.swift
//  GetItWrite
//
//  Created by Hannah Billingsley-Dadd on 25/04/2022.
//

import SwiftUI

struct CritiquesView: View {
	@EnvironmentObject var session: FirebaseSession
	@State private var result: Result<[Work], Error>?

	var body: some View {
		switch result {
		case .success(let works):
			List {
				ForEach(works, id: \.id) { i in
					PostView(work: i, canCritique: true).environmentObject(session)
				}
			}.listStyle(PlainListStyle())
				.navigationBarTitle("Your Work", displayMode: .inline)
		case .failure(let error):
			ErrorView(error: error, retryHandler: loadWorks)
		case nil:
			ProgressView().onAppear(perform: loadWorks)
		}
	}

	private func loadWorks() {
		session.loadUserWorks() {
			result = $0
		}
	}
}
