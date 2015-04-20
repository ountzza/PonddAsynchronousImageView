//
//  AsyncImageView.h
//  PonddAsyncImage
//
//  Created by Pondd on 2/22/11.
//  Copyright 2011 Pondd. All rights reserved.
//


#import <UIKit/UIKit.h>


@interface AsyncImageView : UIView 

@property (nonatomic, strong) NSString *realTimeLoad;

-(void)loadImageFromURL:(NSURL*)url withFileName:(NSString*)imageName;

@end
