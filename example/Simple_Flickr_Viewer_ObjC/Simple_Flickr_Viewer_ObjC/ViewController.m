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
//    FlickrHelper *helper = [[FlickrHelper alloc] init];
//    [helper searchFlickrForString:@"cat" completion:^(NSString* searchString, NSMutableArray *flickrPhotos, NSError* error){
//        
//        if (!error)
//        {
//            int len = (int)[flickrPhotos count];
//            NSUInteger index = arc4random_uniform(len);
//            FlickrPhoto *photo = [flickrPhotos objectAtIndex:index];//flickrPhotos[arc4random_uniform [flickrPhotos count]];
//            UIImage *image = photo.thumbnail;
//            
//            
//            dispatch_async(dispatch_get_main_queue(), ^{
//                _flickr_image_view.image = image;
//            });
//            
//        }
//    
//    }];
    
//============================
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}



- (IBAction)search_keyword:(UIButton *)sender {
    
    [_search_bar resignFirstResponder];
    
    FlickrHelper *helper = [[FlickrHelper alloc] init];
    
    
    if ([_search_bar.text length] == 0) {
//        let alert:UIAlertController = UIAlertController(title: "Ooops", message: "Please enter a search term", preferredStyle: UIAlertControllerStyle.Alert)
//        alert.addAction(UIAlertAction(title: "OK", style: UIAlertActionStyle.Default, handler: nil))
        
        UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"Ooops"
                                                     message:@"Please enter a search term"
                                              preferredStyle: UIAlertControllerStyleAlert];
//        [alert addAction:[UIAlertAction actionWithTitle:@"OK" style: UIAlertActionStyleDefault handler: nil]];
        
        
        UIAlertAction* ok = [UIAlertAction
                             actionWithTitle:@"OK"
                             style:UIAlertActionStyleDefault
                             handler:^(UIAlertAction * action)
                             {
                                 [alert dismissViewControllerAnimated:YES completion:nil];
                                 
                             }];
        
        [alert addAction:ok];
        [self presentViewController:alert animated:YES completion:nil];
    }
    else
    {
        [helper searchFlickrForString:_search_bar.text completion:^(NSString* searchString, NSMutableArray *flickrPhotos, NSError* error){
        
            if (!error)
            {
                int len = (int)[flickrPhotos count];
                NSUInteger index = arc4random_uniform(len);
                FlickrPhoto *photo = [flickrPhotos objectAtIndex:index];//flickrPhotos[arc4random_uniform [flickrPhotos count]];
                UIImage *image = photo.thumbnail;
                
                
                dispatch_async(dispatch_get_main_queue(), ^{
                    _flickr_image_view.image = image;
                });
                
            }
            
        }];
    }
    
    
}


@end
