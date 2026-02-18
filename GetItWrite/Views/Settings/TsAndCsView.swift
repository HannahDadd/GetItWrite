//
//  TsAndCsView.swift
//  Get It Write
//
//  Created by Hannah Dadd on 17/02/2026.
//

import SwiftUI

struct TsAndCsView: View {
    
    var body: some View {
        ScrollView {
            VStack(spacing: 30) {
                Text("TERMS OF SERVICE")
                    .font(Font.custom("AbrilFatface-Regular", size: 34))
                Text("""
 Effective Date: 17/02/2026
 App Name: Get It Write
 Contact Email: getitwrite@gmail.com
 These Terms of Service (“Terms”) govern your use of Get It Write (the “App”). By using the App, you agree to these Terms.
 1. Eligibility
 You must be at least 18 years old (or the minimum age required in your jurisdiction) to use the App.
 2. Description of Service
 Get it Write is a creative writing productivity app that allows users to:
 Participate in timed writing sprints
 Track daily writing streaks
 Set writing goals and projects
 Earn achievement badges
 View statistics such as words written and sprint history
 Receive daily local notifications for reminders
 We may modify or discontinue features at any time.
 3. Account Registration
 We are not liable for unauthorized account access due to your failure to safeguard login credentials.
 4. User Content
 You retain full ownership of the writing you create using the App.
 By using the App, you grant us a limited, non-exclusive license to:
 Store your content
 Display it within your account
 Process it to provide app features (e.g., word count, statistics, streak tracking)
 We do not claim ownership of your creative work.
 You are responsible for backing up your content unless otherwise stated.
 5. Acceptable Use
 You agree not to:
 Violate laws or regulations
 Infringe intellectual property rights
 Interfere with or disrupt the App
 Attempt to manipulate statistics, streaks, or achievements
 Reverse engineer or exploit the software
 6. Notifications
 The App may send local notifications for writing reminders or streak tracking. You can disable notifications in your device settings.
 7. Termination
 We may suspend or terminate your account if you violate these Terms. You may stop using the App at any time.
 8. Disclaimer of Warranties
 The App is provided “as is” and “as available.” We make no warranties regarding:
 Uninterrupted availability
 Accuracy of statistics or tracking
 Data loss prevention
 Use the App at your own risk.
 9. Limitation of Liability
 To the maximum extent permitted by law,Get it Write is not liable for:
 Indirect, incidental, or consequential damages
 Loss of data or creative work
 Loss of streaks, achievements, or statistics
 10. Changes to Terms
 We may update these Terms periodically. Continued use of the App after updates constitutes acceptance of the revised Terms.
 11. Contact
 For questions, contact:
 getitwrite@gmail.com
""")
                .font(Font.custom("Bellefair-Regular", size: 18))
                
            }
            .padding()
        }
    }
}

