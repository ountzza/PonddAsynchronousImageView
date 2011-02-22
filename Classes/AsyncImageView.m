//
//  AsyncImageView.m
//  PonddAsyncImage
//
//  Created by Pondd on 2/22/11.
//  Copyright 2011 Pondd. All rights reserved.
//

#import "AsyncImageView.h"
#import "ImageCacheObject.h"
#import "ImageCache.h"
#define DOCUMENTS_FOLDER [NSHomeDirectory() stringByAppendingPathComponent:@"Documents"]

//
// Key's are URL strings.
// Value's are ImageCacheObject's
//
static ImageCache *imageCache = nil;

@implementation AsyncImageView
@synthesize data,realTimeLoad;
int countTotalBook2;
- (id)initWithFrame:(CGRect)frame {
    if (self = [super initWithFrame:frame]) {
    }
    return self;
}


- (void)drawRect:(CGRect)rect {
    // Drawing code
}


- (void)dealloc {
    [connection cancel];
    [connection release];
    [data release];
    [super dealloc];
}

-(void)loadImageFromURL:(NSURL*)url withFileName:(NSString*)imageName{
	
    if (connection != nil) {
        [connection cancel];
        [connection release];
        connection = nil;
    }
    if (data != nil) {
        [data release];
        data = nil;
    }
    
    if (imageCache == nil) // lazily create image cache
        imageCache = [[ImageCache alloc] initWithMaxSize:2*1024*1024];  // 2 MB Image cache
    
    [urlString release];
   
	NSArray *paths = NSSearchPathForDirectoriesInDomains(
														 NSDocumentDirectory, NSUserDomainMask, YES);
	NSString *documentsDirectory = [paths objectAtIndex:0];
	urlString = [documentsDirectory stringByAppendingPathComponent: 
							[NSString stringWithFormat: @"%@", imageName] ];
	[urlString retain];

	////////////////////////////////////////////////
	NSFileManager *fileManger = [NSFileManager defaultManager];
	if ( [fileManger fileExistsAtPath:urlString] ) {
		NSLog(@"Image file exist %@",imageName);
		//load image
		UIImage *cachedImage = [UIImage imageWithContentsOfFile:urlString];

		if (cachedImage != nil) {
			if ([[self subviews] count] > 0) {
				[[[self subviews] objectAtIndex:0] removeFromSuperview];
			}
			UIImageView *imageView = [[[UIImageView alloc] initWithImage:cachedImage] autorelease];
			imageView.contentMode = UIViewContentModeScaleAspectFit;
			imageView.autoresizingMask = 
            UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight;
			[self addSubview:imageView];
			imageView.frame = self.bounds;
			[imageView setNeedsLayout]; // is this necessary if superview gets setNeedsLayout?
			[self setNeedsLayout];
			return;
		}
	}else {
#define SPINNY_TAG 5555   
		
		UIActivityIndicatorView *spinny = [[UIActivityIndicatorView alloc] initWithActivityIndicatorStyle:UIActivityIndicatorViewStyleGray];
		spinny.tag = SPINNY_TAG;
		spinny.center = self.center;
		[spinny startAnimating];
		[self addSubview:spinny];
		[spinny release];
		
		NSURLRequest *request = [NSURLRequest requestWithURL:url 
												 cachePolicy:NSURLRequestUseProtocolCachePolicy 
											 timeoutInterval:60.0];
		connection = [[NSURLConnection alloc] initWithRequest:request delegate:self];
		
		
	}
}

- (void)connection:(NSURLConnection *)connection 
    didReceiveData:(NSData *)incrementalData {
    if (data==nil) {
        data = [[NSMutableData alloc] initWithCapacity:2048];
    }
    [data appendData:incrementalData];
}

- (void)connectionDidFinishLoading:(NSURLConnection *)aConnection {
    [connection release];
    connection = nil;
    
    UIView *spinny = [self viewWithTag:SPINNY_TAG];
    [spinny removeFromSuperview];
    
    if ([[self subviews] count] > 0) {
        [[[self subviews] objectAtIndex:0] removeFromSuperview];
    }
    
    UIImage *image = [UIImage imageWithData:data];
    //saving image
    [imageCache insertImage:image withSize:[data length] forKey:urlString];
    
    UIImageView *imageView = [[[UIImageView alloc] 
                               initWithImage:image] autorelease];
    imageView.contentMode = UIViewContentModeScaleAspectFit;
    imageView.autoresizingMask = 
        UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight;
    [self addSubview:imageView];
    imageView.frame = self.bounds;
    [imageView setNeedsLayout]; // is this necessary if superview gets setNeedsLayout?
    [self setNeedsLayout];

	[data release];
    data = nil;
}
/*
-(BOOL)checkSavedFile:(NSString *)fileName withData:(NSData *)dataFile
{
	
	BOOL fileExist =NO;
	// Look in Documents for an existing plist file
	NSArray *paths = NSSearchPathForDirectoriesInDomains(
														 NSDocumentDirectory, NSUserDomainMask, YES);
	NSString *documentsDirectory = [paths objectAtIndex:0];
	NSString *myFilePathx = [documentsDirectory stringByAppendingPathComponent: 
							[NSString stringWithFormat: @"%@.png", fileName] ];
	[myFilePathx retain];
	
	// If it's not there, write it
	NSFileManager *fileManger = [NSFileManager defaultManager];
	if ( ![fileManger fileExistsAtPath:myFilePathx] ) {
		//NSLog(@"write file on XXX %@",myFilePath);
		//[dataFile writeToFile:myFilePath atomically:YES];
		[self saveFile:myFilePathx withData:dataFile];
	}else {
		fileExist = YES;
		//NSLog(@"file is there xxx %@",myFilePath);
	}
		
	//keep saving the same file
	return fileExist; 
}
-(void)saveFile:(NSString*)filePathNamex withData:(NSData *)dataFile
{
	NSFileManager *fileManger = [NSFileManager defaultManager];
	[fileManger createFileAtPath:filePathNamex contents:dataFile attributes:nil];

	NSLog(@"Save datafilexxx %@",filePathNamex);
}
 */
@end
