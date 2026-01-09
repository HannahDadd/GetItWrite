//
//  GoalHomepageSection.swift
//  Get It Write
//
//  Created by Hannah Dadd on 05/09/2024.
//

import SwiftUI

//struct GoalHomepageSection: View {
//    @EnvironmentObject var session: FirebaseSession
//    @State private var result: Result<Goal, Error>?
//    
//    var body: some View {
//        switch result {
//        case .success(let users):
//            VStack(alignment: .leading) {
//                TitleAndSubtitle(title: "Recommended critique partners", subtitle: "Specially picked out for you.")
//                LazyVGrid(columns: [GridItem(), GridItem(), GridItem()]) {
//                    ForEach(users) { u in
//                        RecCard(user: u, size: 100)
//                    }
//                }.padding(.horizontal)
//            }
//        case .failure(let error):
//            ErrorView(error: error, retryHandler: loadRequests)
//        case nil:
//            ProgressView().onAppear(perform: loadRequests)
//        }
//    }
//    
//    private func loadRequests() {
//        session.getRecs() {
//            result = $0
//        }
//    }
//}
