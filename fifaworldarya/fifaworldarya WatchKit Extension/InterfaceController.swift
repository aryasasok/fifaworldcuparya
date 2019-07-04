//
//  InterfaceController.swift
//  fifaworldarya WatchKit Extension
//
//  Created by Arya S  Asok on 2019-07-02.
//  Copyright © 2019 Parrot. All rights reserved.
//

import WatchKit
import Foundation
import WatchConnectivity

class InterfaceController: WKInterfaceController, WCSessionDelegate {
    
    var games = [Game]()
    
    override func awake(withContext context: Any?) {
        super.awake(withContext: context)
        // Configure interface objects here.
    }
    
    override func willActivate() {
        // This method is called when watch view controller is about to be visible to user
        super.willActivate()
        if WCSession.isSupported() {
            let session = WCSession.default
            session.delegate = self
            session.activate()
        }
    }
    
    override func didDeactivate() {
        // This method is called when watch view controller is no longer visible
        super.didDeactivate()
    }
    @IBAction func scheduleButtonPressed() {
        self.pushController(withName: "Schedule", context: self.games)
    }
    @IBAction func subscribedButtonPressed() {
        self.pushController(withName: "Subscribed", context: self.games.filter{
            return $0.subscibed == true
        })
    }
    
    // WCSession delegate methods
    func session(_ session: WCSession, activationDidCompleteWith activationState: WCSessionActivationState, error: Error?) {
        
    }
    
    func session(_ session: WCSession, didReceiveMessage message: [String : Any]) {
        print(message)
        if let fifaId = message["fifaId"] as? String, let subscribed = message["subscribed"] as? Bool {
            
            if subscribed == true {
                print("Subscribed to \(fifaId)")
            } else {
                print("Unsubscribed from \(fifaId)")
            }
            
            // Update the game array
            for game in games {
                if game.fifaId == fifaId {
                    game.subscibed = subscribed
                    NotificationCenter.default.post(name: NSNotification.Name(rawValue: "Subscription"), object: nil, userInfo: [
                        "game" : game,
                        "subscribed" : subscribed
                        ])
                    break
                }
            }
        }
    }
    
    func session(_ session: WCSession, didReceiveMessageData messageData: Data) {
        
        if let result = try? JSONSerialization.jsonObject(with: messageData, options: []) {
            if let fixtures = result as? [[String: Any]] {
                for fixture in fixtures {
                    let game = Game(fixture)
                    self.games.append(game)
                }
            }
        }
    }
    
    override func contextForSegue(withIdentifier segueIdentifier: String) -> Any? {
        return self.games
    }
}
