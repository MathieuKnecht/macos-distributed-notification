//
//  main.swift
//  TestDistributedNotifier
//
//  Created by Mathieu Knecht on 09.02.17.
//  Copyright © 2017 Mathieu Knecht. All rights reserved.
//

import Foundation

NotificationManager.shared.postNotification(name: .Host, command: "triggerEvent", argument: "continue")
