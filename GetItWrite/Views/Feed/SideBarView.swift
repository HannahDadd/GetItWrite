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
					.foregroundColor(.gray)
					.imageScale(.large)
				Text("Profile")
					.foregroundColor(.gray)
					.font(.headline)
			}
			.padding(.top, 100)
			HStack {
				Image(systemName: "envelope")
					.foregroundColor(.gray)
					.imageScale(.large)
				Text("Messages")
					.foregroundColor(.gray)
					.font(.headline)
			}
			.padding(.top, 30)
			HStack {
				Image(systemName: "gear")
					.foregroundColor(.gray)
					.imageScale(.large)
				Text("Settings")
					.foregroundColor(.gray)
					.font(.headline)
			}
			.padding(.top, 30)
		}.padding()
			.frame(maxWidth: .infinity, alignment: .leading)
			.background(Color(red: 32/255, green: 32/255, blue: 32/255))
			.edgesIgnoringSafeArea(.all)
	}
}
