//
//  DataModel.swift
//  DocSearch
//
//  Created by Rohit Gurnani on 15/04/16.
//  Copyright © 2016 Rohit Gurnani. All rights reserved.
//

import Foundation
class DataModel {
    
    static let sharedInstance = DataModel()
    var localFiles : [Document] = []
    var searchResultFiles : [Document] = []
    
    init()
    {
        print("data model initialised")
        loadData()
    }
    
    
    
    func loadData(){
        loadLocalFiles()
    }
    
    func saveLocalFiles()
    {
        let data = NSMutableData()
        let archiver = NSKeyedArchiver(forWritingWithMutableData: data)
        archiver.encodeObject(localFiles, forKey: "Files")
        archiver.finishEncoding()
        data.writeToFile(dataFilePath("Files"), atomically: true)
        debugPrint("saved local documents to disk")
    }
    
    func loadLocalFiles()
    {
        let path = dataFilePath("Files")
        if NSFileManager.defaultManager().fileExistsAtPath(path) {
            if let data = NSData(contentsOfFile: path) {
                let unarchiver = NSKeyedUnarchiver(forReadingWithData: data)
                localFiles = unarchiver.decodeObjectForKey("Files") as! [Document]
                unarchiver.finishDecoding()
            }
        }
    }
    
    
    //MARK: filepath helper functions
    
    func documentsDirectory() -> String {
        let paths = NSSearchPathForDirectoriesInDomains(.DocumentDirectory, .UserDomainMask, true)
        return paths[0]
    }
    
    func dataFilePath(fileName : String) -> String {
        return (documentsDirectory() as NSString).stringByAppendingPathComponent(fileName + ".plist")
    }

}
