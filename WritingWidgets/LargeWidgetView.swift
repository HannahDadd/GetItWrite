//
//  LargeWidgetView.swift
//  Get It Write
//
//  Created by Hannah Dadd on 11/03/2026.
//

import SwiftUI

struct LargeWidgetView: View {
    let entry: GetItWriteEntry
    
    var body: some View {
        ForEach(entry.wips, id: \.id) { w in
            WIPWidgetView(wip: w, isMediumWidget: false)
            Divider()
        }
    }
}
