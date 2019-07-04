//
//  SubscribedController.swift
//  fifaworldarya WatchKit Extension
//
//  Created by Arya S  Asok on 2019-07-02.
//  Copyright © 2019 Parrot. All rights reserved.
//

import WatchKit

import WatchKit

class SubscribedController: WKInterfaceController {
    
    @IBOutlet weak var scheduleTable: WKInterfaceTable!
    @IBOutlet weak var noSubscribed: WKInterfaceLabel!
    
    var games: [Game]?
    
    override func awake(withContext context: Any?) {
        if let games = context as? [Game] {
            self.games = games
        }
        addNotificationObserver()
        loadTable()
    }
    
    func addNotificationObserver() {
        NotificationCenter.default.addObserver(self, selector: #selector(handleNotification(_:)), name: NSNotification.Name(rawValue: "Subscription"), object: nil)
    }
    
    @objc func handleNotification(_ notification: Notification) {
        
        if let userInfo = notification.userInfo, let game = userInfo["game"] as? Game, let subscribed = userInfo["subscribed"] as? Bool {
            
            if subscribed == true {
                games?.append(game)
            } else {
                games = games?.filter {
                    return $0.fifaId != game.fifaId
                }
                print("Here")
            }
            loadTable()
        }
    }
    
    func loadTable(){
        if let games = self.games, games.count > 0  {
            scheduleTable.setHidden(false)
            noSubscribed.setHidden(true)
            
            scheduleTable.setNumberOfRows(games.count, withRowType: "GameRow")
            
            for index in 0..<games.count {
                guard let controller = scheduleTable.rowController(at: index) as? GameRowController else {
                    continue
                }
                controller.game = games[index]
            }
        } else {
            scheduleTable.setHidden(true)
            noSubscribed.setHidden(false)
        }
    }
    
    override func didDeactivate() {
        NotificationCenter.default.removeObserver(self)
    }
}
