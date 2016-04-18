//
//  DataHelper.swift
//  DocSearch
//
//  Created by Rohit Gurnani on 14/04/16.
//  Copyright © 2016 Rohit Gurnani. All rights reserved.
//

import Foundation
import SwiftyJSON
class DataHelper {
    
    static let sharedInstance = DataHelper()
    
    let dataModel = DataModel.sharedInstance
    //let dataModel = DataModel.sharedInstance
    
    init()
    {
        print("Data helper initialised")
    }
    
    func setSearchResults(files : [JSON]){
        
        print(files)
        //in background
        self.dataModel.searchResultFiles = []
        for file in files {
            let newResult = Document(name: file["name"].stringValue)
            newResult.id = file["id"].intValue
            newResult.docDescription = file["description"].stringValue
            newResult.tagString = file["tagstring"].stringValue
            newResult.url = file["url"].stringValue
            newResult.yearUploaded = file["year_uploaded"].intValue
            newResult.format = file["format"].stringValue
            newResult.author = file["author"].stringValue
            self.dataModel.searchResultFiles.append(newResult)
            }
        print("search results loaded")
     NSNotificationCenter.defaultCenter().postNotificationName("SearchResultsLoaded", object: nil)
}
    
    
}
