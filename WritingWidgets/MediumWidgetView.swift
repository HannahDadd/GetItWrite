//
//  MediumWidgetView.swift
//  Get It Write
//
//  Created by Hannah Dadd on 11/03/2026.
//

import SwiftUI

struct MediumWidgetView: View {
    let entry: GetItWriteEntry
    
    var body: some View {
        if let wip = entry.wips.first {
            WIPWidgetView(wip: wip, widgetType: .medium)
        } else {
            Text("Create a writing project on Get it Write to see your progress here!")
        }
    }
}
