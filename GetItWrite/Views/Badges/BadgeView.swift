//
//  Badge.swift
//  Get It Write
//
//  Created by Hannah Dadd on 21/10/2025.
//

import SwiftUI

//struct BadgeView: View {
//    @State var showPopUp = false
//    
//    init() {
//        
//        if let data = UserDefaults.standard.data(forKey: title) {
//            if let decoded = try? JSONDecoder().decode(Badge.self, from: data) {
//                badge = decoded
//            } else {
//                badge = Badge(id: UUID().hashValue, score: 0, title: title)
//            }
//        } else {
//            badge = Badge(id: UUID().hashValue, score: 0, title: title)
//        }
//    }
//    
//    var body: some View {
//        VStack(alignment: .center, spacing: 8) {
//            ZStack {
//                Circle()
//                    .fill(shouldShowPopup ? Color.tappableBadgeBG : Color.badgeBg)
//                    .frame(width: 50, height: 50)
//                Text("\(badge.score)")
//                    .foregroundStyle(Color.white)
//                    .font(Font.custom("AbrilFatface-Regular", size: 24))
//            }
//            Text(badge.title).bold()
//        }
//        .onTapGesture(count: 2) {
//            if !showPopUp {
//                resetValue()
//            }
//        }
//        .onTapGesture(count: 1) {
//            if shouldShowPopup {
//                showPopUp = true
//            } else {
//                badge.score = badge.score + 1
//                BadgeView.incrementBadge(incrementBy: 1, badge: BadgeTitles(rawValue: badge.title) ?? BadgeTitles.booksPublished)
//            }
//        }
//        .alert(onTapText, isPresented: $showPopUp) {
//            Button("Close", role: .cancel) { }
//        }
//    }
//}
