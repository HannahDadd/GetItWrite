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
	
	var body : some View {
		Button(action: { self.action() }) {
			Text(text).bold()
				.frame(minWidth: 0, maxWidth: .infinity)
				.foregroundColor(.white)
				.padding()
				.background(Color.lightBackground)
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
				TextAndHeader(heading: heading, text: text)
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
		VStack(spacing: 8) {
			Text(heading).bold().frame(maxWidth: .infinity, alignment: .leading)
			Text(text).frame(maxWidth: .infinity, alignment: .leading)
		}
	}
}
