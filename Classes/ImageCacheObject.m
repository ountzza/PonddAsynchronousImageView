//
//  ImageCacheObject.m
//  PonddAsyncImage
//
//  Created by Pondd on 2/22/11.
//  Copyright 2011 Pondd. All rights reserved.
//

#import "ImageCacheObject.h"

@implementation ImageCacheObject

@synthesize size;
@synthesize timeStamp;
@synthesize image;

-(id)initWithSize:(NSUInteger)sz Image:(UIImage*)anImage{
    if (self = [super init]) {
        size = sz;
        timeStamp = [[NSDate date] retain];
        image = [anImage retain];
    }
    return self;
}

-(void)resetTimeStamp {
    [timeStamp release];
    timeStamp = [[NSDate date] retain];
}

-(void) dealloc {
    [timeStamp release];
    [image release];
    [super dealloc];
}

@end
