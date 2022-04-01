//
//  SelectTagView.swift
//  GetItWrite
//
//  Created by Hannah Billingsley-Dadd on 20/02/2022.
//

import SwiftUI

struct SelectTagView: View {
    @Binding var chosenTags: [String]
    let questionLabel: String
    let array: [String]

    var body: some View {
        VStack {
            Text(questionLabel).bold().frame(maxWidth: .infinity, alignment: .leading)
            TagCloud(tags: array, onTap: { text in
                chosenTags.append(text)
            })
        }
    }
}

struct SingleTagSelectView: View {
	@Binding var chosenTag: String
	let questionLabel: String
	let array: [String]

	var body: some View {
		VStack {
			Text(questionLabel).bold().frame(maxWidth: .infinity, alignment: .leading)
			TagCloud(tags: array, onTap: { text in
				chosenTag = text
			})
		}
	}
}
