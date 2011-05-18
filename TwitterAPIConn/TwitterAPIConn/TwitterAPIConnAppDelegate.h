//
//  TwitterAPIConnAppDelegate.h
//  TwitterAPIConn
//
//  Created by Luís Alcobia on 13/05/2011.
//  Copyright 2011 ArquiConsult. All rights reserved.
//

#import <UIKit/UIKit.h>

@class TwitterAPIConnViewController;

@interface TwitterAPIConnAppDelegate : NSObject <UIApplicationDelegate> {

}

@property (nonatomic, retain) IBOutlet UIWindow *window;

@property (nonatomic, retain) IBOutlet TwitterAPIConnViewController *viewController;

@end
