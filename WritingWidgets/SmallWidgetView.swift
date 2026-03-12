//
//  SmallWidgetView.swift
//  Get It Write
//
//  Created by Hannah Dadd on 11/03/2026.
//

import SwiftUI

struct SmallWidgetView: View {
    let entry: GetItWriteEntry
    
    var body: some View {
        WIPWidgetView(entry: entry, isMediumWidget: false)
    }
}
