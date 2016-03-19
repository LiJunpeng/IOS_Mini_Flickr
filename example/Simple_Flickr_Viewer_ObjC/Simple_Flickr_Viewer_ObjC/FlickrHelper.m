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
        //let searchURL:String = FlickrHelper.URLForSearchString(searchStr)
        
        NSString *searchURL = [FlickrHelper URLForSearchString:searchStr];
        
        NSURL *url = [[NSURL alloc] initWithString:searchURL];
        NSString *searchResultString = [[NSString alloc] initWithContentsOfURL:url
                                                             encoding:NSUTF8StringEncoding
                                                                error:&error];
        //printf("asdfafd: %s", [searchResultString UTF8String]);
        // NSString *searchResultString =
        
        if (error != nil){
            //completion(searchString: searchStr, flickrPhotos: nil, error: error)
            //[completion searchString: searchStr flickrPhotos: nil error: error];
            printf("fff, no search result");
            completion(searchStr,nil,error);
        }
        else
        {
            // Parse JSON Response
            
            NSData *jsonData = [searchResultString dataUsingEncoding:NSUTF8StringEncoding allowLossyConversion:false];
            
            NSDictionary *resultDict = [NSJSONSerialization JSONObjectWithData:jsonData options:nil error:&error];
        
            //printf("%s", resultDict);
//            let resultDict:NSDictionary! = NSJSONSerialization.JSONObjectWithData(jsonData, options: nil, error: &error) as NSDictionary
            if(error != nil)
            {
                printf("fff, json conversion fail");
                completion(searchStr,nil,error);
            }
            else{
                //let status:String = resultDict.objectForKey("stat") as! String
                NSString *status = [resultDict objectForKey:@"stat"];
                
                if ([status isEqual: @"fail"]){
                    //let error:NSError? = NSError(domain: "FlickrSearch", code: 0, userInfo: [NSLocalizedFailureReasonErrorKey:resultDict.objectForKey("message")])
                    //completion(searchString: searchStr, flickrPhotos: nil, error: error)
                    printf("get json fail");
                    completion(searchStr,nil,error);
                }
                else
                {
                    NSArray *resultArray = [[resultDict objectForKey:@"photos"] objectForKey:@"photo"];
                    
                    NSMutableArray *flickrPhotos = [[NSMutableArray alloc] init];
                    
                    for (NSDictionary *photoObject in resultArray)
                    {
                        NSDictionary *photoDict = photoObject;
                        
                        FlickrPhoto *flickrPhoto = [[FlickrPhoto alloc] initWithID:photoDict[@"id"]
                                                                                secret:photoDict[@"secret"]
                                                                                server:photoDict[@"server"]
                                                                                  farm:[photoDict[@"farm"] intValue]
                                                                                 ];
                        
                        printf("id: %s, server: %s, secret: %s, farm: %d. \n",[flickrPhoto.photoID UTF8String], [flickrPhoto.server UTF8String], [flickrPhoto.secret UTF8String], flickrPhoto.farm);
                        
                        NSString *searchURL = [FlickrHelper URLForFlickrPhoto:flickrPhoto size:@"m"];
                        NSData *imageData = [NSData dataWithContentsOfURL: [NSURL URLWithString:searchURL] options:nil error:&error];
                        
                        UIImage *image = [UIImage imageWithData:imageData];
                        flickrPhoto.thumbnail = image;
                        
                        [flickrPhotos addObject:flickrPhoto];
                    }
                    //completion(searchString: searchStr, flickrPhotos: flickrPhotos, error: nil)
                    completion(searchStr,flickrPhotos,nil);
                }
            }
        }
        
    });
}




@end



