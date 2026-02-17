//
//  PrivacyPolicy.swift
//  Get It Write
//
//  Created by Hannah Dadd on 17/02/2026.
//

import SwiftUI

struct PrivacyPolicy: View {
    
    var body: some View {
        ScrollView {
            VStack(spacing: 30) {
                Text("PRIVACY POLICY")
                    .font(Font.custom("AbrilFatface-Regular", size: 34))
                Text("""
 Effective Date: 17/02/2026
 App Name: Get It Write
 Contact Email: getitwrite@gmail.com
 We value your privacy. This Privacy Policy explains how we collect, use, and protect your information.
 1. Information We Collect
 a. User Content
 Project titles and goals
 Word counts and statistics
 Achievement progress
 Streak data
 b. Device Information
 Anonymous data collected by Apple as standard
 c. Notifications
 We may use local notifications to remind you to write or maintain streaks.
 2. How We Use Information
 We use your information to:
 Provide writing sprint functionality
 Track word counts and statistics
 Maintain daily streaks
 Award achievement badges
 We do not sell your personal data.
 3. Data Storage
 Your content may be stored:
 Locally on your device
 We use reasonable security measures but cannot guarantee absolute security.
 4. Data Sharing
 Data is stored only locally on your device.
 5. Data Retention
 Data is stored only locally on your device.
 6. Children’s Privacy
 The App is not intended for children under 18. We do not knowingly collect personal data from children without parental consent.
 10. Changes to This Policy
 We may update this Privacy Policy. Continued use of the App after changes means you accept the revised policy.
 11. Contact Us
 For privacy questions or requests:
 getitwrite@gmail.com
""")
                .font(Font.custom("Bellefair-Regular", size: 18))
                
            }
            .padding()
        }
    }
}
