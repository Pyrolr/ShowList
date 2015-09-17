//
//  Movie.swift
//  MoviewShowcase
//
//  Created by Hardik on 15/09/15.
//  Copyright © 2015 HDG. All rights reserved.
//

import Foundation

class Movie {
    let URL_BASE = "http://image.tmdb.org/t/p/w500"
    
    var movieTitle:String!
    var movieOverview:String!
    var moviePoster:String!
    
    init(MovieDict:Dictionary<String,AnyObject>) {
        if let title = MovieDict["original_name"] as? String {
            self.movieTitle = title
        }
        if let overview = MovieDict["overview"] as? String {
            self.movieOverview = overview
        }
        if let path = MovieDict["poster_path"] as? String {
            self.moviePoster = "\(URL_BASE)\(path)"
        }
    }
}