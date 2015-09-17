//
//  TVShowCell.swift
//  MoviewShowcase
//
//  Created by Hardik on 15/09/15.
//  Copyright © 2015 HDG. All rights reserved.
//

import UIKit

class TVShowCell: UICollectionViewCell {
    @IBOutlet weak var IBimgTVShow:UIImageView!
    @IBOutlet weak var IBimgTVShowTitle:UILabel!
    
    func configureData(movie:TVShow) {
        if let title = movie.tvShowTitle {
            IBimgTVShowTitle.text = title
        }
        
        if let path = movie.tvShowPoster {
            let url = NSURL(string: path)
            
            dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT,0)) {
                if let imgUrl = url as NSURL! {
                    let data = NSData(contentsOfURL: imgUrl)
                    if data != nil {
                        dispatch_async(dispatch_get_main_queue()) {
                            self.IBimgTVShow.image = UIImage(data: data!)
                            
                        }
                    }
                    
                }
                
                
            }
        }
    }
    
}
