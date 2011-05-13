//
//  TwitterApp2AppDelegate.h
//  TwitterApp2
//
//  Created by Luís Alcobia on 12/05/2011.
//  Copyright 2011 ArquiConsult. All rights reserved.
//

#import <UIKit/UIKit.h>

@class TwitterApp2ViewController;

@interface TwitterApp2AppDelegate : NSObject <UIApplicationDelegate> {

}

@property (nonatomic, retain) IBOutlet UIWindow *window;

@property (nonatomic, retain) IBOutlet TwitterApp2ViewController *viewController;

@end
