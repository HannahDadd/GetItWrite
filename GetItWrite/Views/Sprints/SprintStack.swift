//
//  SprintStack.swift
//  Get It Write
//
//  Created by Hannah Dadd on 08/08/2025.
//

import SwiftUI
import SprintLiveActivityExtension

struct SprintStack: View {
    @State private var isSprinting = false
    @State private var timer: Timer? = nil
    @State var viewModel: SprintActivityViewModel?
    
    @State var sprintState: SprintState = .start
    @State var project: WIP? = nil
    @State var badgesEarnt: [Badge] = []
    @State var wordsWritten: Int = 0
    
    let time: Int
    let action: () -> Void
    var waitingTime: Int?
    
    var body: some View {
        VStack {
            switch sprintState {
            case .start:
                StartSprintPage(project: $project, sprintState: $sprintState)
            case .sprint:
                SprintView(endState: {
                    sprintState = .end
                }, time: time)
                .onAppear {
                    startSprint()
                }
            case .end:
                SprintEndPage(sprintState: $sprintState, badgesEarnt: $badgesEarnt, project: $project, wordsWritten: $wordsWritten, minutes: time)
                    .onAppear {
                        finishSprint()
                    }
            case .showResults:
                PostSprintAcheivementsPage(project: project, wordsWritten: wordsWritten, badgesEarnt: badgesEarnt, action: action)
            }
        }
        .frame(maxWidth: .infinity)
        .onAppear {
            if let data = UserDefaults.standard.data(forKey: UserDefaultNames.wips.rawValue) {
                if let decoded = try? JSONDecoder().decode([WIP].self, from: data) {
                    if !decoded.isEmpty {
                        project = decoded.first
                        wordsWritten = project?.count ?? 0
                    }
                }
            }
        }
        .onDisappear {
            finishSprint()
        }
    }
    
    func startSprint() {
        isSprinting = true
        viewModel = SprintActivityViewModel(bookName: project?.title ?? "", duration: TimeInterval(time))
        
        timer = Timer.scheduledTimer(withTimeInterval: 1.0, repeats: true) { _ in
            viewModel?.elapsedTime += 1
            viewModel?.progress = min((viewModel?.elapsedTime ?? 1) / (viewModel?.duration ?? 1), 1.0)
            viewModel?.updateLiveActivity()
            
            // End print when complete
            if viewModel?.elapsedTime ?? 1 >= viewModel?.duration ?? 1 {
                finishSprint()
            }
        }
        
        // Start Live Activity
        viewModel?.startLiveActivity()
    }
    
    func finishSprint() {
        timer?.invalidate()
        timer = nil
        isSprinting = false
        
        // End Live Activity with success
        viewModel?.endLiveActivity(success: true)
    }
}

enum SprintState {
    case start
    case sprint
    case end
    case showResults
}
