//
//  DownloadSession.swift
//  GetItWrite
//
//  Created by Hannah Billingsley-Dadd on 20/05/2022.
//

import Firebase

enum DatabaseNames: String {
    case users = "users"
    case projects = "projects"
    case requestCritiques = "requestCritiques"
    case critiques = "critiques"
    case proposals = "proposals"
    case reportedContent = "reportedContent"
}

extension FirebaseSession {
    
    func newProject(title: String, blurb: String, genres: [String], triggerWarnings: [String], completion: @escaping (Result<Project, Error>) -> Void) {
        guard let userData = self.userData else { return }
        
        let project = Project(id: UUID().uuidString, title: title, blurb: blurb, genres: genres, timestamp: Timestamp(), writerName: userData.displayName, writerId: userData.id, triggerWarnings: triggerWarnings)
        
        Firestore.firestore().collection(DatabaseNames.projects.rawValue).document().setData(project.dictionary as [String : Any]) { (err) in
            if let error = err {
                completion(.failure(error))
            } else {
                completion(.success(project))
            }
        }
    }
    
    func newCritiqueRequest(title: String, text: String, userId: String, project: Project, completion: @escaping (Error?) -> Void) {
        guard let userData = self.userData else { return }
        
        let requestCritique = RequestCritique(id: UUID().uuidString, title: title, blurb: project.blurb, genres: project.genres, timestamp: Timestamp(), writerName: userData.displayName, writerId: userData.id, workTitle: project.title, text: text.replacingOccurrences(of: "\\n{2,}", with: "\n", options: .regularExpression), triggerWarnings: project.triggerWarnings)
        
        Firestore.firestore().collection(DatabaseNames.users.rawValue).document(userId).collection(DatabaseNames.requestCritiques.rawValue)
            .document().setData(requestCritique.dictionary as [String : Any]) { (err) in
                completion(err)
            }
    }
    
    func submitCritique(requestCritique: RequestCritique, comments: [Int: String], overallFeedback: String, completion: @escaping (Error?) -> Void) {
        guard let userData = self.userData else { return }
        
        let c = Critique(id: requestCritique.id, comments: Dictionary(uniqueKeysWithValues: comments.map({ ($1, $0) })), overallFeedback: overallFeedback, critiquerId: userData.id, text: requestCritique.text, title: requestCritique.title, projectTitle: requestCritique.workTitle, critiquerName: userData.displayName, critiquerProfileColour: userData.colour, timestamp: Timestamp(), rated: false)
        
        Firestore.firestore().collection(DatabaseNames.users.rawValue).document(requestCritique.writerId).collection(DatabaseNames.critiques.rawValue).document().setData(c.dictionary as [String : Any]) { (err) in
            if err == nil {
                Firestore.firestore().collection(DatabaseNames.users.rawValue).document(userData.id).collection(DatabaseNames.requestCritiques.rawValue).document(requestCritique.id).delete()
            }
            completion(err)
        }
    }
    
    func newProposal(project: Project, wordCount: Int, authorNotes: String, typeOfProject: [String], completion: @escaping (Error?) -> Void) {
        guard let userData = self.userData else { return }
        
        let p = Proposal(id: UUID().uuidString, title: project.title, typeOfProject: typeOfProject, blurb: project.blurb, genres: project.genres, timestamp: Timestamp(), writerName: userData.displayName, writerId: userData.id, triggerWarnings: project.triggerWarnings, wordCount: wordCount, authorNotes: authorNotes)
        
        Firestore.firestore().collection(DatabaseNames.proposals.rawValue).document().setData(p.dictionary as [String : Any]) { (err) in
            completion(err)
        }
    }
    
    func reportContent(content: UserGeneratedContent, message: String, contentType: DatabaseNames, completion: @escaping (Error?) -> Void) {
        guard let userData = self.userData else { return }
        
        Firestore.firestore().collection(DatabaseNames.reportedContent.rawValue).document().setData(content.dictionary as [String : Any]) { (err) in
            if err == nil {
                Firestore.firestore().collection(contentType.rawValue).document(content.id).delete()
            }
            completion(err)
        }
    }
}
