//
//  GameSelectionViewController.swift
//  GameScoreTracker
//
//  Created by Allie Ivener on 7/22/19.
//  Copyright © 2019 Allie Ivener. All rights reserved.
//

import UIKit
import FirebaseCore
import FirebaseFirestore
import Pods_GameScoreTracker

class GameSelectionViewController: UIViewController, UIPickerViewDelegate, UIPickerViewDataSource {

    var db: Firestore!
    
    var gamePickerData: [String] = [String]()
    let gameLibraryDownloader = GameLibraryDownloader()
    @IBOutlet weak var gamePicker: UIPickerView!
    @IBOutlet weak var selectGameButton: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        let settings = FirestoreSettings()
        Firestore.firestore().settings = settings
        db = Firestore.firestore()
        
        // Connect data:
        self.gamePicker.delegate = self
        self.gamePicker.dataSource = self
        
        initializeGameLibrary()
    }
    
    func initializeGameLibrary() {
        gameLibraryDownloader.downloadGameLibrary() { gameLibraryData, error in
            if let error = error {
                //self.alert(title: "Error", message: error.localizedDescription)
                print(error)
                return
            }
            gameLibraryData.forEach{ game in
                self.gamePickerData.append(game.get("displayName") as! String)
            }
            self.gamePicker.reloadAllComponents()
        }
    }
    
    // Number of columns of data
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    // The number of rows of data
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return self.gamePickerData.count
    }
    
    // The data to return for the row and component (column) that's being passed in
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return self.gamePickerData[row]
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        guard let playerSelectionViewController = segue.destination as? PlayerSelectionViewController //,
            // let index = tableView.indexPathForSelectedRow?.row
            else {
                return
        }
        let selectedRow = gamePicker.selectedRow(inComponent: 0)
        playerSelectionViewController.currentGameName = gamePickerData[selectedRow]
    }
}
