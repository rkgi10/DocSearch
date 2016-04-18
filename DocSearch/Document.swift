//
//  Document.swift
//  DocSearch
//
//  Created by Rohit Gurnani on 15/04/16.
//  Copyright © 2016 Rohit Gurnani. All rights reserved.
//

import Foundation

class Document : NSObject, NSCoding {
    
    var name : String!
    var id : Int!
    var dateUploaded : NSDate?
    var yearUploaded : Int!
    var downloads : Int?
    var likes : Int?
    var size : Int?
    var docDescription : String!
    var author : String!
    var tagString : String?
    var format : String!
    var userId : Int?
    var url : String!
    var localPath : String?
    var docData : NSData?
    
    init(name : String){
        self.name = name
    }
    
    func encodeWithCoder(aCoder: NSCoder) {
        aCoder.encodeObject(name, forKey: "name")
        aCoder.encodeObject(id, forKey: "id")
        aCoder.encodeObject(dateUploaded, forKey: "dateUploaded")
        aCoder.encodeObject(yearUploaded, forKey: "yearUploaded")
        aCoder.encodeObject(downloads, forKey: "downloads")
        aCoder.encodeObject(likes, forKey: "likes")
        aCoder.encodeObject(size, forKey: "size")
        aCoder.encodeObject(docDescription, forKey: "docDescription")
        aCoder.encodeObject(author, forKey: "author")
        aCoder.encodeObject(tagString, forKey: "tagString")
        aCoder.encodeObject(format, forKey: "format")
        aCoder.encodeObject(userId, forKey: "userId")
        aCoder.encodeObject(url, forKey: "url")
        aCoder.encodeObject(localPath, forKey: "localPath")
        aCoder.encodeObject(docData, forKey: "docData")
    }
    
    required init?(coder aDecoder: NSCoder) {
        name = aDecoder.decodeObjectForKey("name") as! String
        id = aDecoder.decodeObjectForKey("id") as! Int
        dateUploaded = aDecoder.decodeObjectForKey("dateUploaded") as? NSDate
        yearUploaded = aDecoder.decodeObjectForKey("yearUploaded") as! Int
        downloads = aDecoder.decodeObjectForKey("downloads") as? Int
        likes = aDecoder.decodeObjectForKey("likes") as? Int
        size = aDecoder.decodeObjectForKey("size") as? Int
        docDescription = aDecoder.decodeObjectForKey("docDescription") as! String
        author = aDecoder.decodeObjectForKey("author") as! String
        tagString = aDecoder.decodeObjectForKey("tagString") as? String
        format = aDecoder.decodeObjectForKey("format") as! String
        userId = aDecoder.decodeObjectForKey("userId") as? Int
        url = aDecoder.decodeObjectForKey("url") as! String
        localPath = aDecoder.decodeObjectForKey("localPath") as? String
        docData = aDecoder.decodeObjectForKey("docData") as? NSData
        
    }
    
    
    
    
    
    
    
    
    
}