//
//  PostView.swift
//  GetItWrite
//
//  Created by Hannah Billingsley-Dadd on 25/04/2022.
//

import SwiftUI

struct PostView: View {
	@EnvironmentObject var session: FirebaseSession

	let project: Project
	let canCritique: Bool

	var body: some View {
		HStack {
			VStack(alignment: .leading, spacing: 8) {
				Text(project.title).bold().frame(maxWidth: .infinity, alignment: .leading)
				Text(project.blurb).frame(maxWidth: .infinity, alignment: .leading)
				Text(project.typeOfProject).font(.footnote)
				TagCloud(tags: project.genres, chosenTag: .constant(""), singleTagView: false)
				Spacer()
				HStack {
					Text(project.formatDate()).font(.caption).foregroundColor(.gray)
					Spacer()
					Text(String(project.critiques.count) + " critiques").font(.caption).foregroundColor(.gray)
				}
				if canCritique {
					NavigationLink(destination: GiveCritiqueView(project: project).environmentObject(session)) { EmptyView() }.frame(width: 0).opacity(0)
				} else {
					NavigationLink(destination: CritiquesView(project: project).environmentObject(session)) { EmptyView() }.frame(width: 0).opacity(0)
				}
			}
		}
	}
}

struct ProjectMetadataView: View {

	let project: Project

	var body: some View {
		VStack(spacing: 8) {
			Text(project.title).font(.title)
			Text("By \(project.writerName)")
			TagCloud(tags: project.genres, onTap: nil, chosenTag: .constant(""), singleTagView: false)
			if project.triggerWarnings.count > 0 {
				Divider()
				Text("Trigger Warnings:").font(.footnote)
				TagCloud(tags: project.triggerWarnings, chosenTag: .constant(""), singleTagView: false)
			}
			Divider()
			ExpandableText(heading: "Blurb:", text: project.blurb, headingPreExpand: "Expand Blurb")
			if project.synopsisSoFar != "" {
				ExpandableText(heading: "Synopsis so Far:", text: project.synopsisSoFar, headingPreExpand: "Expand Synopsis").padding(.top, 10)
			}
			Divider()
		}
	}
}
