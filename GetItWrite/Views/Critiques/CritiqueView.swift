//
//  CritiqueView.swift
//  GetItWrite
//
//  Created by Hannah Billingsley-Dadd on 27/04/2022.
//

import SwiftUI

struct CritiqueView: View {
	let critique: Critique

	var body: some View {
		VStack(alignment: .leading, spacing: 8) {
			HStack(alignment: .top, spacing: 8) {
				ProfileImage(username: critique.critiquerName, colour: critique.critiquerProfileColour)
				Text(critique.critiquerName).bold().font(.system(.subheadline, design: .rounded))
				Spacer()
			}
			Text(critique.overallFeedback).lineLimit(3)
				.frame(maxWidth: .infinity, alignment: .leading)
			HStack {
				Text(critique.formatDate()).font(.caption).foregroundColor(.gray)
				Spacer()
				Text(String(critique.comments.count) + " comments").font(.caption).foregroundColor(.gray)
			}
			//NavigationLink(destination: GiveCritiqueView(project: project).environmentObject(session)) { EmptyView() }.frame(width: 0).opacity(0)
		}
	}
}
