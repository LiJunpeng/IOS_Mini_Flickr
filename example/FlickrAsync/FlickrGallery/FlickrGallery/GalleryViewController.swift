//
//  GalleryViewController.swift
//  FlickrGallery
//
//  Created by Training on 19/08/14.
//  Copyright (c) 2014 Training. All rights reserved.
//

import UIKit

class GalleryViewController: UIViewController, UICollectionViewDataSource, UICollectionViewDelegate, UIScrollViewDelegate {

    @IBOutlet var collectionView: UICollectionView!
    
    var searchTerm:String!
    
    
    var flickrResults:NSMutableArray! = NSMutableArray()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        collectionView.delegate = self
        collectionView.dataSource = self
        loadPhotos()
        // Do any additional setup after loading the view.
    }
    
    func loadPhotos(){
        let flickr:FlickrHelper = FlickrHelper()
        flickr.searchFlickrForString(searchTerm, completion: { (searchString:String!, flickrPhotos:NSMutableArray!, error:NSError!) -> () in
            
            if error == nil{
                
                dispatch_async(dispatch_get_main_queue(), {
                    self.flickrResults = NSMutableArray(array: flickrPhotos)
                    self.collectionView.reloadData()
                    
                    
                    
                })
            }
            
        })
        
    }

    
    func collectionView(collectionView: UICollectionView!, numberOfItemsInSection section: Int) -> Int {
        return flickrResults.count
    }
    
    func collectionView(collectionView: UICollectionView!, cellForItemAtIndexPath indexPath: NSIndexPath!) -> UICollectionViewCell! {
        let cell:FlickCollectionViewCell = collectionView.dequeueReusableCellWithReuseIdentifier("FlickrCell", forIndexPath: indexPath) as! FlickCollectionViewCell
        
        cell.image = nil
        
        let queue:dispatch_queue_t = dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0)
        
        dispatch_async(queue, { () -> Void in
            var error:NSError?
            
            let searchURL:String = self.flickrResults.objectAtIndex(indexPath.item) as! String
            let imageData:NSData = NSData(contentsOfURL: NSURL(string: searchURL), options: nil, error: &error)
            
            if error == nil{
                let image:UIImage = UIImage(data: imageData)
                
                dispatch_async(dispatch_get_main_queue(), {
                    cell.image = image
                    
                    let yOffset:CGFloat = ((collectionView.contentOffset.y - cell.frame.origin.y) / 200) * 25
                    cell.imageOffset = CGPointMake(0, yOffset)
                
                })
                
            }
            
        })
        
        
        return cell
    }
    
    func scrollViewDidScroll(scrollView: UIScrollView!) {
        
        for view in collectionView.visibleCells(){
            let view:FlickCollectionViewCell = view as! FlickCollectionViewCell
            let yOffset:CGFloat = ((collectionView.contentOffset.y - view.frame.origin.y) / 200) * 25
            
            view.setImageOffset(CGPointMake(0, yOffset))
            
        
        }
        
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

}
