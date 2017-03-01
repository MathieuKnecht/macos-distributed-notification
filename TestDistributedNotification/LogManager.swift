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
    public var filePath: String?
    private var filepath : String! {
        get{
            guard let tt = self.filePath
                else{
                    print("log file not initialized, default file /var/log/defaultFile.log will be used")
                    return "/var/log/defaultFile.log"
            }
            return tt
        }
    }
    
    func log(line: String) {
        
        let filemgr = FileManager.default
        
        if !filemgr.fileExists(atPath: filepath) {
            filemgr.createFile(atPath: filepath, contents: nil, attributes: nil)
        }
        
        print(line)
        self.writeLine(line: line+"\n")
    }
    
    private func writeLine (line: String) {
        
        if let filehandle = FileHandle(forWritingAtPath: filepath) {
            let data = line.data(using: String.Encoding.utf8, allowLossyConversion: false)!
            filehandle.seekToEndOfFile()
            filehandle.write(data)
            filehandle.closeFile()
        }
    }
    
    func resetFile () {
        FileManager.default.createFile(atPath: filepath, contents: nil, attributes: nil)
    }
    
}
