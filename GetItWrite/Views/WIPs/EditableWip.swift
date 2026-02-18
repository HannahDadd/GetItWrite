//
//  EditableWip.swift
//  Get It Write
//
//  Created by Hannah Dadd on 02/02/2026.
//

import SwiftUI

struct EditableWIPView: View {
    @State var showSheet = false
    @State var title = ""
    @State var goal = 0
    @State var currentWordCount = 0
    
    let w: WIP
    let changeWips: ([WIP]) -> ()
    
    init(w: WIP, changeWips: @escaping ([WIP]) -> ()) {
        self.w = w
        self.title = w.title
        self.goal = w.goal
        self.currentWordCount = w.count
        self.changeWips = changeWips
    }
    
    var body: some View {
        VStack(alignment: .leading, spacing: 30) {
            WIPView(w: w)
        }
        .onTapGesture {
            showSheet = true
        }
        .sheet(isPresented: $showSheet, content: {
            VStack(spacing: 22) {
                Text("Edit Project")
                    .font(Font.custom("AbrilFatface-Regular", size: 34))
                QuestionSection(text: "Working Title:", response: $title)
                NumberSection(text: "Target Word Count:", response: $goal)
                NumberSection(text: "Current Word Count:", response: $currentWordCount)
                Spacer()
                HStack {
                    StretchedButton(text: "Save", action: {
                        if let data = UserDefaults.standard.data(forKey: UserDefaultNames.wips.rawValue) {
                            if let decoded = try? JSONDecoder().decode([WIP].self, from: data) {
                                var wips = decoded.filter { $0.id != w.id }
                                let newWip = WIP(id: w.id, title: title, count: currentWordCount, goal: goal)
                                wips.append(newWip)
                                if let encoded = try? JSONEncoder().encode(wips) {
                                    UserDefaults.standard.set(encoded, forKey: UserDefaultNames.wips.rawValue)
                                    changeWips(wips)
                                    showSheet = false
                                }
                            }
                        }
                    })
                    StretchedButton(text: "Delete", action: {
                        if let data = UserDefaults.standard.data(forKey: UserDefaultNames.wips.rawValue) {
                            if let decoded = try? JSONDecoder().decode([WIP].self, from: data) {
                                let wips = decoded.filter { $0.id != w.id }
                                if let encoded = try? JSONEncoder().encode(wips) {
                                    UserDefaults.standard.set(encoded, forKey: UserDefaultNames.wips.rawValue)
                                    changeWips(wips)
                                    showSheet = false
                                }
                            }
                        }
                    })
                }
                Button(action: { showSheet = false }, label: { Text("Close") })
            }
            .padding()
        })
    }
}
