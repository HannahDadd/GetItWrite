//
//  SelectProjectView.swift
//  GetItWrite
//
//  Created by Hannah Billingsley-Dadd on 19/05/2022.
//

import SwiftUI

struct SelectProjectSection: View {
	@EnvironmentObject var session: FirebaseSession

	@Binding var project: Project?

	var body : some View {

		if let project = project {
			ProjectView(project: project)
		} else {
			NavigationLink(destination: SelectProjectView(project: $project).environmentObject(session)) {
				Text("Select Project")
			}
		}
	}
}

struct SelectProjectView: View {
	@EnvironmentObject var session: FirebaseSession
	@State private var result: Result<[Project], Error>?
	@State private var showMakeProjectView = false

	@Binding var project: Project?

	var body: some View {
		switch result {
		case .success(let projects):
			ScrollView {
				VStack {
					if projects.count != 0 {
						List {
							ForEach(projects, id: \.id) { i in
								ProjectView(project: i).environmentObject(session)
									.background(project == i ? Color.lightBackground : .white)
									.onTapGesture {
										project = i
									}
							}
						}.listStyle(PlainListStyle())
						Text("-- OR --")
					}
					StretchedButton(text: "Create Project", action: { showMakeProjectView = true })
					NavigationLink(destination: MakeProjectView(project: $project).environmentObject(session), isActive: self.$showMakeProjectView) {
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
