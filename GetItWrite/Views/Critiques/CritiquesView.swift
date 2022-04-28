//
//  CritiquesView.swift
//  GetItWrite
//
//  Created by Hannah Billingsley-Dadd on 27/04/2022.
//

import SwiftUI

struct CritiquesView: View {
	let work: Work

	var body: some View {
		List {
			ForEach(work.critiques, id: \.id) { i in
				CritiqueView(critique: i)
			}
		}.listStyle(PlainListStyle())
			.navigationBarTitle(work.title, displayMode: .inline)
	}
}
