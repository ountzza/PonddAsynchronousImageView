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

@interface AsyncImageView ()

@property (nonatomic, strong) NSURLConnection *connection;
@property (nonatomic, strong) NSMutableData *data;
@property (nonatomic, strong) NSString *urlString; // key for image cache dictionary
@property (nonatomic, strong) UIActivityIndicatorView *activityIndicator;

@end


@implementation AsyncImageView

int countTotalBook2;


- (void)dealloc {
    [_connection cancel];
}

-(void)loadImageFromURL:(NSURL*)url withFileName:(NSString*)imageName{
	
    if (_connection != nil) {
        [_connection cancel];
        _connection = nil;
    }
    if (_data != nil) {
        _data = nil;
    }
    
    if (imageCache == nil) // lazily create image cache
        imageCache = [[ImageCache alloc] initWithMaxSize:2*1024*1024];  // 2 MB Image cache
    
   
	NSArray *paths = NSSearchPathForDirectoriesInDomains(
														 NSDocumentDirectory, NSUserDomainMask, YES);
	NSString *documentsDirectory = [paths objectAtIndex:0];
	_urlString = [documentsDirectory stringByAppendingPathComponent:
							[NSString stringWithFormat: @"%@", imageName] ];

	////////////////////////////////////////////////
	NSFileManager *fileManger = [NSFileManager defaultManager];
	if ( [fileManger fileExistsAtPath: _urlString] ) {
		NSLog(@"Image file exist %@",imageName);
		//load image
		UIImage *cachedImage = [UIImage imageWithContentsOfFile: _urlString];

		if (cachedImage != nil) {
			if ([[self subviews] count] > 0) {
				[[[self subviews] objectAtIndex:0] removeFromSuperview];
			}
			UIImageView *imageView = [[UIImageView alloc] initWithImage:cachedImage];
			imageView.contentMode = UIViewContentModeScaleAspectFit;
			imageView.autoresizingMask = 
            UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight;
			[self addSubview:imageView];
			imageView.frame = self.bounds;
			[imageView setNeedsLayout]; // is this necessary if superview gets setNeedsLayout?
			[self setNeedsLayout];
			return;
		}
	}
    else
    {
        if (!self.activityIndicator) {
            UIActivityIndicatorView *spinny = [[UIActivityIndicatorView alloc] initWithActivityIndicatorStyle:UIActivityIndicatorViewStyleGray];
            spinny.center = self.center;
            [spinny startAnimating];
            [self addSubview:spinny];
        }
        
		
		NSURLRequest *request = [NSURLRequest requestWithURL:url 
												 cachePolicy:NSURLRequestUseProtocolCachePolicy 
											 timeoutInterval:60.0];
		_connection = [[NSURLConnection alloc] initWithRequest:request delegate:self];
		
		
	}
}

- (void)connection:(NSURLConnection *)connection didReceiveData:(NSData *)incrementalData {
    if (_data==nil) {
        _data = [[NSMutableData alloc] initWithCapacity:2048];
    }
    [_data appendData:incrementalData];
}

- (void)connectionDidFinishLoading:(NSURLConnection *)aConnection {
    _connection = nil;
    
    [self.activityIndicator removeFromSuperview];
    
    if ([[self subviews] count] > 0) {
        [[[self subviews] objectAtIndex:0] removeFromSuperview];
    }
    
    UIImage *image = [UIImage imageWithData: _data];
    //saving image
    [imageCache insertImage:image withSize:[_data length] forKey: _urlString];
    
    UIImageView *imageView = [[UIImageView alloc] 
                               initWithImage:image];
    imageView.contentMode = UIViewContentModeScaleAspectFit;
    imageView.autoresizingMask = 
        UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight;
    [self addSubview:imageView];
    imageView.frame = self.bounds;
    [imageView setNeedsLayout]; // is this necessary if superview gets setNeedsLayout?
    [self setNeedsLayout];

    _data = nil;
}

@end
