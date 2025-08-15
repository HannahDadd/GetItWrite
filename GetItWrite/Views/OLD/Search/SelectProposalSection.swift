//
//  SelectProjectView.swift
//  GetItWrite
//
//  Created by Hannah Billingsley-Dadd on 19/05/2022.
//

import SwiftUI

struct SelectProposalSection: View {
	@EnvironmentObject var session: FirebaseSession

	@Binding var project: Proposal?
	@State private var showSelectProjectView = false

	var body : some View {
		VStack {
			if let project = project {
				Divider()
                NonExpandableProposalView(proposal: project)
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
        }
        .sheet(isPresented: self.$showSelectProjectView) {
            SelectProposalView(proposal: $project, showSelectProposalView: $showSelectProjectView).environmentObject(session)
		}
	}
}

struct SelectProposalView: View {
	@EnvironmentObject var session: FirebaseSession
	@State private var result: Result<[Proposal], Error>?
	@State var showMakeProposalView = false

	@Binding var proposal: Proposal?
	@Binding var showSelectProposalView: Bool

	var body: some View {
		switch result {
		case .success(let projects):
			NavigationView {
				VStack {
					VStack {
						if projects.count != 0 {
							Text("Select a project from the list below or create a project on the 'find partners' section of the app.")
						} else {
							Text("You have no projects. Make one under the 'find partners' section of the app.")
						}
					}.padding()
					List {
						ForEach(projects, id: \.id) { i in
							ProposalView(proposal: i).environmentObject(session)
								.background(proposal == i ? Color.background : .white)
								.onTapGesture {
									proposal = i
                                    showSelectProposalView = false
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
		session.loadUserProposals() {
			result = $0
		}
	}
}
