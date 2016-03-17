//
//  FlickrPhoto.swift
//  FlickerSearch
//
//  Created by Training on 11.08.14.
//  Copyright (c) 2014 com.training All rights reserved.
//

import UIKit

class FlickrPhoto: NSObject {
   
    var thumbnail:UIImage!
    var largeImage:UIImage!
    
    var photoID:String!
    var farm:Int!
    var server:String!
    var secret:String!
    
    override init() {
        super.init()
    }
    
}
