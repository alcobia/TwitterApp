//
//  TwitterAPIConnViewController.h
//  TwitterAPIConn
//
//  Created by Luís Alcobia on 13/05/2011.
//  Copyright 2011 ArquiConsult. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface TwitterAPIConnViewController : UIViewController <UITableViewDataSource, UITableViewDelegate, UITabBarDelegate> {
    
    UITabBar *tabBar;
    
    IBOutlet UITableView *tblView;
    
    IBOutlet UITextField *txtUser;
    
    IBOutlet UITextView *txtTextTweet;
    IBOutlet UITextView *txtDescriptionUser;
    
    IBOutlet UIView *view1;
    IBOutlet UIView *view2;

    IBOutlet UILabel *lblNameUser;
    IBOutlet UILabel *lblCreatedAt;
    
    IBOutlet UIImageView *imageUser;
    
    NSArray *tweetsReceived;
    NSArray *textTweet;
    NSArray *createdTweet;
    NSArray *nameUser;
    NSArray *imgUser;
    NSArray *descriptionUser;
    
    NSString *user;
}

@property (nonatomic,retain) IBOutlet UITableView *tblView;

@property (nonatomic,retain) NSArray *tweetsReceived;
@property (nonatomic,retain) NSArray *textTweet;
@property (nonatomic,retain) NSArray *createdTweet;
@property (nonatomic,retain) NSArray *nameUser;
@property (nonatomic,retain) NSArray *imgUser;
@property (nonatomic,retain) NSArray *descriptionUser;

@property (nonatomic,retain) NSString *user;


-(IBAction)transitionFlip2;
-(IBAction)log;

-(void)connectURL:(NSString *)url;

@end
