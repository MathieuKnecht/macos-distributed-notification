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
        
        LogManager.shared.resetFile()
        NotificationManager.shared.registerForNotification(name: .Host) { (command, argument) in
            LogManager.shared.log(line: "command "+command+" arg: "+argument, filename: "host.log")
        }
        
        while !shouldQuit {
            RunLoop.current.run(until: Date.init(timeIntervalSinceNow: shouldQuitCheckInterval))
        }
    }
}
