//
//  FlickrHelper.m
//  Simple_Flickr_Viewer_ObjC
//
//  Created by LILouis on 16/3/17.
//  Copyright © 2016年 LILouis. All rights reserved.
//

@import Foundation;
#import "FlickrHelper.h"

@implementation FlickrHelper

+ (NSString*)URLForSearchString:(NSString*) searchString
{
//    NSString *variable = @"2";
//    return [NSString stringWithFormat:@"Hello %@", variable];
    
    
    NSString *apiKey = @"b1217b6f18279e3d759f04a377fa07b8";
    //NSString *search = [];
    //let search:String = searchString.stringByAddingPercentEscapesUsingEncoding(NSUTF8StringEncoding)!
    
    //NSCharacterSet *set = [NSCharacterSet NSUTF8StringEncoding];
    
    //======????????=======================================
    NSString *charactersToEscape = @"!*'();:@&=+$,/?%#[]\" ";
    NSCharacterSet *allowedCharacters = [[NSCharacterSet characterSetWithCharactersInString:charactersToEscape] invertedSet];
    NSString *search = [searchString stringByAddingPercentEncodingWithAllowedCharacters:allowedCharacters];
    //=====================================================
    
    return [NSString stringWithFormat:@"https://api.flickr.com/services/rest/?method=flickr.photos.search&api_key=%@&text=%@&per_page=100&format=json&nojsoncallback=1", apiKey, search];
    
}


+ (NSString*)URLForFlickrPhoto:(FlickrPhoto*) photo size: (NSString*) size
{
//    NSString *variable = @"233";
//    return [NSString stringWithFormat:@"Hello %@", variable];
    
    
//    var _size:String = size
//    
//    if _size.isEmpty{
//        _size = "m"
//    }
//    
//    return "http://farm\(photo.farm).staticflickr.com/\(photo.server)/\(photo.photoID)_\(photo.secret)_\(_size).jpg"
    
    
    NSString *_size = size;
    if([_size length] == 0)
    {
        _size = @"m";
    }
    
//    return "http://farm\(photo.farm).staticflickr.com/\(photo.server)/\(photo.photoID)_\(photo.secret)_\(_size).jpg"
    
//        return [NSString stringWithFormat:@"https://api.flickr.com/services/rest/?method=flickr.photos.search&api_key=%@&text=%@&per_page=100&format=json&nojsoncallback=1", apiKey, search];
    
    return [NSString stringWithFormat:@"http://farm%d.staticflickr.com/%@/%@_%@_%@.jpg", photo.farm, photo.server, photo.photoID, photo.secret, _size];
}

- (void) searchFlickrForString:(NSString*) searchStr completion:(void (^)(NSString* searchString, NSMutableArray *flickrPhotos, NSError* error))completion
{
    dispatch_queue_t queue = dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_HIGH, 0);
    dispatch_async(queue, ^{
        
        NSError *error;
        
        //NSString(contentsOfURL: Location, encoding: NSUTF8StringEncoding, error: &error)
        
        //let searchResultString:String! = String.stringWithContentsOfURL(NSURL.URLWithString(searchURL), encoding: NSUTF8StringEncoding, error: &error)
        
        NSURL *url = [[NSURL alloc] initWithString:searchStr];
        NSString *my_string = [[NSString alloc] initWithContentsOfURL:url
                                                             encoding:NSUTF8StringEncoding
                                                                error:&error];
        printf("asdfafd: %s", [my_string UTF8String]);
       // NSString *searchResultString =
        
    });
}




@end



