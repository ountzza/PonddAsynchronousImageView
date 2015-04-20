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
	NSURL *url = [NSURL URLWithString:@"http://upload.wikimedia.org/wikipedia/commons/thumb/8/85/Mona_Lisa.jpeg/401px-Mona_Lisa.jpeg"];
	AsyncImageView *asyncImageView = [[AsyncImageView alloc] initWithFrame:self.view.frame];
	[asyncImageView loadImageFromURL:url withFileName:@"someUniqueFileName.png" ];
	[self.view addSubview:asyncImageView];
}



/*
// Override to allow orientations other than the default portrait orientation.
- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation {
    // Return YES for supported orientations
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}
*/

- (void)didReceiveMemoryWarning {
	// Releases the view if it doesn't have a superview.
    [super didReceiveMemoryWarning];
	
	// Release any cached data, images, etc that aren't in use.
}

- (void)viewDidUnload {
	// Release any retained subviews of the main view.
	// e.g. self.myOutlet = nil;
}



@end
