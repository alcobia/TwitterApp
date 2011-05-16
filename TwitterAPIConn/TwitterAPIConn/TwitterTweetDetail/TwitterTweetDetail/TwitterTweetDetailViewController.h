//
//  TwitterTweetDetailViewController.h
//  TwitterTweetDetail
//
//  Created by Luís Alcobia on 15/05/2011.
//  Copyright 2011 ArquiConsult. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface TwitterTweetDetailViewController : UIViewController {
    IBOutlet UILabel *message;
	NSString *currentItem;
}

@property (nonatomic, retain) UILabel *message;
@property (nonatomic, retain) NSString *currentItem;

@end
