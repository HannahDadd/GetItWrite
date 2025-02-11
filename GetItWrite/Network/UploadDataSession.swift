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
    case critiqueFrenzy = "frenzy"
    case queryFrenzy = "queries"
    case proposals = "proposals"
    case positivityPeices = "positivityPeices"
    case questions = "questions"
    case replies = "replies"
    case reportedContent = "reportedContent"
    case messages = "messages"
    case successfulQuery = "successfulQuery"
    case bulletin = "bulletin"
}

extension FirebaseSession {
    
    func newQuestion(question: String, completion: @escaping (Error?) -> Void) {
        guard let userData = self.userData else { return }
        
        let q = Question(id: UUID().uuidString, question: question, questionerId: userData.id, questionerName: userData.displayName, questionerColour: userData.colour, timestamp: Timestamp())
        
        Firestore.firestore().collection(DatabaseNames.questions.rawValue).document(q.id).setData(q.dictionary as [String : Any]) { (err) in
                completion(err)
            }
    }
    
    func sendReply(content: String, questionId: String) {
        guard let userData = self.userData else { return }
        let reply = Reply(reply: content, replierId: userData.id, replierName: userData.displayName, replierColour: userData.colour, timestamp: Timestamp())

        Firestore.firestore().collection(DatabaseNames.questions.rawValue).document(questionId).collection(DatabaseNames.replies.rawValue).document(reply.id).setData(reply.dictionary as [String : Any]) { (err) in
            if err != nil { print(err.debugDescription) }
        }
    }
    
    func newPositivity(text: String, completion: @escaping (Error?) -> Void) {
        guard let userData = self.userData else { return }
        let id = UUID().uuidString
        
        let p = RequestPositivity(id: id, text: text.replacingOccurrences(of: "\\n{2,}", with: "\n", options: .regularExpression), writerId: userData.id, writerName: userData.displayName, comments: [:])
        
        Firestore.firestore()
            .collection(DatabaseNames.positivityPeices.rawValue)
            .document(id)
            .setData(p.dictionary as [String : Any]) { (err) in
                Firestore.firestore()
                    .collection(DatabaseNames.positivityPeices.rawValue)
                    .document("ids")
                    .getDocument { (querySnapshot, error) in
                        if let err = error {
                            completion(err)
                        } else {
                            if let data = querySnapshot?.data(),
                               let ids = IDsArray(dictionary: data) {
                                ids.ids = ids.ids + [p.id]
                                Firestore.firestore()
                                    .collection(DatabaseNames.positivityPeices.rawValue)
                                    .document("ids")
                                    .setData(ids.dictionary as [String : Any]) { (err) in
                                        completion(err)
                                    }
                            } else {
                                completion(CustomError(title: "Failed to upload id", description: "", code: 2))
                            }
                        }
                    }
            }
    }
    
    func newBulletin(text: String, completion: @escaping (Error?) -> Void) {
        guard let userData = self.userData else { return }
        
        let bulletin = Bulletin(id: UUID().uuidString, timestamp: Timestamp(), writerName: userData.displayName, writerId: userData.id, text: text.replacingOccurrences(of: "\\n{2,}", with: "\n", options: .regularExpression))
        
        Firestore.firestore()
            .collection(DatabaseNames.bulletin.rawValue)
            .document(bulletin.id)
            .setData(bulletin.dictionary as [String : Any]) { (err) in
                completion(err)
            }
    }
    
    func newSuccessfulQuery(text: String, notes: String, completion: @escaping (Error?) -> Void) {
        guard let userData = self.userData else { return }
        
        let successfulQuery = SuccessfulQuery(id: UUID().uuidString, timestamp: Timestamp(), writerName: userData.displayName, writerId: userData.id, text: text.replacingOccurrences(of: "\\n{2,}", with: "\n", options: .regularExpression), notes: notes.replacingOccurrences(of: "\\n{2,}", with: "\n", options: .regularExpression))
        
        Firestore.firestore()
            .collection(DatabaseNames.successfulQuery.rawValue)
            .document(successfulQuery.id)
            .setData(successfulQuery.dictionary as [String : Any]) { (err) in
                completion(err)
            }
    }
    
