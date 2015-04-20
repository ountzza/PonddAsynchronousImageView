//
//  ImageCache.m
//  PonddAsyncImage
//
//  Created by Pondd on 2/22/11.
//  Copyright 2011 Pondd. All rights reserved.
//

#import "ImageCache.h"
#import "ImageCacheObject.h"

@interface ImageCache ()

@property (nonatomic) NSUInteger totalSize;  // total number of bytes
@property (nonatomic) NSUInteger maxSize;    // maximum capacity
@property (nonatomic, strong) NSMutableDictionary *myDictionary;

@end


@implementation ImageCache

-(id)initWithMaxSize:(NSUInteger) max  {
    if (self = [super init]) {
        _totalSize = 0;
        _maxSize = max;
        _myDictionary = [[NSMutableDictionary alloc] init];
    }
    return self;
}


-(void)insertImage:(UIImage*)image withSize:(NSUInteger)sz forKey:(NSString*)key{
	NSData *dataObj = UIImageJPEGRepresentation(image, 1.0);
	NSLog(@"insertImage");
	[self saveFile:key withData:dataObj];

}

-(UIImage*)imageForKey:(NSString*)key {
    ImageCacheObject *object = [_myDictionary objectForKey:key];
    if (object == nil)
        return nil;
    [object resetTimeStamp];
    return object.image;
}
-(void)saveFile:(NSString*)filePathName withData:(NSData *)dataFile
{
	NSFileManager *fileManger = [NSFileManager defaultManager];
	[fileManger createFileAtPath:[NSString stringWithFormat: @"%@", filePathName] contents:dataFile attributes:nil];
	NSLog(@"saveFile %@",filePathName);
}
@end
