//
//  SprintNetworking.swift
//  Get It Write
//
//  Created by Hannah Dadd on 10/02/2026.
//

import FirebaseFirestore

final class SprintNetworking: ObservableObject {
    @Published var sprint: Sprint? = nil
    
    init() {
        Firestore.firestore().collection(DatabaseNames.sprint.rawValue).order(by: "timestamp", descending: true).limit(to: 1).getDocuments { (querySnapshot, error) in
            let newSprints = querySnapshot?.documents.map { Sprint(dictionary: $0.data(), id: $0.documentID) }.compactMap ({ $0 })
            self.sprint = newSprints?.first
        }
        
        Firestore.firestore().collection(DatabaseNames.sprint.rawValue)
            .addSnapshotListener { snapshot, error in
                if let error = error {
                    print("Error: \(error)")
                    return
                }
                
                guard let snapshot = snapshot else { return }
                
                for diff in snapshot.documentChanges {
                    if diff.type == .added {
                        if let newSprint = Sprint(dictionary: diff.document.data(), id: diff.document.documentID) {
                            self.sprint = newSprint
                        }
                    }
                }
            }
    }
    
}
