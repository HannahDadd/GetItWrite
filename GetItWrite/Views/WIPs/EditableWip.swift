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
    
    let w: WIP
    let changeWips: ([WIP]) -> ()
    
    init(w: WIP, changeWips: @escaping ([WIP]) -> ()) {
        self.w = w
        self.title = w.title
        self.goal = w.goal
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
            VStack {
                Text("Edit Project")
                    .font(Font.custom("AbrilFatface-Regular", size: 34))
                QuestionSection(text: "Working Title:", response: $title)
                NumberSection(text: "Target Word Count:", response: $goal)
                HStack {
                    StretchedButton(text: "Save", action: {
                        if let data = UserDefaults.standard.data(forKey: UserDefaultNames.wips.rawValue) {
                            if let decoded = try? JSONDecoder().decode([WIP].self, from: data) {
                                var wips = decoded.filter { $0.id != w.id }
                                let newWip = WIP(id: w.id, title: title, count: w.count, goal: goal)
                                wips.insert(newWip, at: 0)
                                if let encoded = try? JSONEncoder().encode(wips) {
                                    UserDefaults.standard.set(encoded, forKey: UserDefaultNames.wips.rawValue)
                                    changeWips(wips)
                                    showSheet = false
                                }
                            }
                        }
                    })
                    StretchedButton(text: "Close", action: {
                        showSheet = false
                    })
                }
            }
        })
    }
}
