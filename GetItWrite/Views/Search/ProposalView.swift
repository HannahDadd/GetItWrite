//
//  ProposalsView.swift
//  GetItWrite
//
//  Created by Hannah Billingsley-Dadd on 18/05/2022.
//

import SwiftUI

struct ProposalView: View {
	@EnvironmentObject var session: FirebaseSession
	let proposal: Proposal

	var body: some View {
		NavigationLink(destination: ExpandedProposalView(proposal: proposal).environmentObject(session)) {
			VStack(alignment: .leading, spacing: 8) {
				Text(proposal.title)
                    .font(.headline)
                    .foregroundStyle(Color.onCardBackground)
                    .multilineTextAlignment(.leading)
                    .padding(.top, 16)
                Spacer()
				Text(proposal.blurb)
                    .font(.body)
                    .lineLimit(3)
                    .foregroundStyle(Color.onCardBackground)
                    .multilineTextAlignment(.leading)
				TagCloud(tags: proposal.genres, chosenTags: .constant([]), singleTagView: false)
				Spacer()
				HStack {
					//Text(proposal.formatDate()).font(.caption).foregroundColor(.gray)
					Spacer()
					Text("\(proposal.wordCount) words")
                        .foregroundStyle(Color.onCardBackground)
                        .font(.caption)
				}
			}
            .padding()
            .background(Color.cardBackground)
            .cornerRadius(8)
            .padding()
		}
	}
}

struct NonExpandableProposalView: View {
    @EnvironmentObject var session: FirebaseSession
    let proposal: Proposal

    var body: some View {
        VStack(alignment: .leading, spacing: 8) {
            Text(proposal.title).bold().frame(maxWidth: .infinity, alignment: .leading)
            Text(proposal.blurb).frame(maxWidth: .infinity, alignment: .leading)
            Text(proposal.typeOfProject.joined(separator: ", ")).font(.footnote)
            TagCloud(tags: proposal.genres, chosenTags: .constant([]), singleTagView: false)
            Spacer()
            HStack {
                //Text(proposal.formatDate()).font(.caption).foregroundColor(.gray)
                Spacer()
                Text("\(proposal.wordCount) words").font(.caption).foregroundColor(.gray)
            }
        }
    }
}
