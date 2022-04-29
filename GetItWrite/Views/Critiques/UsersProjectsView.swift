//
//  AllProjectsView.swift
//  GetItWrite
//
//  Created by Hannah Billingsley-Dadd on 25/04/2022.
//

import SwiftUI

struct UsersProjectsView: View {
	@EnvironmentObject var session: FirebaseSession
	@State private var result: Result<[Project], Error>?

	var body: some View {
		switch result {
		case .success(let projects):
			List {
				ForEach(projects, id: \.id) { i in
					NavigationLink(destination: CritiquesView(project: i).environmentObject(session)) {
						PostView(project: i).environmentObject(session).onAppear(perform: {
	//						session.populateFakeReviews(project: i)
						})
					}
				}
			}.listStyle(PlainListStyle())
				.navigationBarTitle("Your Projects", displayMode: .inline)
		case .failure(let error):
			ErrorView(error: error, retryHandler: loadProjects)
		case nil:
			ProgressView().onAppear(perform: loadProjects)
		}
	}

	private func loadProjects() {
		session.loadUserProjects() {
			result = $0
		}
	}
}
