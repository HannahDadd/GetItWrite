//
//  SideBarView.swift
//  GetItWrite
//
//  Created by Hannah Billingsley-Dadd on 27/04/2022.
//

import SwiftUI

struct SideBarView: View {

	var body: some View {
		VStack(alignment: .leading) {
			HStack {
				Image(systemName: "person")
					.imageScale(.large)
				Text("Profile")
					.font(.headline)
			}.padding(.top, 100)
			HStack {
				Image(systemName: "envelope").imageScale(.large)
				Text("Messages").font(.headline)
			}.padding(.top, 30)
			HStack {
				Image(systemName: "gear").imageScale(.large)
				Text("Settings").font(.headline)
			}.padding(.top, 30)
			Spacer()
		}.padding()
			.frame(maxWidth: .infinity, alignment: .leading)
			.background(Color.darkBackground)
			.foregroundColor(.white)
			.edgesIgnoringSafeArea(.bottom)
	}
}
