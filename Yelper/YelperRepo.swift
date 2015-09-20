//
//  YelpRepo.swift
//  Yelper
//
//  Created by Kushal Bhatt on 9/19/15.
//  Copyright © 2015 Kushal Bhatt. All rights reserved.
//
import Foundation

class YelperRepo {
    
    var name: String?
    var imageUrl: NSURL?
    var ratingImageUrl: NSURL?
    var reviewsCount: Int?
    var address: String?
    var categories: [String]?
    
    
    init(jsonResult: NSDictionary) {
        
        if let name = jsonResult["name"] as? String {
            self.name = name
        }
        
        if let imageUrl = jsonResult["image_url"] as? String {
            let httpsUrl = imageUrl.stringByReplacingOccurrencesOfString("http://", withString: "https://")
            self.imageUrl = NSURL(string: httpsUrl)
        }
        
        if let ratingImageUrl = jsonResult["rating_img_url_large"] as? String {
            let httpsUrl = ratingImageUrl.stringByReplacingOccurrencesOfString("http://", withString: "https://")
            self.ratingImageUrl = NSURL(string: httpsUrl)
        }
        
        if let reviewsCount = jsonResult["review_count"] as? Int {
            self.reviewsCount = reviewsCount
        }
        
        
        if let location = jsonResult["location"] as? NSDictionary {
            if let addresses = location["address"] as? [NSString] {
                if(addresses.count > 0) {
                    if let address = addresses[0] as? String {
                        self.address = address
                    }
                }
            }
        }
        
        if let categoriesArray = jsonResult["categories"] as? NSArray {
            self.categories = categoriesArray.map({ (item) -> String in
                return item[0] as! String
            })
        }
    }
    

    
}