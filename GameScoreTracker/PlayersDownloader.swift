//
//  PlayersDownloader.swift
//  GameScoreTracker
//
//  Created by Allie Ivener on 7/27/19.
//  Copyright © 2019 Allie Ivener. All rights reserved.
//

import Foundation
import FirebaseCore
import FirebaseFirestore

class PlayersDownloader {
    
    var playersArray = [String]()
    
    func downloadPlayers(completion: @escaping ([QueryDocumentSnapshot], Error?) -> Void) {
        let db = Firestore.firestore()
        var playersArray = [QueryDocumentSnapshot]()
        let query = db.collection("players")
        query.getDocuments { snapshot, error in
            if let error = error {
                print(error)
                completion(playersArray, error)
                return
            }
            for doc in snapshot!.documents {
                let player = doc
                playersArray.append(player)
            }
            completion(playersArray, nil)
        }
    }
}
