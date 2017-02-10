//
//  LogManager.swift
//  NestleSplash
//
//  Created by Mathieu Knecht on 25.01.17.
//  Copyright © 2017 Mathieu Knecht. All rights reserved.
//

import Foundation

class LogManager {
    
    static let shared = LogManager()
    private let logPath = "/var/log/"
    private var filename = ""
    
    func log(line: String, filename: String) {
        if filename == "" { return }
        self.filename = filename
        print(line)
        self.writeLineToEndFile(line: line)
    }
    
    private func writeLineToEndFile(line: String) {
        
        let filemgr = FileManager.default
        
        if !filemgr.fileExists(atPath: logPath+filename) {
            filemgr.createFile(atPath: logPath+filename, contents: nil, attributes: nil)
        }
        
        self.writeLine(line: line)
    }
    
    private func writeLine (line: String) {
        if let filehandle = FileHandle(forWritingAtPath: logPath+filename) {
            let data = line.data(using: String.Encoding.utf8, allowLossyConversion: false)!
            filehandle.seekToEndOfFile()
            filehandle.write(data)
            filehandle.closeFile()
        }
    }
    
    func resetFile () {
        FileManager.default.createFile(atPath: logPath+filename, contents: nil, attributes: nil)
    }
    
}
