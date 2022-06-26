//
//  GetItWriteApp.swift
//  GetItWrite
//
//  Created by Hannah Dadd on 23/01/2022.
//

import SwiftUI
import Firebase
import GoogleSignIn

@main
struct GetItWriteApp: App {
    init() {
        FirebaseApp.configure()
    }
    
    var body: some Scene {
        WindowGroup {
            ContentView()
        }
    }
}

class AppDelegate: NSObject, UIApplicationDelegate {
  func application(
	_ application: UIApplication,
	didFinishLaunchingWithOptions
	  launchOptions: [UIApplication.LaunchOptionsKey: Any]? = nil
  ) -> Bool {
	return true
  }
}
