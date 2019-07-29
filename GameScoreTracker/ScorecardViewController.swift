//
//  ScorecardViewController.swift
//  GameScoreTracker
//
//  Created by Allie Ivener on 7/27/19.
//  Copyright © 2019 Allie Ivener. All rights reserved.
//

import Foundation
import UIKit

class ScorecardViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    var gameName: String?
    var players: [Player]?
    
    @IBOutlet weak var gameNameLabel: UILabel!
    @IBOutlet weak var playerScoresTableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        gameNameLabel.text = gameName
        
        playerScoresTableView.delegate = self
        playerScoresTableView.dataSource = self
    }
    
    func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return players!.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = playerScoresTableView.dequeueReusableCell(withIdentifier: "PlayerScoreCell", for: indexPath as IndexPath) as UITableViewCell
        
        cell.textLabel?.text = players![indexPath.row].displayName
        
        return cell
    }

    // MARK: UITableViewDelegate Methods
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        
        let row = indexPath.row
        print(players![row].displayName)
    }
}
