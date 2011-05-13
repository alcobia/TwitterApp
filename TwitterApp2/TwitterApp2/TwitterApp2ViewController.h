//
//  TwitterApp2ViewController.h
//  TwitterApp2
//
//  Created by Luís Alcobia on 12/05/2011.
//  Copyright 2011 ArquiConsult. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "JSON/JSON.h"

@interface TwitterApp2ViewController : UIViewController <UITableViewDataSource, UITableViewDelegate>
{
    IBOutlet UITableView *tblView;
    NSArray *tweets;
    SBJsonStreamParser *parser;
    SBJsonStreamParserAdapter *adapter;
    
    
}

-(IBAction) startStreaming;

@property(nonatomic,retain) IBOutlet UITableView *tblView;
@property(nonatomic,retain) NSMutableData *rspData;
@property(nonatomic,retain) NSArray *tweets;



@end
