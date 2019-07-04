//
//  GameRowController.swift
//  fifaworldarya WatchKit Extension
//
//  Created by Arya S  Asok on 2019-07-02.
//  Copyright © 2019 Parrot. All rights reserved.
//

import UIKit
import WatchKit

class GameRowController: NSObject {
    
    @IBOutlet weak var teamALabel: WKInterfaceLabel!
    @IBOutlet weak var teamAFlagLabel: WKInterfaceLabel!
    @IBOutlet weak var teamBFlagLabel: WKInterfaceLabel!
    @IBOutlet weak var teamBLabel: WKInterfaceLabel!
    @IBOutlet weak var locationLabel: WKInterfaceLabel!
    @IBOutlet weak var dateLabel: WKInterfaceLabel!
    
    static let dateFormatter = DateFormatter()
    
    var game: Game? {
        didSet {
            guard let game = game else {
                return
            }
            
            teamALabel.setText(game.teamA)
            teamBLabel.setText(game.teamB)
            teamAFlagLabel.setText(self.getTeamFlag(for: game.teamA))
            teamBFlagLabel.setText(self.getTeamFlag(for: game.teamB))
            locationLabel.setText("\(game.location) \(game.venue)")
            GameRowController.dateFormatter.dateFormat = "dd-MMM HH:mm"
            dateLabel.setText(GameRowController.dateFormatter.string(from: game.date!))
        }
    }
    
  private func getTeamFlag(for team: String) -> String {
        
        switch team {
        case "Norway":
            return "🇳🇴"
        case "Netherlands":
            return "🇳🇱"
        case "England":
            return "🏴󠁧󠁢󠁥󠁮󠁧󠁿"
        case "France":
            return "🇫🇷"
        case "USA":
            return "🇺🇸"
        case "Italy":
            return "🇮🇹"
        case "Germany":
            return "🇩🇪"
        case "Sweden":
            return "🇸🇪"
        case "TBA":
            return "\u{2700}"
        default:
            return "\u{2700}"
        }
    }
    
}
