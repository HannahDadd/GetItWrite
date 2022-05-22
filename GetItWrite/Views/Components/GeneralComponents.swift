//
//  StretchedButton.swift
//  GetItWrite
//
//  Created by Hannah Billingsley-Dadd on 20/02/2022.
//

import SwiftUI

struct StretchedButton: View {
	var text: String
	var action: () -> Void
	var size: CGFloat = 50
	var isActive = true
	
	var body : some View {
		Button(action: {
			if isActive {
				self.action()
			}
		}) {
			Text(text).bold()
				.frame(minWidth: 0, maxWidth: .infinity)
				.foregroundColor(.white)
				.padding()
				.background(isActive ? Color.lightBackground : .gray)
				.overlay(RoundedRectangle(cornerRadius: 5))
		}.accentColor(Color.clear)
	}
}

struct QuestionSection: View {
	var text: String
	@Binding var response: String
	
	var body : some View {
		VStack {
			Text(text).bold().frame(maxWidth: .infinity, alignment: .leading)
			TextEditor(text: $response)
				.frame(height: 100, alignment: .leading)
				.cornerRadius(6.0)
				.border(Color.gray, width: 1)
				.multilineTextAlignment(.leading)
		}
	}
}

struct ExpandableText: View {
	var heading: String
	var text: String
	var headingPreExpand: String
	@State private var expanded = false
	
	var body : some View {
		if expanded {
			Button(action: { expanded.toggle() }) {
				VStack(alignment: .leading, spacing: 8) {
					Text(heading).bold()
					Text(text)
				}
			}
		} else {
			Button(action: { expanded.toggle() }) {
				Text(headingPreExpand).bold().frame(maxWidth: .infinity, alignment: .leading)
			}
		}
	}
}

struct ErrorText: View {
	var errorMessage: String
	
	var body : some View {
		Text(errorMessage).foregroundColor(Color.red).fixedSize(horizontal: false, vertical: true)
	}
}

struct TextAndHeader: View {
	var heading: String
	var text: String
	
	var body : some View {
		VStack(alignment: .leading, spacing: 8) {
			Text(heading).bold()
			Text(text)
		}
	}
}

struct TextAndTags: View {
	var heading: String
	var tags: [String]
	
	var body : some View {
		VStack(spacing: 8) {
			Text(heading).bold().frame(maxWidth: .infinity, alignment: .leading)
			TagCloud(tags: tags, onTap: nil, chosenTags: .constant([]), singleTagView: false)
		}
	}
}

struct StarRatingView: View {
	var number: Int
	
	var body : some View {
		HStack {
			if number == 0 {
				Image(systemName: "circle").imageScale(.large).foregroundColor(Color.lightBackground)
			}
			ForEach(0..<number) { _ in 
				Image(systemName: "star.fill").imageScale(.large).foregroundColor(Color.lightBackground)
			}
		}
	}
}

struct SendBar: View {
	@Binding var text: String
	var onSend : () -> Void

	var body: some View {
		HStack {
			TextField("Text Message", text: $text).textFieldStyle(RoundedBorderTextFieldStyle())
			Spacer()
			Button(action: {
				self.onSend()
				text = ""
			}) { Image(systemName: "paperplane.circle") }
		}.padding()
	}
}
