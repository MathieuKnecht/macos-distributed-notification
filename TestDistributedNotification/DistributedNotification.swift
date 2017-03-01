//
//  DistributedNotification.swift
//  TestDistributedNotification
//
//  Created by Mathieu Knecht on 09.02.17.
//  Copyright © 2017 Mathieu Knecht. All rights reserved.
//

import Foundation

class DistributedNotification {
    private var shouldQuitCheckInterval = 1.0
    private var shouldQuit = false
    
    func run(){
        
        // Init LogManager
        LogManager.shared.filePath = "/var/log/DNHelper.log"
        LogManager.shared.resetFile()
        LogManager.shared.log(line: "Helper: started ...")
        
        // Init notification registration
        NotificationManager.shared.registerForNotification(name: .Helper) { (command, argument) in
            LogManager.shared.log(line: "Helper: command: "+command+", argument: "+argument)
        }
        
        // Keep alive loop
        while !shouldQuit {
            RunLoop.current.run(until: Date.init(timeIntervalSinceNow: shouldQuitCheckInterval))
        }
    }
}
