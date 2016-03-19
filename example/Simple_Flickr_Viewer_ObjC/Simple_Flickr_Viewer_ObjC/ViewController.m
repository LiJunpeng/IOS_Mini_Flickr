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

@property (weak, nonatomic) IBOutlet UITextField *search_bar;

@property (weak, nonatomic) IBOutlet UIButton *search_button;

@property (weak, nonatomic) IBOutlet UIImageView *flickr_image_view;



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
    [helper searchFlickrForString:@"cat" completion:^(NSString* searchString, NSMutableArray *flickrPhotos, NSError* error){
        
        if (!error)
        {
            FlickrPhoto *photo = flickrPhotos[0];
            UIImage *image = photo.thumbnail;
            
            dispatch_async(dispatch_get_main_queue(), ^{
                _flickr_image_view.image = image;
            });
            
            
//            let flickrPhoto:FlickrPhoto = flickrPhotos.objectAtIndex(Int(arc4random_uniform(UInt32(flickrPhotos.count)))) as FlickrPhoto
//            
//            let image:UIImage = flickrPhoto.thumbnail
//            
//            dispatch_async(dispatch_get_main_queue(), {
//                self.flickrImageView.image = image
//                self.activity.stopAnimating()
//                self.flickrIconImageView.backgroundColor = UIColor.clearColor()
            
//            })
            
        }
    
    }];
    
//============================
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
