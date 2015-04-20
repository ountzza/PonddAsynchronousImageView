//
//  PonddAsyncImageViewController.m
//  PonddAsyncImage
//
//  Created by Pondd on 2/22/11.
//  Copyright 2011 Pondd. All rights reserved.
//

#import "PonddAsyncImageViewController.h"

@implementation PonddAsyncImageViewController

// Implement viewDidLoad to do additional setup after loading the view, typically from a nib.
- (void)viewDidLoad {
    [super viewDidLoad];
    NSString *urlString = [NSString stringWithFormat:@"http://dummyimage.com/%dx%d/09e04d/000657.png", (int)self.view.frame.size.width, (int)self.view.frame.size.height];
	NSURL *url = [NSURL URLWithString: urlString];
	AsyncImageView *asyncImageView = [[AsyncImageView alloc] initWithFrame:self.view.frame];
	[asyncImageView loadImageFromURL:url withFileName: urlString];
	[self.view addSubview:asyncImageView];
}

@end
