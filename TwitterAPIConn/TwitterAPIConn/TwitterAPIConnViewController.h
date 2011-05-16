//
//  TwitterAPIConnViewController.h
//  TwitterAPIConn
//
//  Created by Luís Alcobia on 13/05/2011.
//  Copyright 2011 ArquiConsult. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface TwitterAPIConnViewController : UIViewController <UITableViewDataSource, UITableViewDelegate> {
    IBOutlet UITableView *tblView;
    NSArray *dicTweets;
}

@property(nonatomic,retain) IBOutlet UITableView *tblView;
@property (nonatomic,retain) NSArray *dicTweets;

@end
