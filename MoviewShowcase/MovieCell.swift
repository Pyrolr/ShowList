//
//  MovieCell.swift
//  MoviewShowcase
//
//  Created by Hardik on 15/09/15.
//  Copyright © 2015 HDG. All rights reserved.
//

import UIKit

class MovieCell: UICollectionViewCell {
    @IBOutlet weak var IBimgMoview:UIImageView!
    @IBOutlet weak var IBlblMovieTitle:UILabel!
    
    func configureData(movie:Movie) {
        if let title = movie.movieTitle {
            IBlblMovieTitle.text = title
        }
        
        if let path = movie.moviePoster {
            let url = NSURL(string: path)
            
            dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT,0)) {
                if let imgUrl = url as NSURL! {
                    let data = NSData(contentsOfURL: imgUrl)
                    if data != nil {
                        dispatch_async(dispatch_get_main_queue()) {
                            self.IBimgMoview.image = UIImage(data: data!)
                            
                        }
                    }
                    
                }
                
                
            }
        }
    }
    
}
