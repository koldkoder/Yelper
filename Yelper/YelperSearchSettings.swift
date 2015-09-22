//
//  YelperSearchSettings.swift
//  Yelper
//
//  Created by Kushal Bhatt on 9/19/15.
//  Copyright © 2015 Kushal Bhatt. All rights reserved.
//


import Foundation


class YelpSearchSettings {
    var searchString = "All"
    var categories: String?
    var location = "San Jose"
    var offset = 0
    var limit = 20
    var radiusFilter:Double?
    var sort="0"
    var deal:Bool?
    
    init() {
        
    }
}