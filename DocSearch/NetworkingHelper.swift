//
//  NetworkingHelper.swift
//  DocSearch
//
//  Created by Rohit Gurnani on 14/04/16.
//  Copyright © 2016 Rohit Gurnani. All rights reserved.
//

import Foundation
import Alamofire
import SwiftyJSON


enum HTTPRequestAuthType {
    case HTTPBasicAuth
    case HTTPTokenAuth
}

enum HTTPRequestContentType {
    case HTTPJsonContent
    case HTTPMultipartContent
}

class NetworkingHelper {
    
    static let sharedInstance = NetworkingHelper()
    let dataHelper = DataHelper.sharedInstance
    
    let base_url = "http://127.0.0.1:8080/api"
    
    init()
    {
        print("network helper initiaised")
    }
    
    //MARK: Testing the api, through this function
    func testApi()
    {
        let test_url = "/test"
        let url = base_url + test_url
        
        print(url)
        
        let headers = [
            "content-type": "application/json",
            "cache-control": "no-cache"
        ]
        
        Alamofire.request(.GET, url,headers : headers).responseJSON{
            response in
            
            switch response.result {
            case .Success(let value): let json = JSON(value)
                print(json["hello"].stringValue)
                
            case .Failure(let error): debugPrint(error)
            }
        }
        
        
    }
    
    //MARK: Search Query api
    func searchDocSearch(searchString : String){
        
        let search_url = "/file/search"
        let url = base_url + search_url
        
        print(url)
        
        let headers = [
            "content-type": "application/json"
        ]
        let parameters = ["query" : searchString]
        
        Alamofire.request(.POST, url,parameters: parameters,encoding : .JSON,headers : headers).responseJSON{
            response in
            
            //print(response.request?.HTTPBody)
            
            switch response.result{
                
            case .Success(let value):
                print("Success")
                let json = JSON(value)
                let files = json["files"].arrayValue
                self.dataHelper.setSearchResults(files)
                
            case .Failure(let error): debugPrint(error)
                NSNotificationCenter.defaultCenter().postNotificationName("SearchResultsFailed", object: nil)
            }
        }
    }
    
    
    
    
    
    
    
    
    
    
    
    
    

}

extension NetworkingHelper {
    
    //color helper too
    func darkerColorForColor(color: UIColor) -> UIColor {
        
        var r:CGFloat = 0, g:CGFloat = 0, b:CGFloat = 0, a:CGFloat = 0
        
        if color.getRed(&r, green: &g, blue: &b, alpha: &a){
            return UIColor(red: max(r - 0.2, 0.0), green: max(g - 0.2, 0.0), blue: max(b - 0.2, 0.0), alpha: a)
        }
        
        return UIColor()
    }
    
    func lighterColorForColor(color: UIColor) -> UIColor {
        
        var r:CGFloat = 0, g:CGFloat = 0, b:CGFloat = 0, a:CGFloat = 0
        
        if color.getRed(&r, green: &g, blue: &b, alpha: &a){
            return UIColor(red: min(r + 0.2, 1.0), green: min(g + 0.2, 1.0), blue: min(b + 0.2, 1.0), alpha: a)
        }
        
        return UIColor()
    }
}
