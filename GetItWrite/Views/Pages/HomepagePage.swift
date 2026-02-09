//
//  Homepage.swift
//  Get It Write
//
//  Created by Hannah Dadd on 20/10/2025.
//

import SwiftUI

struct HomepagePage: View {
    @AppStorage(UserDefaultNames.username.rawValue) private var username = ""
    @StateObject private var navigationManager = NavigationManager<HomepageRoute>()
    @State var path = NavigationPath([HomepageRoute.tally])
    @State var createWIP = false
    @State var wips: [WIP]
    
    init(wips: [WIP]) {
        self.wips = wips
    }
    
    var body: some View {
        NavigationStack(path: $navigationManager.path) {
            VStack(alignment: .leading) {
                ScrollView {
                    VStack(spacing: 20) {
                        HeadlineAndSubtitle(title: "Hey, future best selling author", subtitle: "Let's get that manuscript written.")
                        HStack {
                            Text("Your username: \(username)")
                                .bold()
                                .multilineTextAlignment(.leading)
                            Spacer()
                        }
                        TallyCTA(action: {
                            navigationManager.navigate(to: .tally)
                        })
                        NotificationCTA()
                        StreakCTA()
                        Divider()
                        ForEach(wips, id: \.id) { w in
                            EditableWIPView(w: w, changeWips: { wips in
                                self.wips = wips
                            })
                        }
                        StretchedButton(text: "Create Project", action: {
                            createWIP = true
                        })
                    }
                    .padding()
                }
                .scrollIndicators(.hidden)
            }
            .onAppear {
                if username == "" {
                    username = generateWriterUsername()
                }
            }
            .navigationDestination(for: HomepageRoute.self) { route in
                switch route {
                case .tally:
                    ExtendTally(action: {
                        navigationManager.reset()
                    })
                }
            }
            .navigationDestination(for: Int.self) { selection in
                Text("You selected \(selection)")
            }
            .sheet(isPresented: $createWIP) {
                NewWIP(wips: wips, action: { newWIP in
                    wips = newWIP
                    createWIP = false
                })
            }
        }
    }
    
    func generateWriterUsername() -> String {
        let writingWords = [
            "plot", "story", "prose", "verse", "novel", "library",
            "ink", "quill", "draft", "scribe", "author", "writer",
            "fiction", "lore", "chapter", "narrative", "word", "text",
            "pen", "script", "paper", "parchment", "litarature", "letter",
            "world", "storybook", "book"
        ]
        
        let suffixes = [
            "lover", "crafter", "weaver", "dreamer", "builder",
            "maker", "thinker", "nut", "elf", "fairy", "dragon",
            "wizard", "mage", "genius", "expert", "griffin", "spinx",
            "pheonix", "pegasus", "centaur"
        ]
        
        let word = writingWords.randomElement()!
        let suffix = suffixes.randomElement()!
        let number = Int.random(in: 100...999)
        
        return "\(word)\(suffix)\(number)"
    }
}

enum HomepageRoute {
    case tally
}
