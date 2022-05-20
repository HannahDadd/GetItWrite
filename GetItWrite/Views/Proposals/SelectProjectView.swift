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
		VStack {
			if let project = project {
				Divider()
				ProjectView(project: project)
				Button(action: { showSelectProjectView = true }) {
					HStack {
						Image(systemName: "folder.fill.badge.questionmark")
						Text("Select Different Project ").bold()
						Spacer()
					}
				}
				Divider()
			} else {
				StretchedButton(text: "Select Project", action: { showSelectProjectView = true })
			}
		}.sheet(isPresented: self.$showSelectProjectView) {
			SelectProjectView(project: $project, showSelectProjectView: $showSelectProjectView).environmentObject(session)
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
				VStack {
					VStack {
						if projects.count != 0 {
							Text("Select a project from the list below or create a project. 👇")
						} else {
							Text("You have no projects- why not make one? 👇")
						}
						StretchedButton(text: "Create New Project", action: { showMakeProjectView = true })
						NavigationLink(destination: MakeProjectView(project: $project, showMakeProjectView: $showSelectProjectView).environmentObject(session), isActive: self.$showMakeProjectView) {
							EmptyView()
						}
					}.padding()
					List {
						ForEach(projects, id: \.id) { i in
							ProjectView(project: i).environmentObject(session)
								.background(project == i ? Color.background : .white)
								.onTapGesture {
									project = i
									showSelectProjectView = false
								}
						}
					}.listStyle(.plain)
				}.navigationBarTitle("Select Project", displayMode: .inline)
			}.accentColor(Color.darkText)
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
