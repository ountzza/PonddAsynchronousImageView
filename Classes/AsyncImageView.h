//
//  AsyncImageView.h
//  PonddAsyncImage
//
//  Created by Pondd on 2/22/11.
//  Copyright 2011 Pondd. All rights reserved.
//


#import <UIKit/UIKit.h>


@interface AsyncImageView : UIView {
    NSURLConnection *connection;
    NSMutableData *data;
    NSString *urlString; // key for image cache dictionary
	//UIImage *imagePondd;
	
	NSString *realTimeLoad;
}
@property(nonatomic,retain)NSMutableData *data;
@property(nonatomic,retain)NSString *realTimeLoad;
//@property(nonatomic,retain)UIImage *imagePondd;
-(void)loadImageFromURL:(NSURL*)url withFileName:(NSString*)imageName;
//-(BOOL)checkSavedFile:(NSString *)fileName withData:(NSData *)dataFile;
//-(void)saveFile:(NSString*)filePathNamex withData:(NSData *)dataFile;
//+(void)setStingToLoad:(NSString*)string;
@end
