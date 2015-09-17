//
//  ViewController.swift
//  MoviewShowcase
//
//  Created by Hardik on 14/09/15.
//  Copyright © 2015 HDG. All rights reserved.
//

import UIKit

class ViewController: UIViewController,UICollectionViewDataSource,UICollectionViewDelegate,UICollectionViewDelegateFlowLayout {
    @IBOutlet weak var IBcollectionview: UICollectionView!

    let URL_BASE = "http://api.themoviedb.org/3/tv/popular?api_key=6a50b17d75490848034c3d61545b0a2a"
    
    //296,461
    
    let defaultImageSize = CGSizeMake(269,389)
    let focusImageSize = CGSizeMake(296,428)
    
    var arrTVShow = [TVShow]()
    
    // MARK: - Memory Managment methods
    
    // ---------------------------------------------------------------------
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    // ---------------------------------------------------------------------
    
    deinit {
        
    }
    
    // ---------------------------------------------------------------------
    
    // MARK: - Custom methods
    
    // ---------------------------------------------------------------------
    
    func baseSetup() {
        IBcollectionview.delegate = self
        IBcollectionview.dataSource = self
        
        downloadData()
    }
    
    // ---------------------------------------------------------------------
    
    func downloadData() {
        let url = NSURL(string:URL_BASE)
        let request = NSURLRequest(URL: url!)
        let task = NSURLSession.sharedSession().dataTaskWithRequest(request) { (data,response,error) -> Void in
            
            if error != nil {
                print("Error %@",error?.localizedDescription)
            } else {
                do {
                   let dict = try NSJSONSerialization.JSONObjectWithData(data!, options:NSJSONReadingOptions.AllowFragments) as? Dictionary<String,AnyObject>
                    
                   
                    
                    if let result = dict!["results"] as? [Dictionary<String,AnyObject>] {
                        for obj in result {
                            let show = TVShow(TVShowDict:obj)
                            self.arrTVShow.append(show)
                        }
                        
                        dispatch_async(dispatch_get_main_queue()) {
                            self.IBcollectionview.reloadData()
                        }
                    }
                } catch {
                    
                }
            }
        }
        task.resume()
    }
    
    override func didUpdateFocusInContext(context: UIFocusUpdateContext, withAnimationCoordinator coordinator: UIFocusAnimationCoordinator) {
        if let prevView = context.previouslyFocusedView as? TVShowCell {
            UIView.animateWithDuration(0.1, animations: { () -> Void in
                prevView.IBimgTVShow.frame.size = self.defaultImageSize
            })
        }
        
        if let nextView = context.nextFocusedView as? TVShowCell {
            UIView.animateWithDuration(0.1, animations: { () -> Void in
                nextView.IBimgTVShow.frame.size = self.focusImageSize
            })
        }
    }
    
    func tapped(gesture:UITapGestureRecognizer) {
        if let cell = gesture.view as? TVShowCell {
            print("Title \(cell.IBimgTVShowTitle)")
            let storyboard = UIStoryboard(name: "Main", bundle: nil)
            let vc = storyboard.instantiateViewControllerWithIdentifier("DetailVC") as! DetailViewController
            self.presentViewController(vc, animated:true, completion:nil)
        }
    }
    
    //---------------------------------------------------------------------
    
    // MARK: - Collectionview Methods
    
    //---------------------------------------------------------------------
    
    func collectionView(collectionView: UICollectionView, cellForItemAtIndexPath indexPath: NSIndexPath) -> UICollectionViewCell {
        
        if let cell = collectionView.dequeueReusableCellWithReuseIdentifier("TVShowCell", forIndexPath:indexPath) as? TVShowCell {
            let show = arrTVShow[indexPath.row]
            
            if cell.gestureRecognizers?.count == nil {
                let tapRecognizer = UITapGestureRecognizer(target: self, action:"tapped:")
                tapRecognizer.allowedPressTypes = [NSNumber(integer: UIPressType.Select.rawValue)];
                cell.addGestureRecognizer(tapRecognizer)
            }
            
            cell.configureData(show)
            return cell
        } else {
         return TVShowCell()
        }
    }
    
    // ---------------------------------------------------------------------
    
    func collectionView(collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return arrTVShow.count
    }
    
    // ---------------------------------------------------------------------
    
    func collectionView(collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAtIndexPath indexPath: NSIndexPath) -> CGSize {
       return CGSizeMake(304,478)
    }
    
    // ---------------------------------------------------------------------
    
    // MARK: - Life cycle methods
    
    // ---------------------------------------------------------------------
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.baseSetup()
        // Do any additional setup after loading the view, typically from a nib.
    }
    
    // ---------------------------------------------------------------------


}

