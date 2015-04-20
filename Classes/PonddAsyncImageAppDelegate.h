//
//  PonddAsyncImageAppDelegate.h
//  PonddAsyncImage
//
//  Created by Pondd on 2/22/11.
//  Copyright 2011 Pondd. All rights reserved.
//

#import <UIKit/UIKit.h>

@class PonddAsyncImageViewController;

@interface PonddAsyncImageAppDelegate : NSObject <UIApplicationDelegate> {
    UIWindow *window;
    PonddAsyncImageViewController *viewController;
}

@property (nonatomic, strong) IBOutlet UIWindow *window;
@property (nonatomic, strong) IBOutlet PonddAsyncImageViewController *viewController;

@end

