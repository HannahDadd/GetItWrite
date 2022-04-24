//
//  CommentableText.swift
//  GetItWrite
//
//  Created by Hannah Billingsley-Dadd on 24/04/2022.
//

import SwiftUI

struct CommentableText: View {
	@State var words: [String]
	@State var chosenWord: String = ""

	var body : some View {
		var width = CGFloat.zero
		var height = CGFloat.zero

		return GeometryReader { g in
			ZStack(alignment: .topLeading) {
				ForEach(0..<self.words.count, id: \.self) { i in
					Text(self.words[i])
						.fontWeight(.medium)
						.padding([.horizontal, .vertical], 4)
						.background(chosenWord == self.words[i] ? .yellow : .clear)
						.onTapGesture {
							chosenWord = self.words[i]
						}
						.alignmentGuide(.leading, computeValue: { d in
							if (abs(width - d.width) > g.size.width)
							{
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
						.alignmentGuide(.top, computeValue: {d in
							let result = height
							if i >= self.words.count-1 {
								height = 0 // last item
							}
							return result
						})
				}
			}
		}

	}
}
