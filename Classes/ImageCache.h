//
//  ImageCache.h
//  PonddAsyncImage
//
//  Created by Pondd on 2/22/11.
//  Copyright 2011 Pondd. All rights reserved.
//

#import <Foundation/Foundation.h>

@class ImageCacheObject;

@interface ImageCache : NSObject {
    NSUInteger totalSize;  // total number of bytes
    NSUInteger maxSize;    // maximum capacity
    NSMutableDictionary *myDictionary;
}

@property (nonatomic, readonly) NSUInteger totalSize;

-(id)initWithMaxSize:(NSUInteger) max;
-(void)insertImage:(UIImage*)image withSize:(NSUInteger)sz forKey:(NSString*)key;
-(UIImage*)imageForKey:(NSString*)key;
-(void)saveFile:(NSString*)filePathName withData:(NSData *)dataFile;
@end
