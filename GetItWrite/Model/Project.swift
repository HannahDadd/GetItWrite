//
//  Project.swift
//  GetItWrite
//
//  Created by Hannah Billingsley-Dadd on 20/02/2022.
//

import Firebase
import SwiftUI

class Project: Hashable {
	
	let id: String
	let title: String
	let synopsisSoFar: String
	let text: String
	let typeOfProject: String
	let blurb: String
	let genres: [String]
	let triggerWarnings: [String]
	var critiques: [String] // Array of user ids who have critiqued project
	let timestamp: Timestamp
	let writerId: String
	let writerName: String
	
	var dictionary: [String: Any?] {
		return [
			"text": text,
			"title": title,
			"genres": genres,
			"synopsisSoFar": synopsisSoFar,
			"typeOfProject": typeOfProject,
			"blurb": blurb,
			"timestamp": timestamp,
			"triggerWarnings": triggerWarnings,
			"writerId": writerId,
			"writerName": writerName,
			"critiques": critiques
		]
	}
	
	internal init(id: String, title: String, text: String, synopsisSoFar: String, typeOfProject: String, blurb: String, genres: [String], timestamp: Timestamp, writerName: String, writerId: String, critiques: [String], triggerWarnings: [String]) {
		self.id = id
		self.text = text
		self.title = title
		self.typeOfProject = typeOfProject
		self.synopsisSoFar = synopsisSoFar
		self.genres = genres
		self.blurb = blurb
		self.timestamp = timestamp
		self.writerName = writerName
		self.writerId = writerId
		self.triggerWarnings = triggerWarnings
		self.critiques = critiques
	}
}

extension Project {
	convenience init?(dictionary: [String: Any], id: String) {
		
		guard let text = dictionary["text"] as? String,
			  let title = dictionary["title"] as? String,
			  let synopsisSoFar = dictionary["synopsisSoFar"] as? String,
			  let typeOfProject = dictionary["typeOfProject"] as? String,
			  let genres = dictionary["genres"] as? [String],
			  let blurb = dictionary["blurb"] as? String,
			  let writerId = dictionary["writerId"] as? String,
			  let writerName = dictionary["writerName"] as? String,
			  let triggerWarnings = dictionary["triggerWarnings"] as? [String],
			  let timestamp = dictionary["timestamp"] as? Timestamp,
			  let critiques = dictionary["critiques"] as? [String]
		else { return nil }
		
		self.init(id: id, title: title, text: text, synopsisSoFar: synopsisSoFar, typeOfProject: typeOfProject, blurb: blurb, genres: genres, timestamp: timestamp, writerName: writerName, writerId: writerId, critiques: critiques, triggerWarnings: triggerWarnings)
	}
	
	static func == (lhs: Project, rhs: Project) -> Bool {
		return lhs.id == rhs.id
	}
	
	func hash(into hasher: inout Hasher) {
		hasher.combine(id)
	}
	
	func formatDate() -> String {
		let formatter = RelativeDateTimeFormatter()
		formatter.unitsStyle = .short
		return formatter.localizedString(for: timestamp.dateValue(), relativeTo: Date())
	}
}
