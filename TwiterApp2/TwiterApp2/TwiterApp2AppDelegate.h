//
//  TwiterApp2AppDelegate.h
//  TwiterApp2
//
//  Created by Luís Alcobia on 12/05/2011.
//  Copyright 2011 ArquiConsult. All rights reserved.
//

#import <UIKit/UIKit.h>

@class TwiterApp2ViewController;

@interface TwiterApp2AppDelegate : NSObject <UIApplicationDelegate> {

}

@property (nonatomic, retain) IBOutlet UIWindow *window;

@property (nonatomic, retain) IBOutlet TwiterApp2ViewController *viewController;

@end
