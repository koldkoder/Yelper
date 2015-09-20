//
//  YelperSearchSettings.swift
//  Yelper
//
//  Created by Kushal Bhatt on 9/19/15.
//  Copyright © 2015 Kushal Bhatt. All rights reserved.
//


import Foundation


class YelpSearchSettings {
    var searchString: String?
    var minReviews = 0
    var location = "San Francisco"
    var offset = 0
    var limit = 20
    
    init() {
        searchString = "food"
    }
}