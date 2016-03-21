//
//  FlickrPhoto.h
//  Simple_Flickr_Viewer_ObjC
//
//  Created by LILouis on 16/3/17.
//  Copyright © 2016年 LILouis. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <Foundation/Foundation.h>


@interface FlickrPhoto : NSObject

@property (nonatomic, strong) NSString *photoID;
@property (nonatomic, strong) NSString *secret;
@property (nonatomic, strong) NSString *server;
@property (nonatomic) int farm;

@property (nonatomic, strong) UIImage *thumbnail;
@property (nonatomic, strong) UIImage *largeImage;

- (instancetype)initWithID:(NSString*)ID secret:(NSString*)secret server:(NSString*)server farm:(int)farm;

@end


