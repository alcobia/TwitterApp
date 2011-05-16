//
//  AnotherViewController.h
//  Navigation
//
//  Created by Simon Allardice on 8/29/09.
//  Copyright 2009 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>


@interface AnotherViewController : UIViewController {
	IBOutlet UILabel *message;
	NSString *currentItem;
}
@property (nonatomic, retain) UILabel *message;
@property (nonatomic, retain) NSString *currentItem;

@end
