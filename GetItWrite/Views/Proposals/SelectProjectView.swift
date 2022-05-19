//
//  SelectProjectView.swift
//  GetItWrite
//
//  Created by Hannah Billingsley-Dadd on 19/05/2022.
//

import SwiftUI

struct SelectProjectView: View {
	@EnvironmentObject var session: FirebaseSession
	@State private var result: Result<[Project], Error>?
	@State private var showMakeProjectView = false

	var body: some View {
		switch result {
		case .success(let projects):
			ScrollView {
				VStack {
					if projects.count != 0 {
						List {
							ForEach(projects, id: \.id) { i in
								ProjectView(project: i).environmentObject(session)
							}
						}.listStyle(PlainListStyle())
						Text("-- OR --")
					}
					StretchedButton(text: "Create Project", action: { showMakeProjectView = true })
					NavigationLink(destination: MakeProjectView().environmentObject(session), isActive: self.$showMakeProjectView) {
						EmptyView()
					}
				}.padding()
			}.navigationBarTitle("Your Projects")
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
