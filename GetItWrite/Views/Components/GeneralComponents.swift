//
//  StretchedButton.swift
//  GetItWrite
//
//  Created by Hannah Billingsley-Dadd on 20/02/2022.
//

import SwiftUI

struct ImagePromo: View {
    let image: String
    let text: String
    let bubbleText: String
    var action: () -> Void
    
    var body: some View {
        GeometryReader { geometry in
            ZStack {
                Image(image)
                    .frame(width: geometry.size.width)
                VStack {
                    Spacer()
                    Text(text)
                        .foregroundColor(.black)
                        .background(.white)
                    Spacer()
                    LongArrowButton(title: bubbleText, action: action)
                }
            }
        }
    }
}

struct CarouselCard: View {
    let icon: String
    let title: String
    let bubbleText: String?
    
    var body: some View {
        VStack {
            Image(systemName: icon)
            Text(title)
            Spacer()
            if let bubbleText = bubbleText {
                HStack {
                    Spacer()
                    Text(bubbleText)
                        .font(.caption)
                        .background(Color.primary)
                        .foregroundColor(Color.onPrimary)
                        .clipShape(.capsule)
                }
            }
        }
        .padding()
        .frame(width: CGFloat(150), height: CGFloat(150))
        .background(Color.cardBackground)
        
    }
}

struct TitleAndSubtitle: View {
    var title: String
    var subtitle: String
    
    var body: some View {
        VStack {
            Text(title)
                .font(.title)
            Text(subtitle)
                .font(.subheadline)
        }
    }
}

struct LongArrowButton: View {
    var title: String
    var size: CGFloat = 50
    var isMessages = false
    var action: () -> Void
    
    var body : some View {
        Button(action: {
            self.action()
        }) {
            HStack {
                Text(title).bold()
                Spacer()
                Image(systemName: isMessages ? "paperplane.fill" : "arrow.forward" )
            }
                .frame(minWidth: 0, maxWidth: .infinity)
                .foregroundColor(.white)
                .padding()
                .background(Color.background)
                .overlay(RoundedRectangle(cornerRadius: 3))
        }.accentColor(Color.clear)
    }
}

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
                .foregroundColor(Color.onPrimary)
                .background(isActive ? Color.primary : .gray)
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
					Text(heading).bold().frame(maxWidth: .infinity, alignment: .leading)
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
			Text(heading).bold().frame(maxWidth: .infinity, alignment: .leading)
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
