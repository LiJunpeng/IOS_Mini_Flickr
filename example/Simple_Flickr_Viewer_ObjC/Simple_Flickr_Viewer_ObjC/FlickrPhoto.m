//
//  FlickrPhoto.m
//  Simple_Flickr_Viewer_ObjC
//
//  Created by LILouis on 16/3/17.
//  Copyright © 2016年 LILouis. All rights reserved.
//

#import "FlickrPhoto.h"

@implementation FlickrPhoto : NSObject 


- (instancetype)initWithID:(NSString*)ID secret:(NSString*)secret server:(NSString*)server farm:(int)farm {
    self = [super init];
    if (self) {
        self.photoID = ID;
        self.secret = secret;
        self.server = server;
        self.farm = farm;
    }
    return self;
}


@end



//
//var thumbnail:UIImage!
//var largeImage:UIImage!
//
//var photoID:String!
//var farm:Int!
//var server:String!
//var secret:String!
//
//override init() {
//    super.init()
//}
