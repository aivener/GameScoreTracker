//
//  GameLibraryDownloader.swift
//  GameScoreTracker
//
//  Created by Allie Ivener on 7/22/19.
//  Copyright © 2019 Allie Ivener. All rights reserved.
//

import Foundation
import FirebaseCore
import FirebaseFirestore

class GameLibraryDownloader {

    var gameLibraryArray = [String]()

    func downloadGameLibrary(completion: @escaping ([QueryDocumentSnapshot], Error?) -> Void) {
        let db = Firestore.firestore()
        var gameLibraryArray = [QueryDocumentSnapshot]()
        let query = db.collection("gameLibrary")
        query.getDocuments { snapshot, error in
            if let error = error {
                print(error)
                completion(gameLibraryArray, error)
                return
            }
            for doc in snapshot!.documents {
                let game = doc
                gameLibraryArray.append(game)
            }
            completion(gameLibraryArray, nil)
        }
    }
}
