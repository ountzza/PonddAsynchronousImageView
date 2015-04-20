//
//  ImageCacheObject.h
//  PonddAsyncImage
//
//  Created by Pondd on 2/22/11.
//  Copyright 2011 Pondd. All rights reserved.
//

#import <Foundation/Foundation.h>


@interface ImageCacheObject : NSObject


@property (nonatomic, readonly) NSUInteger size;
@property (nonatomic, strong, readonly) NSDate *timeStamp;
@property (nonatomic, strong, readonly) UIImage *image;

-(id)initWithSize:(NSUInteger)sz Image:(UIImage*)anImage;
-(void)resetTimeStamp;

@end
