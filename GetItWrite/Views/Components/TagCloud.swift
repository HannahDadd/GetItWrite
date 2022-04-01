//
//  TagCloud.swift
//  GetItWrite
//
//  Created by Hannah Billingsley-Dadd on 18/02/2022.
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
				if chosenTags.contains(text) {
					chosenTags.removeAll(where: { $0 == text })
				} else {
					chosenTags.append(text)
				}
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

struct TagCloud: View {
    var tags: [String]
    var onTap : ((String) -> Void)?

    @State private var totalHeight
          = CGFloat.zero       // << variant for ScrollView/List
    //    = CGFloat.infinity   // << variant for VStack

    var body: some View {
        VStack {
            GeometryReader { geometry in
                self.generateContent(in: geometry)
            }
        }
        .frame(height: totalHeight)// << variant for ScrollView/List
        //.frame(maxHeight: totalHeight) // << variant for VStack
    }

    private func generateContent(in g: GeometryProxy) -> some View {
        var width = CGFloat.zero
        var height = CGFloat.zero

        return ZStack(alignment: .topLeading) {
            ForEach(self.tags, id: \.self) { tag in
                SingleTagView(text: tag, onTap: onTap)
                    .padding([.horizontal, .vertical], 4)
                    .alignmentGuide(.leading, computeValue: { d in
                        if (abs(width - d.width) > g.size.width)
                        {
                            width = 0
                            height -= d.height
                        }
                        let result = width
                        if tag == self.tags.last! {
                            width = 0 //last item
                        } else {
                            width -= d.width
                        }
                        return result
                    })
                    .alignmentGuide(.top, computeValue: {d in
                        let result = height
                        if tag == self.tags.last! {
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

private struct SingleTagView: View {
    let text: String
    var onTap: ((String) -> Void)?
	@State var isLight = true

    var body: some View {
        Text(text)
            .padding(.all, 5)
            .font(.body)
			.background(isLight ? Color.lighterReadable : Color.darkReadable)
            .foregroundColor(Color.white)
            .cornerRadius(5)
            .onTapGesture {
                if let tapped = onTap {
					isLight.toggle()
                    tapped(text)
                }
            }
    }
}
