//
//  TwitterAPIConnViewController.m
//  TwitterAPIConn
//
//  Created by Luís Alcobia on 13/05/2011.
//  Copyright 2011 ArquiConsult. All rights reserved.
//

#import "TwitterAPIConnViewController.h"
#import "JSON.h"

@implementation TwitterAPIConnViewController

@synthesize dicTweets;
@synthesize tblView;

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
	return [dicTweets count];
}

// Override to support row selection in the table view.
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    
    //método para abrir janela com os detalhes do tweet
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    int index = indexPath.row;
    
    // Configurar célula
    UITableViewCell *cell = (UITableViewCell *)[tblView dequeueReusableCellWithIdentifier:@"cell"];
    
    //criar célula
    if (cell == nil){
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:@"cell"];
    }    
    
    //afectar célula com os dados recebidos
    cell.textLabel.text = [[dicTweets objectAtIndex:index] objectForKey: @"text"];
    
    //definir detalhes
    cell.detailTextLabel.text = [[dicTweets objectAtIndex:index] objectForKey: @"location"]; 
     
    //definir imagem
    NSURL *url = [NSURL URLWithString:[[dicTweets objectAtIndex:index] objectForKey:@"profile_image_url"]];  
    NSData *data = [NSData dataWithContentsOfURL:url];  
    cell.imageView.image = [UIImage imageWithData:data];  
    cell.selectionStyle = UITableViewCellSelectionStyleGray; 

    return cell;
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

#pragma mark - View lifecycle


// Implement viewDidLoad to do additional setup after loading the view, typically from a nib.
- (void)viewDidLoad
{
    [super viewDidLoad];
    
    SBJsonParser *parser = [[SBJsonParser alloc] init];
    
    //definir o url com o pedido para a timeline do twitter
    NSURLRequest *request = [NSURLRequest requestWithURL:[NSURL URLWithString:@"http://twitter.com/statuses/public_timeline.json"]];
    
    //fazer o request e receber os dados num objecto Data
    NSData *response = [NSURLConnection sendSynchronousRequest:request returningResponse:nil error:nil];
    
    //receber a reposta em json numa string
    NSString *json_string = [[NSString alloc] initWithData:response encoding:NSUTF8StringEncoding];
    
    //converter dados json da string num objecto(dicionário)
    dicTweets = [parser objectWithString:json_string error:nil];
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
