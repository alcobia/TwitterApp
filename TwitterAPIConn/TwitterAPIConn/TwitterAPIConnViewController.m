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

@synthesize tblView;

@synthesize tweetsReceived;

@synthesize textTweet;
@synthesize createdTweet;
@synthesize nameUser;
@synthesize imgUser;

@synthesize user;

-(IBAction)meusTweets
{        
    [UIView beginAnimations:nil context:NULL];
	[UIView setAnimationDuration:1.5];	
	[UIView setAnimationTransition:UIViewAnimationTransitionCurlDown forView:self.view cache:YES];
    
    if([[[NSUserDefaults standardUserDefaults] stringForKey:@"enabled_preference"] isEqualToString:@"0"])
    {
        user = txtfieldUser.text;
        txtfieldUser.text = @"";
    }
    else if([[[NSUserDefaults standardUserDefaults] stringForKey:@"enabled_preference"] isEqualToString:@"1"])
    {
        user = txtfieldUser.text;
        txtfieldUser.text = @"";
        [[NSUserDefaults standardUserDefaults] setValue:user forKey:@"name_preference"];
    }
    
    [view2 removeFromSuperview];
        
    [UIView commitAnimations];
    
    NSString *url = [[NSString alloc] initWithFormat:@"http://api.twitter.com/1/statuses/user_timeline.json?screen_name=%@",user];
    [self connectURL:url];
    
    [tblView reloadData];
    
    navControllerSelfView.title = @"Meus Tweets";
}

-(IBAction)transitionFlip2{    
	[UIView beginAnimations:nil context:NULL];
	[UIView setAnimationDuration:1.5];	
	[UIView setAnimationTransition:UIViewAnimationTransitionFlipFromLeft forView:self.view cache:YES];
	
    [view1 removeFromSuperview];//remove a subview adicionada à self.view
        
	[UIView commitAnimations];	
}

- (void)tabBar:(UITabBar *)tabBar didSelectItem:(UITabBarItem *)item {
    if([item.title isEqualToString:@"Meus Tweets"])
    {
        if([[[NSUserDefaults standardUserDefaults] stringForKey:@"name_preference"] isEqualToString:@""])
        {
            [UIView beginAnimations:nil context:NULL];
            [UIView setAnimationDuration:1.5];	
            [UIView setAnimationTransition:UIViewAnimationTransitionCurlUp forView:self.view cache:YES];
            
            [self.view addSubview:view2];
            
            [UIView commitAnimations];
        }
        else
        {
            [UIView beginAnimations:nil context:NULL];
            [UIView setAnimationDuration:1.5];	
            [UIView setAnimationTransition:UIViewAnimationTransitionCurlUp forView:self.view cache:YES];
            
            NSString *username = [[NSUserDefaults standardUserDefaults] stringForKey:@"name_preference"];
            NSString *url = [[NSString alloc] initWithFormat:@"http://api.twitter.com/1/statuses/user_timeline.json?screen_name=%@",username];
            
            [self connectURL:url];
            
            [UIView commitAnimations];
            
            [tblView reloadData];
            
            navControllerSelfView.title = @"Meus Tweets";
        }
    }
    else
    {
        [UIView beginAnimations:nil context:NULL];
        [UIView setAnimationDuration:1.5];	
        [UIView setAnimationTransition:UIViewAnimationTransitionCurlUp forView:self.view cache:YES];
        
        [self connectURL:@"http://twitter.com/statuses/public_timeline.json"];
        
        [tblView reloadData];//actualiza a table view com os novos dados do array
        
        [UIView commitAnimations];
        
        navControllerSelfView.title = @"Tweets Publicos";
    }
}

