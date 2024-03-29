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
        if session.user == nil {
            Text("Sign in to receive critiques on your work.")
        } else {
            switch result {
            case .success(let critiques):
                List {
                    if critiques.count == 0 {
                        VStack(alignment: .leading, spacing: 24) {
                            Text("None of your work has been critiqued.").font(.title2)
                            FindPartnersText()
                        }
                    }
                    ForEach(critiques, id: \.id) { i in
                        CritiqueView(critique: i)
                    }
                }.refreshable {
                    loadCritiques()
                }.listStyle(.plain)
                    .navigationBarTitle("Critiques", displayMode: .inline)
            case .failure(let error):
                ErrorView(error: error, retryHandler: loadCritiques)
            case nil:
                ProgressView().onAppear(perform: loadCritiques)
            }
        }
	}

	private func loadCritiques() {
		session.loadCritiques() {
			result = $0
		}
	}
}
