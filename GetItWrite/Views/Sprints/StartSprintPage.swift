//
//  StartSprintPage.swift
//  Get It Write
//
//  Created by Hannah Dadd on 09/01/2026.
//

import SwiftUI

struct StartSprintPage: View {
    @State var selectWIP: Bool = false
    @Binding var project: WIP?
    @Binding var sprintState: SprintState
    
    var body: some View {
        VStack(spacing: 8) {
            Text("Let's Sprint!")
                .font(Font.custom("AbrilFatface-Regular", size: 34))
                .padding(.bottom, 16)
            if let project = project {
                Text("Project:")
                    .font(Font.custom("Bellefair-Regular", size: 18))
                    .multilineTextAlignment(.leading)
                WIPView(w: project)
                    .onTapGesture {
                        selectWIP.toggle()
                    }
            }
            Button("Choose a different project", action: {
                selectWIP = true
            })
            Spacer()
            StretchedButton(text: "Start", action: {
                sprintState = .sprint
            })
        }
        .padding()
        .sheet(isPresented: $selectWIP) {
            SelectWip(action: { wip in
                project = wip
                selectWIP = false
            })
        }
    }
}
