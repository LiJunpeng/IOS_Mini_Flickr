//
//  ViewController.m
//  Simple_Flickr_Viewer_ObjC
//
//  Created by LILouis on 16/3/17.
//  Copyright © 2016年 LILouis. All rights reserved.
//

#import "ViewController.h"
#import "FlickrHelper.h"
#import "FlickrPhoto.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    
// Example class function============================
//    FlickrHelper *helper = [[FlickrHelper alloc] init];
//    NSString *a = @"fu";
//    printf("url: %s", [[FlickrHelper URLForSearchString:@"a"] UTF8String]);
//    printf("Class: %s", [[FlickrHelper URLForFlickrPhoto:nil size:@"m"] UTF8String]);
//============================
    
//    FlickrPhoto *f = [[FlickrPhoto alloc] init];
//    f.farm = 12;
//    f.photoID = @"ffff";
//    printf("farm %s ", [[FlickrHelper URLForFlickrPhoto:f size:@"m"] UTF8String]);
//============================
    FlickrHelper *helper = [[FlickrHelper alloc] init];
    printf("url: %s", [[helper searchFlickrForString:@"a" completion:(void [[(^)(NSString* searchString, NSMutableArray *flickrPhotos, NSError* error) ]] UTF8String]);
    
//============================
    
    
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
