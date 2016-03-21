//
//  FlickrHelper.h
//  Simple_Flickr_Viewer_ObjC
//
//  Created by LILouis on 16/3/17.
//  Copyright © 2016年 LILouis. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <Foundation/Foundation.h>
#import "FlickrPhoto.h"

@class FlickrPhoto;

@interface FlickrHelper : NSObject

+ (NSString*)URLForSearchString:(NSString*) searchString;

+ (NSString*)URLForFlickrPhoto:(FlickrPhoto*) photo size: (NSString*) size;

- (void) searchFlickrForString:(NSString*) searchStr completion:(void (^)(NSString* searchString, NSMutableArray *flickrPhotos, NSError* error))completion;

@end

//
//    func searchFlickrForString(searchStr:String, completion:(searchString:String!, flickrPhotos:NSMutableArray!, error:NSError!)->()){
//
//
//- (void)fetchImageWithSize:(PhotoSize)size completion:(void (^)(FlickrPhotoInfo* photoInfo))completion
//
//
//
//- (void)getFlickrNextPage:(NSUInteger)perPageCount completion:(void(^)(NSArray *photos))completion; // 下一页

