//
//  GetItWriteApp.swift
//  GetItWrite
//
//  Created by Hannah Dadd on 23/01/2022.
//

import SwiftUI
import FirebaseCore

class AppDelegate: NSObject, UIApplicationDelegate {
    func application(_ application: UIApplication,
                     didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey : Any]? = nil) -> Bool {
        FirebaseApp.configure()
        return true
    }
}

@main
struct GetItWriteApp: App {
    @UIApplicationDelegateAdaptor(AppDelegate.self) var delegate
    var wip: WIP? = nil
    
    init() {
        if let data = UserDefaults.standard.data(forKey: UserDefaultNames.wips.rawValue) {
            if let decoded = try? JSONDecoder().decode([WIP].self, from: data) {
                wip = decoded.first
            }
        }
    }
    
    var body: some Scene {
        WindowGroup {
            if wip != nil {
                MainPage()
                    .navigationBarBackButtonHidden(true)
            } else {
                OnboardingStack()
            }
        }
    }
}
