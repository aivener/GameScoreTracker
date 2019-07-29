//
//  ScorecardViewController.swift
//  GameScoreTracker
//
//  Created by Allie Ivener on 7/27/19.
//  Copyright © 2019 Allie Ivener. All rights reserved.
//

import Foundation
import UIKit

class ScorecardViewController: UIViewController {
    
    var currentGameName: String?
    var currentPlayers: [Player]?
    
    @IBOutlet weak var gameNameLabel: UILabel!
    override func viewDidLoad() {
        super.viewDidLoad()
        
        gameNameLabel.text = currentGameName
    }
}
