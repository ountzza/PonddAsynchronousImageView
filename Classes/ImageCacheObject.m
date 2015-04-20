//
//  ImageCacheObject.m
//  PonddAsyncImage
//
//  Created by Pondd on 2/22/11.
//  Copyright 2011 Pondd. All rights reserved.
//

#import "ImageCacheObject.h"

@interface ImageCacheObject ()

@property (nonatomic) NSUInteger size;    // size in bytes of image data
@property (nonatomic, strong) NSDate *timeStamp;  // time of last access
@property (nonatomic, strong) UIImage *image;     // cached image


@end


@implementation ImageCacheObject


-(id)initWithSize:(NSUInteger)size Image:(UIImage*)anImage{
    if (self = [super init]) {
        _size = size;
        _timeStamp = [NSDate date];
        _image = anImage;
    }
    return self;
}

-(void)resetTimeStamp {
    _timeStamp = [NSDate date];
}


@end
