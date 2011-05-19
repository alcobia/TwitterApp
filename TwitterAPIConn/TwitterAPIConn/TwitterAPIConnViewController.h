//
//  TwitterAPIConnViewController.h
//  TwitterAPIConn
//
//  Created by Luís Alcobia on 13/05/2011.
//  Copyright 2011 ArquiConsult. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface TwitterAPIConnViewController : UIViewController <UITableViewDataSource, UITableViewDelegate, UITabBarDelegate> {
    IBOutlet UINavigationItem *navControllerSelfView;
    
    IBOutlet UITableView *tblView;
    
    IBOutlet UITextField *txtfieldUser;
    
    IBOutlet UITextView *txtviewTextTweet;
    IBOutlet UITextView *txtviewDescriptionUser;
    IBOutlet UITextView *txtviewNameUser;
    IBOutlet UITextView *txtviewCreatedAt;
    
    IBOutlet UIView *view1;
    IBOutlet UIView *view2;
    
    IBOutlet UIImageView *imageUser;
    
    UITabBar *tabBar;
    
    NSArray *tweetsReceived;
    
    NSArray *textTweet;
    NSArray *createdTweet;
    NSArray *nameUser;
    NSArray *imgUser;
    
    NSString *user;
}

@property (nonatomic,retain) IBOutlet UITableView *tblView;

@property (nonatomic,retain) NSArray *tweetsReceived;

@property (nonatomic,retain) NSArray *textTweet;
@property (nonatomic,retain) NSArray *createdTweet;
@property (nonatomic,retain) NSArray *nameUser;
@property (nonatomic,retain) NSArray *imgUser;

@property (nonatomic,retain) NSString *user;

-(IBAction)transitionFlip2;
-(IBAction)meusTweets;

-(void)connectURL:(NSString *)url;

@end
