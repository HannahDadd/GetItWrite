//
//  PositivitiesCritiqued.swift
//  Get It Write
//
//  Created by Hannah Dadd on 04/09/2024.
//

import SwiftUI

struct PositivitiesCritiqued: View {
    @EnvironmentObject var session: FirebaseSession
    @State private var result: Result<[RequestPositivity], Error>?
    @State var showPopUp = false
    
    var body: some View {
        switch result {
        case .success(let critiques):
            VStack {
                TitleAndSubtitle(
                    title: "Positivity Corner",
                    subtitle: "Positive vibes, from your community.")
                if !critiques.isEmpty {
                    ScrollView(.horizontal, showsIndicators: false) {
                        HStack {
                            ForEach(critiques, id: \.id) { c in
                                PositiveCard(p: c)
                            }
                        }.padding()
                    }
                }
            }
        case .failure(let error):
            ErrorView(error: error, retryHandler: loadRequests)
        case nil:
            ProgressView().onAppear(perform: loadRequests)
        }
    }
    
    private func loadRequests() {
        session.loadPositivities() {
            result = $0
        }
    }
}

struct PositiveCard: View {
    @State var showPopUp = false
    let p: RequestPositivity
    
    var body: some View {
        VStack(alignment: .leading, spacing: 8) {
            Text("Just positivie vibes")
                .foregroundColor(Color.onCardBackground)
                .multilineTextAlignment(.leading)
                .lineLimit(2)
            Spacer()
            HStack {
                Spacer()
                Text("\(p.comments.count) comments")
                    .padding(6)
                    .font(.caption)
                    .foregroundColor(Color.black)
            }
        }
        .onTapGesture {
            showPopUp = true
        }
        .padding()
        .frame(width: CGFloat(150), height: CGFloat(50))
        .background(Color.primary)
        .cornerRadius(8)
        .sheet(isPresented: self.$showPopUp) {
            PositivityPopUp(showPopUp: $showPopUp, isAccountPage: true)
        }
    }
}
