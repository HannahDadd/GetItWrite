//
//  DownloadSession.swift
//  GetItWrite
//
//  Created by Hannah Billingsley-Dadd on 20/05/2022.
//

import Firebase

extension FirebaseSession {
    
    func newProject(title: String, blurb: String, genres: [String], triggerWarnings: [String], completion: @escaping (Result<Project, Error>) -> Void) {
        guard let userData = self.userData else { return }
        
        let project = Project(id: UUID().uuidString, title: title, blurb: blurb, genres: genres, timestamp: Timestamp(), writerName: userData.displayName, writerId: userData.id, triggerWarnings: triggerWarnings)
        
        Firestore.firestore().collection("projects").document().setData(project.dictionary as [String : Any]) { (err) in
            if let error = err {
                completion(.failure(error))
            } else {
                completion(.success(project))
            }
        }
    }
    
    func newCritiqueRequest(title: String, text: String, userId: String, project: Project) {
        guard let userData = self.userData else { return }
        
        let requestCritique = RequestCritique(id: UUID().uuidString, title: title, blurb: project.blurb, genres: project.genres, timestamp: Timestamp(), writerName: userData.displayName, writerId: userData.id, workTitle: project.title, text: text.replacingOccurrences(of: "\\n{2,}", with: "\n", options: .regularExpression), triggerWarnings: project.triggerWarnings)
        
        Firestore.firestore().collection("users").document(userId).collection("requestCritiques")
            .document().setData(requestCritique.dictionary as [String : Any]) { (err) in
                if err != nil { print(err.debugDescription) }
            }
    }
    
    func submitCritique(requestCritique: RequestCritique, comments: [Int: String], overallFeedback: String) {
        guard let userData = self.userData else { return }
        Firestore.firestore().collection("users").document(userData.id).collection("requestCritiques").document(requestCritique.id).delete()
        project.critiques.append(userData.id)
        
        Firestore.firestore().collection("projects").document(project.id).collection("critiques")
            .document().setData(["comments": Dictionary(uniqueKeysWithValues: comments.map({ ($1, $0) })),
                                 "overallFeedback": overallFeedback,
                                 "timestamp": FieldValue.serverTimestamp(),
                                 "critiquerProfieColour": userData.colour,
                                 "critiquerId": userData.id,
                                 "critiquerName": userData.displayName,
                                 "rated": false]) { (err) in }
        
        Firestore.firestore().collection("projects").document(project.id)
            .updateData(["critiques": project.critiques]) { (err) in }
    }
    
    func newProposal(project: Project, wordCount: Int, authorNotes: String, typeOfProject: [String]) {
        guard let userData = self.userData else { return }
        
        let p = Proposal(id: UUID().uuidString, title: project.title, typeOfProject: typeOfProject, blurb: project.blurb, genres: project.genres, timestamp: Timestamp(), writerName: userData.displayName, writerId: userData.id, triggerWarnings: project.triggerWarnings, wordCount: wordCount, authorNotes: authorNotes)
        
        Firestore.firestore().collection("proposals").document().setData(p.dictionary as [String : Any]) { (err) in
            if err != nil { return }
        }
    }
}
