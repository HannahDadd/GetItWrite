//
//  PostView.swift
//  GetItWrite
//
//  Created by Hannah Billingsley-Dadd on 25/04/2022.
//

import SwiftUI

struct ProjectView: View {
	@EnvironmentObject var session: FirebaseSession

	let project: Project

	var body: some View {
		HStack {
			VStack(alignment: .leading, spacing: 8) {
				Text(project.title).bold().frame(maxWidth: .infinity, alignment: .leading)
				Text(project.blurb).frame(maxWidth: .infinity, alignment: .leading)
				TagCloud(tags: project.genres, chosenTags: .constant([]), singleTagView: false)
				Spacer()
				HStack {
					Text(project.formatDate()).font(.caption).foregroundColor(.gray)
					Spacer()
//					Text(String(project.wordCount) + " words").font(.caption).foregroundColor(.gray)
				}
			}
		}
	}
}
