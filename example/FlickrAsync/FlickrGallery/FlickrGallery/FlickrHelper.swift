//
//  FlickrHelper.swift
//  FlickerSearch
//
//  Created by Training on 11.08.14.
//  Copyright (c) 2014 com.training All rights reserved.
//

import UIKit

class FlickrHelper: NSObject {


    
    class func URLForSearchString (searchString:String!) -> String{
        let apiKey:String = "b1217b6f18279e3d759f04a377fa07b8"
        let search:String = searchString.stringByAddingPercentEscapesUsingEncoding(NSUTF8StringEncoding)!
        
        
        return "https://api.flickr.com/services/rest/?method=flickr.photos.search&api_key=\(apiKey)&text=\(search)&per_page=100&format=json&nojsoncallback=1"
    }
    
    class func URLForFlickrPhoto(photo:FlickrPhoto, size:String) -> String{
        
        var _size:String = size
        
        if _size.isEmpty{
            _size = "m"
        }
        
        return "http://farm\(photo.farm).staticflickr.com/\(photo.server)/\(photo.photoID)_\(photo.secret)_\(_size).jpg"

    }
    
    func searchFlickrForString(searchStr:String, completion:(searchString:String!, flickrPhotos:NSMutableArray!, error:NSError!)->()){
    
        let searchURL:String = FlickrHelper.URLForSearchString(searchStr)
        let queue:dispatch_queue_t  = dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0)
        
        dispatch_async(queue, {
            var error:NSError?
            
            let searchResultString:String! = String.stringWithContentsOfURL(NSURL.URLWithString(searchURL), encoding: NSUTF8StringEncoding, error: &error)
            
            if error != nil{
                completion(searchString: searchStr, flickrPhotos: nil, error: error)
            }else{
            
            
                // Parse JSON Response
                
                let jsonData:NSData! = searchResultString.dataUsingEncoding(NSUTF8StringEncoding, allowLossyConversion: false)
                
                let resultDict:NSDictionary! = NSJSONSerialization.JSONObjectWithData(jsonData, options: nil, error: &error) as NSDictionary
                
                if error != nil{
                    completion(searchString: searchStr, flickrPhotos: nil, error: error)
                }else{
                
                    let status:String! = resultDict.objectForKey("stat") as! String
                    
                    if status == "fail"{
                        
                        let messageString:String = resultDict.objectForKey("message") as! String
                        let error:NSError? = NSError(domain: "FlickrSearch", code: 0, userInfo: [NSLocalizedFailureReasonErrorKey:messageString])
                        
                        
                        completion(searchString: searchStr, flickrPhotos: nil, error:error )
                    }else{
                        // Show structure of result
                        let photosDict:NSDictionary = resultDict.objectForKey("photos") as! NSDictionary
                        let resultArray:NSArray = photosDict.objectForKey("photo") as! NSArray
                        
                        let flickrPhotos:NSMutableArray = NSMutableArray()
                        
                        for photoObject in resultArray{
                            let photoDict:NSDictionary = photoObject as! NSDictionary
                            print(photoDict)
                            var flickrPhoto:FlickrPhoto = FlickrPhoto()
                            flickrPhoto.farm = photoDict.objectForKey("farm") as! Int
                            print("FARM \(flickrPhoto.farm)")
                            
                            flickrPhoto.server = photoDict.objectForKey("server") as! String
                            
                            flickrPhoto.secret = photoDict.objectForKey("secret") as! String
                            flickrPhoto.photoID = photoDict.objectForKey("id") as! String

                            let searchURL:NSString = FlickrHelper.URLForFlickrPhoto(flickrPhoto, size: "m")
                            
                            flickrPhotos.addObject(searchURL)
                            
                            /*
                            let imageData:NSData = NSData(contentsOfURL: NSURL(string: searchURL), options: nil, error: &error)
                            
                            let image:UIImage = UIImage(data: imageData)
                            flickrPhoto.thumbnail = image
                            
                            flickrPhotos.addObject(flickrPhoto)
                            */
                            
                        }
                        
                        completion(searchString: searchURL, flickrPhotos: flickrPhotos, error: nil)
                        
                    }
                    
                }
                
                
                
                
                
            }
            
            
            
            
            
        })
    }
    
    
}
