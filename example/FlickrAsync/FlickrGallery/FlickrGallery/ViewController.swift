//
//  ViewController.swift
//  FlickrGallery
//
//  Created by Training on 19/08/14.
//  Copyright (c) 2014 Training. All rights reserved.
//

import UIKit

class ViewController: UIViewController, UISearchBarDelegate {
                            
    @IBOutlet var searchBar: UISearchBar!
    @IBOutlet var imageView: UIImageView!
    
    var step:Int = 0
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        searchBar.becomeFirstResponder()
        searchBar.delegate = self
    }
    
    
    func searchBar(searchBar: UISearchBar!, textDidChange searchText: String!) {
        UIView.animateWithDuration(0.4, delay: 0, usingSpringWithDamping: 0.3, initialSpringVelocity: 0.8, options: UIViewAnimationOptions.CurveEaseOut, animations: { () -> Void in
            
            if self.step == 0{
                self.imageView.transform = CGAffineTransformMakeScale(1.09, 1.09)
                self.step = 1
            }else{
                self.imageView.transform = CGAffineTransformIdentity
                self.step = 0
            }
            
        }, completion: nil)
    }
    
    func searchBarCancelButtonClicked(searchBar: UISearchBar!) {
        searchBar.text = ""
    }

    override func prepareForSegue(segue: UIStoryboardSegue!, sender: AnyObject!) {
        let destinationViewController:GalleryViewController = segue.destinationViewController as! GalleryViewController
        
        if !searchBar.text.isEmpty{
            destinationViewController.searchTerm = searchBar.text
        }else{
        
            let alert:UIAlertController = UIAlertController(title: "Ooops", message: "Please enter a search term!", preferredStyle: UIAlertControllerStyle.Alert)
            
            
            alert.addAction(UIAlertAction(title: "OK", style: UIAlertActionStyle.Default, handler: nil))
            
            self.presentViewController(alert, animated: true, completion: nil)
            
            
            
            
            
        }
        
    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

