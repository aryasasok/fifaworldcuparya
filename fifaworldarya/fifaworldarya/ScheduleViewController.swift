//
//  ScheduleViewController.swift
//  fifaworldarya
//
//  Created by Arya S  Asok on 2019-07-02.
//  Copyright © 2019 Parrot. All rights reserved.
//

import Foundation
import UIKit
import WatchConnectivity

class ScheduleViewController: UIViewController, UITableViewDataSource, UITableViewDelegate, PhoneScheduleTableViewCellDelegate, WCSessionDelegate {
    
    @IBOutlet weak var scheduleTableview: UITableView!
    
    var games: [Game]?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        if WCSession.isSupported() {
            let session = WCSession.default
            session.delegate = self
            session.activate()
        }
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return games != nil ? games!.count : 0    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "ScheduleCell", for: indexPath) as! PhoneScheduleTableViewCell
        
        cell.configure(games![indexPath.row])
        cell.delegate = self
        return cell
    }
    
    //func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
       // return 134.0
    //}
    
    // Handle tap on subscribe button in cell
    func didToggleSubscribe(_ subscribed: Bool, in cell: PhoneScheduleTableViewCell) {
        if let indexPath = scheduleTableview.indexPath(for: cell), indexPath.row < games!.count {
            
            games![indexPath.row].subscibed = subscribed
            if WCSession.default.isReachable {
                let message : [String : Any] = [
                    "fifaId": games![indexPath.row].fifaId,
                    "subscribed": subscribed
                ]
                WCSession.default.sendMessage(message, replyHandler: nil, errorHandler: nil)
            }
        }
    }
    
    func session(_ session: WCSession, activationDidCompleteWith activationState: WCSessionActivationState, error: Error?) {
        
    }
    
    func sessionDidBecomeInactive(_ session: WCSession) {
        
    }
    
    func sessionDidDeactivate(_ session: WCSession) {
        
    }
}
