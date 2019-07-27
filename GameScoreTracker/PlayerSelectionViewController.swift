//
//  PlayerSelectionViewController.swift
//  GameScoreTracker
//
//  Created by Allie Ivener on 7/25/19.
//  Copyright © 2019 Allie Ivener. All rights reserved.
//

import Foundation
import UIKit
import FirebaseCore
import FirebaseFirestore
import Pods_GameScoreTracker

class PlayerSelectionViewController: UIViewController, UIPickerViewDelegate, UIPickerViewDataSource {
    var db: Firestore!
    
    var playerPickerData: [String] = [String]()
    let playersDownloader = PlayersDownloader()
    @IBOutlet weak var playerPicker: UIPickerView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let settings = FirestoreSettings()
        Firestore.firestore().settings = settings
        db = Firestore.firestore()
        
        // Connect data:
        self.playerPicker.delegate = self
        self.playerPicker.dataSource = self
        
        initializePlayers()
    }
    
    func initializePlayers() {
        playersDownloader.downloadPlayers() { players, error in
            if let error = error {
                //self.alert(title: "Error", message: error.localizedDescription)
                print(error)
                return
            }
            players.forEach{ player in
                self.playerPickerData.append(player.get("displayName") as! String)
            }
            self.playerPicker.reloadAllComponents()
        }
    }
    
    // Number of columns of data
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    // The number of rows of data
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return self.playerPickerData.count
    }
    
    // The data to return for the row and component (column) that's being passed in
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return self.playerPickerData[row]
    }
    
    @IBAction func pickPlayersButton(_ sender: Any) {
        print("players picked")
    }
    
}
