//
//  YelpRepo.swift
//  Yelper
//
//  Created by Kushal Bhatt on 9/19/15.
//  Copyright © 2015 Kushal Bhatt. All rights reserved.
//
import Foundation

private let consumerKey = "u5lK2lrWU7IAR3QIEu04KQ"
private let consumerSecret = "KwldfReN7JTQTjiufFOx9qXuRX4"
private let accessToken = "vsprJ9N-TfpqiJtYlYOG3EZFaWuaIrhC"
private let accessSecret = "2c-lwD9vE38DRiQYyRsqHWaSZC0"
private let baseUrl = NSURL(string: "https://api.yelp.com/v2/")

class YelpClient: BDBOAuth1RequestOperationManager {
    var name: String?
    var ownerHandle: String?
    var ownerAvatarURL: String?
    var stars: Int?
    var forks: Int?
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    init() {
        super.init(baseURL: baseUrl, consumerKey: consumerKey, consumerSecret: consumerSecret)
        let credential = BDBOAuth1Credential(token: accessToken, secret: accessSecret, expiration: nil)
        self.requestSerializer.saveAccessToken(credential)
        
    }
    
    func search(settings: YelpSearchSettings,
        successCallback: ([YelperRepo]) -> Void,
        error: (NSError? -> Void)?)  {
            let params = queryParamsWithSettings(settings)
            self.GET("search", parameters: params
                , success: { (operation:AFHTTPRequestOperation!, responseObject: AnyObject!) -> Void in
                    if let results = responseObject["businesses"] as? NSArray {
                        var repos: [YelperRepo] = []
                        for result in results as! [NSDictionary] {
                            repos.append(YelperRepo(jsonResult: result))
                        }
                        successCallback(repos)
                    }
                }, failure:{ (operation: AFHTTPRequestOperation!, requestError: NSError!) -> Void in
                    NSLog("Error calling Yelp API", requestError)
                    if let errorCallback = error {
                        errorCallback(requestError)
                    }
                })
    }
    
    func queryParamsWithSettings(settings: YelpSearchSettings) -> [String: String] {
        var params: [String:String] = [:];
        
        params["location"] = settings.location
        if let searchString = settings.searchString {
            params["term"] = searchString
        }
        params["limit"] = String(settings.limit)
        params["offset"]  = String(settings.offset)
        
        return params;
    }
    
}