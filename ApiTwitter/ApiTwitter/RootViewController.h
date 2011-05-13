//
//  RootViewController.h
//  ApiTwitter
//
//  Created by Luís Alcobia on 12/05/2011.
//  Copyright 2011 ArquiConsult. All rights reserved.
//

#import <UIKit/UIKit.h>

#import <CoreData/CoreData.h>

@interface RootViewController : UITableViewController <NSFetchedResultsControllerDelegate> {

}

@property (nonatomic, retain) NSFetchedResultsController *fetchedResultsController;
@property (nonatomic, retain) NSManagedObjectContext *managedObjectContext;

@end
