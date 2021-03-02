//
//  StoreManager.swift
//  EndPointTest
//
//  Created by YangWei on 2021/3/2.
//  Copyright © 2021 YangWei. All rights reserved.
//

import UIKit

let cachePath = NSSearchPathForDirectoriesInDomains(FileManager.SearchPathDirectory.cachesDirectory,
                                                    FileManager.SearchPathDomainMask.userDomainMask,
                                                    true).first! + "/TestData"
let cachePathUrl = URL(fileURLWithPath: cachePath)

extension Data {
    /// wirte data
    func write(toCachefilename:String) -> Bool {
        try? FileManager.default.createDirectory(at: cachePathUrl, withIntermediateDirectories: true, attributes: nil)
        
        let url = cachePathUrl.appendingPathComponent(toCachefilename)
        do {
            try self.write(to: url)
            return true
        }catch {
            return false
        }
    }
    /// read data
    init?(cachefileName:String) {
        let url = cachePathUrl.appendingPathComponent(cachefileName)
        do {
            try self.init(contentsOf: url, options: .alwaysMapped)
        }catch {
            return nil
        }
    }
}

class StoreManager: NSObject {
    
    func saveData(_ data: Data) {
        let datefmatter = DateFormatter()
        datefmatter.dateFormat = "yyyy年MM月dd日 HH:mm:ss"
        let fileName = datefmatter.string(from: Date())
        
        let result = data.write(toCachefilename: fileName)
        if result {
            updateLastFileName(fileName)
        }
    }
    
    func updateLastFileName(_ fileName: String) {
        let userDefault = UserDefaults.standard
        userDefault.set(fileName, forKey: "kLastFileName")
        userDefault.synchronize()
    }
    
    func fetchLastFileName() -> String? {
        return UserDefaults.standard.object(forKey: "kLastFileName") as? String
    }
}
