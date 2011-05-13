//
//  TwitterApp2ViewController.m
//  TwitterApp2
//
//  Created by Luís Alcobia on 12/05/2011.
//  Copyright 2011 ArquiConsult. All rights reserved.
//

#import "TwitterApp2ViewController.h"
#import "JSON/JSON.h"

@implementation TwitterApp2ViewController

@synthesize rspData;
@synthesize tblView;
@synthesize tweets;


- (void)parser:(SBJsonStreamParser *)parser foundArray:(NSArray *)array {
	NSLog(@"ArrayTweet: '%@'", array);	
}

- (void)parser:(SBJsonStreamParser *)parser foundObject:(NSDictionary *)dict {
	NSString *text = [dict objectForKey:@"text"];
	tweet.text = text;
	NSLog(@"Tweet: '%@'", text);
}

- (IBAction)startStreaming {
	[userName resignFirstResponder];
	[password resignFirstResponder];
    
	// We don't want *all* the individual messages from the
	// SBJsonStreamParser, just the top-level objects. The stream
	// parser adapter exists for this purpose.
	adapter = [SBJsonStreamParserAdapter new];
    
	// Set ourselves as the delegate, so we receive the messages
	// from the adapter.
	adapter.delegate = self;
    
	// Create a new stream parser..
	parser = [SBJsonStreamParser new];
    
	// .. and set our adapter as its delegate.
	parser.delegate = adapter;
    
	// Normally it's an error if JSON is followed by anything but
	// whitespace. Setting this means that the parser will be
	// expecting the stream to contain multiple whitespace-separated
	// JSON documents.
	parser.multi = YES;
    
	NSString *url = @"http://api.twitter.com/1/statuses/public_timeline.json";
    
	NSURLRequest *theRequest=[NSURLRequest requestWithURL:[NSURL URLWithString:url]
											  cachePolicy:NSURLRequestUseProtocolCachePolicy
										  timeoutInterval:60.0];
    
	[[[NSURLConnection alloc] initWithRequest:theRequest delegate:self] autorelease];
}	

- (void)connection:(NSURLConnection *)connection didReceiveResponse:(NSURLResponse *)response {
	NSLog(@"Connection didReceiveResponse: %@ - %@", response, [response MIMEType]);
}

- (void)connection:(NSURLConnection *)connection didReceiveAuthenticationChallenge:(NSURLAuthenticationChallenge *)challenge {
	NSLog(@"Connection didReceiveAuthenticationChallenge: %@", challenge);
    
	NSURLCredential *credential = [NSURLCredential credentialWithUser:userName.text
															 password:password.text
														  persistence:NSURLCredentialPersistenceForSession];
    
	[[challenge sender] useCredential:credential forAuthenticationChallenge:challenge];
}

- (void)connection:(NSURLConnection *)connection didReceiveData:(NSData *)data {
	NSLog(@"Connection didReceiveData of length: %u", data.length);
    
	// Parse the new chunk of data. The parser will append it to
	// its internal buffer, then parse from where it left off in
	// the last chunk.
	SBJsonStreamParserStatus status = [parser parse:data];
    
	if (status == SBJsonStreamParserError) {
		NSLog(@"Parser error: %@", parser.error);
        
	} else if (status == SBJsonStreamParserWaitingForData) {
		NSLog(@"Parser waiting for more data");
	}
}

- (void)connection:(NSURLConnection *)connection didFailWithError:(NSError *)error {
    NSLog(@"Connection failed! Error - %@ %@",
          [error localizedDescription],
          [[error userInfo] objectForKey:NSURLErrorFailingURLStringErrorKey]);
}

- (void)connectionDidFinishLoading:(NSURLConnection *)connection {
    [connection release];
	[parser release];
	[adapter release];
	parser = nil;
	adapter = nil;
}

- (void)dealloc
{
    [super dealloc];
}

- (void)didReceiveMemoryWarning
{
    // Releases the view if it doesn't have a superview.
    [super didReceiveMemoryWarning];
    
    // Release any cached data, images, etc that aren't in use.
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
	return tweets.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView 
		 cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell *cell = [tblView dequeueReusableCellWithIdentifier:@"cell"];
    
	// create a cell
    if(cell == nil)
    {
        cell = [[UITableViewCell alloc]
                             initWithStyle:UITableViewCellStyleDefault 
							 reuseIdentifier:@"cell"];
	}
    
    /* retrieve an image
	NSString *imagefile = [[NSBundle mainBundle] pathForResource:@"cellimage" ofType:@"png"];
	UIImage *ui = [[UIImage alloc] initWithContentsOfFile:imagefile];
     
	//set the image on the table cell
	cell.imageView.image = ui;

	// fill it with contents*/
	cell.textLabel.text = [tweets objectAtIndex:indexPath.row];
	
	// return it
	return cell;
}


#pragma mark - View lifecycle


// Implement viewDidLoad to do additional setup after loading the view, typically from a nib.
- (void)viewDidLoad
{
    
    
    [super viewDidLoad];
}


- (void)viewDidUnload
{
    [super viewDidUnload];
    // Release any retained subviews of the main view.
    // e.g. self.myOutlet = nil;
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    // Return YES for supported orientations
    return YES;
}

@end