-(void)connectURL:(NSString *)url
{
    SBJsonParser *parser = [[SBJsonParser alloc] init];
    
    //definir o url do nosso request
    NSURLRequest *request = [NSURLRequest requestWithURL:[NSURL URLWithString:url]];
    
    //executar o request e guardar os dados num objecto NSData
    NSData *response = [NSURLConnection sendSynchronousRequest:request returningResponse:nil error:nil];
    
    //converter para string a informação da variável response
    NSString *json_string = [[NSString alloc] initWithData:response encoding:NSUTF8StringEncoding];
    
    //converter a string json_string, que contém a informação dos tweets, para um array
    tweetsReceived = [parser objectWithString:json_string error:nil];
    
    //arrays inicializados e alocados, para permitirem a inserção de novos objectos
    NSMutableArray *text = [[NSMutableArray alloc]init];
    NSMutableArray *createdAt = [[NSMutableArray alloc]init];
    NSMutableArray *name = [[NSMutableArray alloc]init];
    NSMutableArray *profileImgUrl = [[NSMutableArray alloc]init];
    NSMutableArray *description = [[NSMutableArray alloc]init];
    
    int i=0;
    for(NSDictionary *dic in tweetsReceived){
        //inserção da respectiva informação nos respectivos arrays
        [text insertObject:[dic objectForKey:@"text"] atIndex:i];
        [createdAt insertObject:[dic objectForKey:@"created_at"] atIndex:i];
        
        NSDictionary *users = [dic objectForKey:@"user"];
        
        [name insertObject:[users objectForKey:@"name"] atIndex:i];
        [profileImgUrl insertObject:[users objectForKey:@"profile_image_url"] atIndex:i];
        [description insertObject:[users objectForKey:@"description"] atIndex:i];
        
        i++;
    }
    
    //passar os valores dos arrays criados em runtime, para as  variáveis "globais"
    textTweet = text; 
    createdTweet = createdAt;
    nameUser = name;
    imgUser = profileImgUrl;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
	return [tweetsReceived count];//retorna a quantidade de rows de uma secção
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;//retorna o número de secções da table view
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [UIView beginAnimations:nil context:NULL];
    
    //define o tempo de duração da transition
	[UIView setAnimationDuration:1.5];	
	
    //define a forma como a transition é feita (animação)
	[UIView setAnimationTransition:UIViewAnimationTransitionFlipFromRight forView:self.view cache:YES];
	
    //adicionar a view 1 à self.view
    [self.view addSubview:view1];
    
    [txtviewNameUser setText:[nameUser objectAtIndex:indexPath.row]];//afectar a text view com o nome do user que criou o tweet
    [txtviewNameUser setEditable:NO];//definir a text view como não editável
    [txtviewCreatedAt setText:[createdTweet objectAtIndex:indexPath.row]];
    [txtviewCreatedAt setEditable:NO];
    [txtviewTextTweet setText:[textTweet objectAtIndex:indexPath.row]];
    [txtviewTextTweet setEditable:NO];
    
    id urlPath = [imgUser objectAtIndex:indexPath.row];
    NSURL *url = [NSURL URLWithString:urlPath];
    NSData *data = [NSData dataWithContentsOfURL:url];
    UIImage *image = [UIImage imageWithData:data];
    [imageUser setImage:image];
	
    //finaliza a transition
	[UIView commitAnimations];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{    
    UITableViewCell *cell =[tblView dequeueReusableCellWithIdentifier:@"cell"];
    
    if (cell == nil){//criar célula
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:@"cell"];
    }    
    
    //definir o texto da célula
    cell.textLabel.text = [textTweet objectAtIndex:indexPath.row];
    
    //definir os detalhes da célula
    cell.detailTextLabel.text = [createdTweet  objectAtIndex:indexPath.row];
    
    //definir a imagem recebida do tweet à célula
    id urlPath = [imgUser objectAtIndex:indexPath.row];
    NSURL *url = [NSURL URLWithString:urlPath];
    NSData *data = [NSData dataWithContentsOfURL:url];
    UIImage *image = [UIImage imageWithData:data];
    cell.imageView.image = image;
    
    //definir o estilo de uma célula quando é seleccionada
    cell.selectionStyle = UITableViewCellSelectionStyleGray; 

    return cell;
}

- (void)dealloc
{
    [view1 release];
    [view2 release];
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
}

- (void)viewDidUnload
{
    [super viewDidUnload];
    // Release any retained subviews of the main view.
    // e.g. self.myOutlet = nil;
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
        return YES;
}

@end
