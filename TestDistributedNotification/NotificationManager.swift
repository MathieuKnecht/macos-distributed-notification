//
//  NotificationManager.swift
//  TestDistributedNotification
//
//  Created by Mathieu Knecht on 09.02.17.
//  Copyright © 2017 Mathieu Knecht. All rights reserved.
//

import Foundation

class NotificationManager {
    
    static let shared = NotificationManager()
    
    func registerForNotification (name: NSNotification.Name, completion: @escaping (_ command: String, _ argument:String)->()){
        
        DistributedNotificationCenter.default().addObserver(forName: name, object: nil, queue: nil) { (notif) in
            LogManager.shared.log(line: "Helper: receive command")
            guard let info = notif.userInfo,
                let command = info["command"] as? String,
                let argument = info["argument"] as? String
                else {
                    return
            }
            completion(command, argument)
            
        }
    }
    
    func postNotification (name: NSNotification.Name, command:String, argument: String){    
        DistributedNotificationCenter.default().post(name: name, object: nil, userInfo: ["command": command, "argument": argument])
    }
}
