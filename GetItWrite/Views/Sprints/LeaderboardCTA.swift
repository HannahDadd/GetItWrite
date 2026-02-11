//
//  LeaderboardCTA.swift
//  Get It Write
//
//  Created by Hannah Dadd on 11/02/2026.
//

import SwiftUI

struct LeaderboardCTA: View {
    @AppStorage(UserDefaultNames.username.rawValue) private var username = ""
    @EnvironmentObject var networking: SprintNetworking
    
    @State var sprint: Sprint? = nil
    
    var body: some View {
        VStack {
            
        }
        .onAppear {
            networking.getLastSprint(completion: { s in
                sprint = s
            })
        }
    }
}
