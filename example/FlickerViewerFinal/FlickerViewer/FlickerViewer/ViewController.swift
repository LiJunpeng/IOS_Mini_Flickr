//
//  ViewController.swift
//  FlickerViewer
//
//  Created by Training on 11/08/14.
//  Copyright (c) 2014 Training. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
                            
    @IBOutlet var activity: UIActivityIndicatorView!
    @IBOutlet var flickrIconImageView: UIImageView!
    @IBOutlet var searchTextField: UITextField!
    @IBOutlet var flickrImageView: UIImageView!
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        

    }

    @IBAction func searchForImage(sender: AnyObject) {
        searchTextField.resignFirstResponder()
        
        flickrIconImageView.backgroundColor = UIColor.blackColor()
        activity.startAnimating()
        
        let flickr:FlickrHelper = FlickrHelper()
        
        if searchTextField.text.isEmpty {
            let alert:UIAlertController = UIAlertController(title: "Ooops", message: "Please enter a search term", preferredStyle: UIAlertControllerStyle.Alert)
            alert.addAction(UIAlertAction(title: "OK", style: UIAlertActionStyle.Default, handler: nil))
            
        }else{
            flickr.searchFlickrForString(searchTextField.text, completion: { (searchString:String!, flickrPhotos:NSMutableArray!, error:NSError!) -> () in
                
                if !error{
                
                    let flickrPhoto:FlickrPhoto = flickrPhotos.objectAtIndex(Int(arc4random_uniform(UInt32(flickrPhotos.count)))) as FlickrPhoto
                    
                    let image:UIImage = flickrPhoto.thumbnail
                    
                    dispatch_async(dispatch_get_main_queue(), {
                        self.flickrImageView.image = image
                        self.activity.stopAnimating()
                        self.flickrIconImageView.backgroundColor = UIColor.clearColor()
                    
                    })
                    
                }
                
                
                
                
                
            })
        }
        
        
        
        
    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

