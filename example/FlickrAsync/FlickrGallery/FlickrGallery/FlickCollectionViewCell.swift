//
//  FlickCollectionViewCell.swift
//  FlickrGallery
//
//  Created by Training on 19/08/14.
//  Copyright (c) 2014 Training. All rights reserved.
//

import UIKit

class FlickCollectionViewCell: UICollectionViewCell {
    
    var imageView:UIImageView!
    var image:UIImage!{
        get{
            return self.image
        }
        
        set{
            self.imageView.image = newValue
            
            if imageOffset != nil{
                setImageOffset(imageOffset)
            }else{
                setImageOffset(CGPointMake(0, 0))
            }
        
        }
    
    }
    
    var imageOffset:CGPoint!
    
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupImageView()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        setupImageView()
    }
    
    func setupImageView(){
        self.clipsToBounds = true
        
        imageView = UIImageView(frame: CGRectMake(self.bounds.origin.x, self.bounds.origin.y, 320, 200))
        imageView.contentMode = UIViewContentMode.ScaleAspectFill
        imageView.clipsToBounds = false
        self.addSubview(imageView)
        
    }
    
    func setImageOffset(imageOffset:CGPoint){
    
        self.imageOffset = imageOffset
        
        let frame:CGRect = imageView.bounds
        let offsetFrame:CGRect = CGRectOffset(frame, self.imageOffset.x, self.imageOffset.y)
        imageView.frame = offsetFrame
        
        
    }
    
    
}
