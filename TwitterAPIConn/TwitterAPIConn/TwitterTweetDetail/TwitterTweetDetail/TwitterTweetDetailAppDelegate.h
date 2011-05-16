//
//  TwitterTweetDetailAppDelegate.h
//  TwitterTweetDetail
//
//  Created by Luís Alcobia on 15/05/2011.
//  Copyright 2011 ArquiConsult. All rights reserved.
//

#import <UIKit/UIKit.h>

@class TwitterTweetDetailViewController;

@interface TwitterTweetDetailAppDelegate : NSObject <UIApplicationDelegate> {

}

@property (nonatomic, retain) IBOutlet UIWindow *window;

@property (nonatomic, retain) IBOutlet TwitterTweetDetailViewController *viewController;

@end
