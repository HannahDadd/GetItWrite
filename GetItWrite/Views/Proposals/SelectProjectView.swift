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
	@State private var showSelectProjectView = false

	var body : some View {

		if let project = project {
			ProjectView(project: project)
		} else {
			Button(action: { showSelectProjectView = true }) {
				Text("Select Project")
			}.sheet(isPresented: self.$showSelectProjectView) {
				SelectProjectView(project: $project, showSelectProjectView: $showSelectProjectView).environmentObject(session)
			}
		}
	}
}

struct SelectProjectView: View {
	@EnvironmentObject var session: FirebaseSession
	@State private var result: Result<[Project], Error>?
	@State var showMakeProjectView = false

	@Binding var project: Project?
	@Binding var showSelectProjectView: Bool

	var body: some View {
		switch result {
		case .success(let projects):
			NavigationView {
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
						} else {
							Text("You have no projects- why not make one? 👇")
						}
						StretchedButton(text: "Create Project", action: { showMakeProjectView = true })
						NavigationLink(destination: MakeProjectView(project: $project, showMakeProjectView: $showSelectProjectView).environmentObject(session), isActive: self.$showMakeProjectView) {
							EmptyView()
						}
					}.padding()
				}.navigationBarTitle("Your Projects")
			}
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