    func newCritiqueFrenzy(isQueries: Bool, text: String, genres: [String], completion: @escaping (Error?) -> Void) {
        guard let userData = self.userData else { return }
        
        let requestCritique = RequestCritique(id: UUID().uuidString, title: isQueries ? "Query Frenzy" : "Critique Frenzy", blurb: "", genres: genres, timestamp: Timestamp(), writerName: userData.displayName, writerId: userData.id, workTitle: isQueries ? "Query Frenzy" : "Critique Frenzy", text: text.replacingOccurrences(of: "\\n{2,}", with: "\n", options: .regularExpression), triggerWarnings: [])
        
        Firestore.firestore()
            .collection(isQueries ? DatabaseNames.queryFrenzy.rawValue : DatabaseNames.critiqueFrenzy.rawValue)
            .document(requestCritique.id)
            .setData(requestCritique.dictionary as [String : Any]) { (err) in
                completion(err)
            }
    }
    
    func newCritiqueRequest(title: String, text: String, userId: String, project: Proposal, completion: @escaping (Error?) -> Void) {
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
        
        let collectionName = c.projectTitle == "Query Frenzy" ? DatabaseNames.queryFrenzy.rawValue : (c.projectTitle == "Critique Frenzy" ? DatabaseNames.critiqueFrenzy.rawValue : DatabaseNames.critiques.rawValue)
        
        Firestore.firestore().collection(DatabaseNames.users.rawValue).document(requestCritique.writerId).collection(collectionName).document().setData(c.dictionary as [String : Any]) { (err) in
            if err == nil {
                Firestore.firestore().collection(DatabaseNames.users.rawValue).document(userData.id).collection(DatabaseNames.requestCritiques.rawValue).document(requestCritique.id).delete()
            }
            completion(err)
        }
    }
    
    func submitPositvity(p: RequestPositivity, completion: @escaping (Error?) -> Void) {
        
        Firestore.firestore()
            .collection(DatabaseNames.users.rawValue).document(p.writerId)
            .collection(DatabaseNames.positivityPeices.rawValue).document(p.id).setData(p.dictionary as [String : Any]) { (err) in
            if err == nil {
                Firestore.firestore()
                    .collection(DatabaseNames.positivityPeices.rawValue).document(p.id).setData(p.dictionary as [String : Any]) { (err) in
                        if err != nil {
                            completion(err)
                        }
                    }
            }
            completion(err)
        }
    }
    
    func newProposal(title: String, blurb: String, genres: [String], triggerWarnings: [String], wordCount: Int, authorNotes: String, typeOfProject: [String], completion: @escaping (Error?) -> Void) {
        guard let userData = self.userData else { return }
        
        let p = Proposal(id: UUID().uuidString, title: title, typeOfProject: typeOfProject, blurb: blurb, genres: genres, timestamp: Timestamp(), writerName: userData.displayName, writerId: userData.id, triggerWarnings: triggerWarnings, wordCount: wordCount, authorNotes: authorNotes)
        
        Firestore.firestore().collection(DatabaseNames.proposals.rawValue).document().setData(p.dictionary as [String : Any]) { (err) in
            completion(err)
        }
    }
    
    func reportContent(content: UserGeneratedContent, message: String, contentType: DatabaseNames, questionId: String?, completion: @escaping (Error?) -> Void) {
        guard let userData = self.userData else { return }
        
        Firestore.firestore().collection(DatabaseNames.reportedContent.rawValue).document().setData(content.dictionary as [String : Any]) { (err) in
            if err == nil {
                if contentType == .critiques {
                    Firestore.firestore().collection(DatabaseNames.users.rawValue).document(userData.id).collection(DatabaseNames.critiques.rawValue).document(content.id).delete()
                } else if contentType == .replies {
                    Firestore.firestore().collection(DatabaseNames.questions.rawValue)
                        .document(questionId ?? "")
                        .collection(DatabaseNames.replies.rawValue)
                        .document(content.id)
                        .delete()
                } else {
                    Firestore.firestore().collection(contentType.rawValue).document(content.id).delete()
                }
            }
            completion(err)
        }
    }
}
