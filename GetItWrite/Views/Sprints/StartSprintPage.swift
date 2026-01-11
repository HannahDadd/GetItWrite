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
        VStack(alignment: .leading, spacing: 30) {
            Text("Let's Sprint!")
                .font(.title)
                .padding(.bottom, 16)
            Text(duration)
            if let project = project {
                Text("Selected project")
                    .font(.headline)
                WIPView(w: project)
                Button("Change the WIP you're working on.") {
                    selectWIP.toggle()
                }
                .buttonStyle(.borderedProminent)
                .tint(.primary)
            } else {
                Button("Select the project you're working on.") {
                    selectWIP.toggle()
                }
                .buttonStyle(.borderedProminent)
                .tint(.primary)
            }
            NumberSection(text: "Start Word Count:", response: $startWordCount)
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
