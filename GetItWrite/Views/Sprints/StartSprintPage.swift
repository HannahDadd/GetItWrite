//
//  StartSprintPage.swift
//  Get It Write
//
//  Created by Hannah Dadd on 09/01/2026.
//

import SwiftUI

struct StartSprintPage: View {
    let duration: String
    @Binding var selectWIP: Bool
    @Binding var project: WIP?
    @Binding var sprintState: SprintState
    @Binding var startWordCount: Int
    
    var body: some View {
        VStack(spacing: 8) {
            Text("Let's Sprint!")
                .font(Font.custom("AbrilFatface-Regular", size: 34))
                .padding(.bottom, 16)
            Text(duration)
            if let project = project {
                Text("Project:")
                    .font(Font.custom("Bellefair-Regular", size: 18))
                    .multilineTextAlignment(.leading)
                WIPView(w: project)
                    .onTapGesture {
                        selectWIP.toggle()
                    }
            }
            Spacer()
            StretchedButton(text: "Start", action: {
                sprintState = .sprint
            })
        }
        .padding()
        .sheet(isPresented: $selectWIP) {
            SelectWip(action: { wip in
                project = wip
                startWordCount = wip.count
                selectWIP = false
            })
        }
    }
}
