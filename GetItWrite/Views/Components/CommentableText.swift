//
//  CommentableText.swift
//  GetItWrite
//
//  Created by Hannah Billingsley-Dadd on 24/04/2022.
//

import SwiftUI

struct CommentableText: View {
	var words: [String]
	@State var chosenWord: String = ""

	@Binding var wordTapped: Bool
	@Binding var instance: Int

	@State private var totalHeight = CGFloat.zero

	var body: some View {
		VStack {
			GeometryReader { geometry in
				self.generateContent(in: geometry)
			}
		}.frame(height: totalHeight)
	}

	private func generateContent(in g: GeometryProxy) -> some View {
		var width = CGFloat.zero
		var height = CGFloat.zero

		return ZStack(alignment: .topLeading) {
			ForEach(0..<self.words.count, id: \.self) { i in
				Text(self.words[i])
					.fontWeight(.medium)
					.padding([.horizontal, .vertical], 4)
					.background(chosenWord == self.words[i] && wordTapped ? .yellow : .clear)
					.onTapGesture {
						chosenWord = self.words[i]
						wordTapped = true
						instance = i
					}
					.alignmentGuide(.leading, computeValue: { d in
						if (abs(width - d.width) > g.size.width) {
							width = 0
							height -= d.height
						}
						let result = width
						if i < self.words.count-1 {
							width -= d.width
						} else {
							width = 0 //last item
						}
						return result
					})
					.alignmentGuide(.top, computeValue: { d in
						let result = height
						if i >= self.words.count - 1 {
							height = 0 // last item
						}
						return result
					})
			}
		}.background(viewHeightReader($totalHeight))
	}

	private func viewHeightReader(_ binding: Binding<CGFloat>) -> some View {
		return GeometryReader { geometry -> Color in
			let rect = geometry.frame(in: .local)
			DispatchQueue.main.async {
				binding.wrappedValue = rect.size.height
			}
			return .clear
		}
	}
}
