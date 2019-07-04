//
//  ViewController.swift
//  fifaworldarya
//
//  Created by Arya S  Asok on 2019-07-02.
//  Copyright © 2019 Parrot. All rights reserved.
//

import UIKit

import WatchConnectivity

class ViewController: UITabBarController, WCSessionDelegate {
    
    var games: [Game]?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Get list of games from the server
        getFixtures()
        // Activate watch session
        if WCSession.isSupported() {
            let session = WCSession.default
            session.delegate = self
            session.activate()
        }
    }
    
    func getFixtures() {
        
        let urlString = "https://aryademo1-d4f92.firebaseio.com/fixtures.json"
        guard let url = URL(string: urlString) else {
            
            return
        }
        
        games = nil
        games = [Game]()
        
        let task = URLSession.shared.dataTask(with: url) { (data, response, error) in
            guard error == nil, data != nil else {
                print("Error getting data")
                return
            }
            
            if let result = try? JSONSerialization.jsonObject(with: data!, options: []) {
                if let fixtures = result as? [[String: Any]] {
                    for fixture in fixtures {
                        let game = Game(fixture)
                        self.games?.append(game)
                    }
                    DispatchQueue.main.async {
                        if let mapViewController = self.viewControllers![0] as? MapViewController {
                            mapViewController.games = self.games
                            mapViewController.reloadMap()
                        }
                        
                        if let scheduleViewController = self.viewControllers![1] as? ScheduleViewController {
                            scheduleViewController.games = self.games
                        }
                    }
                    self.sendGamesToWatch(data)
                }
            }
        }
        task.resume()
    }
    
    func sendGamesToWatch(_ data: Data?) {
        if WCSession.default.isReachable {
            WCSession.default.sendMessageData(data!, replyHandler: nil, errorHandler: nil)
        }
    }
    
    // WCSession delegate methods
    func session(_ session: WCSession, activationDidCompleteWith activationState: WCSessionActivationState, error: Error?) {
    }
    
    func sessionDidBecomeInactive(_ session: WCSession) {
        
    }
    
    func sessionDidDeactivate(_ session: WCSession) {
    }
    
    func sessionReachabilityDidChange(_ session: WCSession) {
        if session.isReachable {
            
        }
    }
}

