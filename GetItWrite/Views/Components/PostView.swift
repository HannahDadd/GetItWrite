//
//  PostView.swift
//  GetItWrite
//
//  Created by Hannah Billingsley-Dadd on 25/04/2022.
//

import SwiftUI

struct PostView: View {
	@EnvironmentObject var session: FirebaseSession

	let work: Work
	let canCritique: Bool

	var body: some View {
		HStack {
			VStack(alignment: .leading, spacing: 8) {
				VStack(spacing: 3) {
					Text(work.title).bold().frame(maxWidth: .infinity, alignment: .leading).foregroundColor(Color.darkText)
				 Text(work.blurb).frame(maxWidth: .infinity, alignment: .leading)
				}.padding(.top, 8)
				Text(work.typeOfWork).font(.footnote)
				TagCloud(tags: work.genres, chosenTag: .constant(""), singleTagView: false)
				Spacer()
				HStack {
					Text(work.formatDate()).font(.caption).foregroundColor(.gray)
					Spacer()
					Text(String(work.critiques.count) + " critiques").font(.caption).foregroundColor(.gray)
				}
				if canCritique {
					NavigationLink(destination: GiveCritiqueView(work: work).environmentObject(session)) { EmptyView() }.frame(width: 0).opacity(0)
				} else {
					NavigationLink(destination: CritiquesView(work: work)) { EmptyView() }.frame(width: 0).opacity(0)
				}
			}
		}
	}
}
