//
//  ChatBubble.swift
//  GetItWrite
//
//  Created by Hannah Billingsley-Dadd on 22/05/2022.
//

import SwiftUI

struct OtherUserChatBubble: View {
    @State var showReportAndBlockButton = false
	let message: Message

	var body: some View {
		VStack(alignment: .leading) {
			Text(message.formatDate()).font(.caption).foregroundColor(.gray)
			ChatBubble(direction: .left) {
				Text(message.content)
					.padding(.all, 15)
                    .foregroundColor(Color.onSecondary)
                    .background(Color.secondary)
			}
            if showReportAndBlockButton {
                ReportAndBlockView(content: message, contentType: .messages, toBeBlockedUserId: message.senderID, imageScale: .small)
            }
		}
        .padding(EdgeInsets(top: 10, leading: 20, bottom: 10, trailing: 50))
        .onTapGesture {
            showReportAndBlockButton.toggle()
        }
	}
}

struct SelfChatBubble: View {

	let message: Message

	var body: some View {
		VStack(alignment: .trailing) {
			Text(message.formatDate()).font(.caption).foregroundColor(.gray)
			ChatBubble(direction: .right) {
				Text(message.content)
					.padding(.all, 15)
                    .foregroundColor(Color.onPrimary)
                    .background(Color.primary)
			}
		}.padding(EdgeInsets(top: 10, leading: 50, bottom: 10, trailing: 20))
	}
}

private struct ChatBubble<Content>: View where Content: View {
	let direction: ChatBubbleShape.Direction
	let content: () -> Content
	init(direction: ChatBubbleShape.Direction, @ViewBuilder content: @escaping () -> Content) {
			self.content = content
			self.direction = direction
	}

	var body: some View {
		HStack {
			if direction == .right {
				Spacer()
			}
			content().clipShape(ChatBubbleShape(direction: direction))
			if direction == .left {
				Spacer()
			}
		}
	}
}

private struct ChatBubbleShape: Shape {
	enum Direction {
		case left
		case right
	}

	let direction: Direction

	func path(in rect: CGRect) -> Path {
		return (direction == .left) ? getLeftBubblePath(in: rect) : getRightBubblePath(in: rect)
	}

	private func getLeftBubblePath(in rect: CGRect) -> Path {
		let width = rect.width
		let height = rect.height
		let path = Path { p in
			p.move(to: CGPoint(x: 25, y: height))
			p.addLine(to: CGPoint(x: width - 20, y: height))
			p.addCurve(to: CGPoint(x: width, y: height - 20),
					   control1: CGPoint(x: width - 8, y: height),
					   control2: CGPoint(x: width, y: height - 8))
			p.addLine(to: CGPoint(x: width, y: 20))
			p.addCurve(to: CGPoint(x: width - 20, y: 0),
					   control1: CGPoint(x: width, y: 8),
					   control2: CGPoint(x: width - 8, y: 0))
			p.addLine(to: CGPoint(x: 21, y: 0))
			p.addCurve(to: CGPoint(x: 4, y: 20),
					   control1: CGPoint(x: 12, y: 0),
					   control2: CGPoint(x: 4, y: 8))
			p.addLine(to: CGPoint(x: 4, y: height - 11))
			p.addCurve(to: CGPoint(x: 0, y: height),
					   control1: CGPoint(x: 4, y: height - 1),
					   control2: CGPoint(x: 0, y: height))
			p.addLine(to: CGPoint(x: -0.05, y: height - 0.01))
			p.addCurve(to: CGPoint(x: 11.0, y: height - 4.0),
					   control1: CGPoint(x: 4.0, y: height + 0.5),
					   control2: CGPoint(x: 8, y: height - 1))
			p.addCurve(to: CGPoint(x: 25, y: height),
					   control1: CGPoint(x: 16, y: height),
					   control2: CGPoint(x: 20, y: height))

		}
		return path
	}

	private func getRightBubblePath(in rect: CGRect) -> Path {
		let width = rect.width
		let height = rect.height
		let path = Path { p in
			p.move(to: CGPoint(x: 25, y: height))
			p.addLine(to: CGPoint(x:  20, y: height))
			p.addCurve(to: CGPoint(x: 0, y: height - 20),
					   control1: CGPoint(x: 8, y: height),
					   control2: CGPoint(x: 0, y: height - 8))
			p.addLine(to: CGPoint(x: 0, y: 20))
			p.addCurve(to: CGPoint(x: 20, y: 0),
					   control1: CGPoint(x: 0, y: 8),
					   control2: CGPoint(x: 8, y: 0))
			p.addLine(to: CGPoint(x: width - 21, y: 0))
			p.addCurve(to: CGPoint(x: width - 4, y: 20),
					   control1: CGPoint(x: width - 12, y: 0),
					   control2: CGPoint(x: width - 4, y: 8))
			p.addLine(to: CGPoint(x: width - 4, y: height - 11))
			p.addCurve(to: CGPoint(x: width, y: height),
					   control1: CGPoint(x: width - 4, y: height - 1),
					   control2: CGPoint(x: width, y: height))
			p.addLine(to: CGPoint(x: width + 0.05, y: height - 0.01))
			p.addCurve(to: CGPoint(x: width - 11, y: height - 4),
					   control1: CGPoint(x: width - 4, y: height + 0.5),
					   control2: CGPoint(x: width - 8, y: height - 1))
			p.addCurve(to: CGPoint(x: width - 25, y: height),
					   control1: CGPoint(x: width - 16, y: height),
					   control2: CGPoint(x: width - 20, y: height))

		}
		return path
	}
}
