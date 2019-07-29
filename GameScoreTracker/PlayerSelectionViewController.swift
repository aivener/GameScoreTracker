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
    
    var playerPickerData: [Player] = [Player]()
    let playersDownloader = PlayersDownloader()
    @IBOutlet weak var playerPicker: UIPickerView!
    
    @IBOutlet weak var selectedPlayersText: UITextView!
    
    @IBOutlet weak var gameNameLabel: UILabel!
    var currentGameName: String?
    
    var selectedPlayers: [Player] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let settings = FirestoreSettings()
        Firestore.firestore().settings = settings
        db = Firestore.firestore()
        
        // Connect data:
        self.playerPicker.delegate = self
        self.playerPicker.dataSource = self
        
        initializePlayers()
        
        gameNameLabel.text = currentGameName
    }
    
    func initializePlayers() {
        playersDownloader.downloadPlayers() { players, error in
            if let error = error {
                //self.alert(title: "Error", message: error.localizedDescription)
                print(error)
                return
            }
            players.forEach{ player in
                let currPlayer = Player(playerId: player.documentID, displayName: player.get("displayName") as! String)
                self.playerPickerData.append(currPlayer)
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
        return self.playerPickerData[row].displayName
    }
    
    @IBAction func pickPlayersButton(_ sender: Any) {
        print("players picked")
        let selectedRow = playerPicker.selectedRow(inComponent: 0)
        let selectedPlayerName = playerPickerData[selectedRow]
        selectedPlayersText.text.append(selectedPlayerName.displayName)
        selectedPlayers.append(selectedPlayerName)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        guard let scorecardViewController = segue.destination as? ScorecardViewController //,
//            let index = tableView.indexPathForSelectedRow?.row
            else {
                return
        }
        // just pass through selected game name
        scorecardViewController.gameName = currentGameName
        scorecardViewController.players = selectedPlayers
    }
}
