//
//  TVShow.swift
//  MoviewShowcase
//
//  Created by Hardik on 15/09/15.
//  Copyright © 2015 HDG. All rights reserved.
//

import Foundation

class TVShow {
    let URL_BASE = "http://image.tmdb.org/t/p/w500"
    
    var tvShowTitle:String!
    var tvShowOverview:String!
    var tvShowPoster:String!
    
    init(TVShowDict:Dictionary<String,AnyObject>) {
        if let title = TVShowDict["original_name"] as? String {
            self.tvShowTitle = title
        }
        if let overview = TVShowDict["overview"] as? String {
            self.tvShowOverview = overview
        }
        if let path = TVShowDict["poster_path"] as? String {
            self.tvShowPoster = "\(URL_BASE)\(path)"
        }
    }
}