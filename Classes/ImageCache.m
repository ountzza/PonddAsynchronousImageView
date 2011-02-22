//
//  ImageCache.m
//  PonddAsyncImage
//
//  Created by Pondd on 2/22/11.
//  Copyright 2011 Pondd. All rights reserved.
//

#import "ImageCache.h"
#import "ImageCacheObject.h"

@implementation ImageCache

@synthesize totalSize;

-(id)initWithMaxSize:(NSUInteger) max  {
    if (self = [super init]) {
        totalSize = 0;
        maxSize = max;
        myDictionary = [[NSMutableDictionary alloc] init];
    }
    return self;
}

-(void)dealloc {
    [myDictionary release];
    [super dealloc];
}

-(void)insertImage:(UIImage*)image withSize:(NSUInteger)sz forKey:(NSString*)key{
	NSData *dataObj = UIImageJPEGRepresentation(image, 1.0);
	NSLog(@"insertImage");
	[self saveFile:key withData:dataObj];

}

-(UIImage*)imageForKey:(NSString*)key {
    ImageCacheObject *object = [myDictionary objectForKey:key];
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
