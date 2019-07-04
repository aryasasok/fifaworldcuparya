//
//  ScheduleController.swift
//  fifaworldarya WatchKit Extension
//
//  Created by Arya S  Asok on 2019-07-02.
//  Copyright © 2019 Parrot. All rights reserved.
//

import WatchKit

class ScheduleController: WKInterfaceController {
    
    @IBOutlet weak var scheduleTable: WKInterfaceTable!
    @IBOutlet weak var noGamesLabel: WKInterfaceLabel!
    
    var games: [Game]?
    
    override func awake(withContext context: Any?) {
        if let games = context as? [Game] {
            self.games = games
        }
        loadTable()
    }
    
    func loadTable(){
        if let games = self.games, games.count > 0  {
            scheduleTable.setHidden(false)
            noGamesLabel.setHidden(true)
            
            scheduleTable.setNumberOfRows(games.count, withRowType: "GameRow")
            
            for index in 0..<games.count {
                guard let controller = scheduleTable.rowController(at: index) as? GameRowController else {
                    continue
                }
                controller.game = games[index]
            }
        } else {
            scheduleTable.setHidden(true)
            noGamesLabel.setHidden(false)
        }
    }
    
    
}

