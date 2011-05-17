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

@synthesize statuses;
@synthesize tblView;
@synthesize textTweet;
@synthesize createdTweet;
@synthesize nameUser;
@synthesize imgUser;
@synthesize descriptionUser;

//método para quando é carregado o botao back da view seguinte que é mostrada, remover a mesma e mostrar a view anterior.

- (void)tabBar:(UITabBar *)tabBar didSelectItem:(UITabBarItem *)item {
    
}

-(IBAction)transitionFlip2{    
	[UIView beginAnimations:nil context:NULL];
	[UIView setAnimationDuration:1.5];	
	[UIView setAnimationTransition:UIViewAnimationTransitionFlipFromLeft forView:self.view cache:YES];
	
    //remove a view onde sao mostrados os detalhes da informaçao da célula
    [view1 removeFromSuperview];
        
	[UIView commitAnimations];	
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
	return [statuses count];
}

// Override to support row selection in the table view. 
//Este método serve para mostarr outra view com os detalhes da informaçao quando uma célula é carregada
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    
    int index = indexPath.row;
    [UIView beginAnimations:nil context:NULL];
    
    //define o tempo de duraçao da transition
	[UIView setAnimationDuration:1.5];	
	
    //define o tipo de transition entre as views
	[UIView setAnimationTransition:UIViewAnimationTransitionFlipFromRight forView:self.view cache:YES];
	
    //adiciona (sobrepoe) a view seguinte na self view
    [self.view addSubview:view1];
    [lblNameUser setText:[nameUser objectAtIndex:index]];
    [lblCreatedAt setText:[createdTweet objectAtIndex:index]];
    [lbltweetText setText:[textTweet objectAtIndex:index]];
    [lbldescriptionUser setText:[descriptionUser objectAtIndex:index]];
    
    id urlPath = [imgUser objectAtIndex:index];
    NSURL *url = [NSURL URLWithString:urlPath];
    NSData *data = [NSData dataWithContentsOfURL:url];
    UIImage *image = [UIImage imageWithData:data];
    [imageUser setImage:image];
	
    //executa finalmente a animaçao
	[UIView commitAnimations];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{    
    int index = indexPath.row;
    // Configurar célula
    UITableViewCell *cell =[tblView dequeueReusableCellWithIdentifier:@"cell"];
    
    //criar célula
    if (cell == nil){
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:@"cell"];
    }    
    
    //afectar célula com os dados recebidos
    cell.textLabel.text = [textTweet objectAtIndex:index];
    
    //definir detalhes
    cell.detailTextLabel.text = [createdTweet  objectAtIndex:index];
    
    //definir imagem
    id urlPath = [imgUser objectAtIndex:index];
    NSURL *url = [NSURL URLWithString:urlPath];
    NSData *data = [NSData dataWithContentsOfURL:url];
    UIImage *image = [UIImage imageWithData:data];
    cell.imageView.image = image;
    
    //definir o estilo de célula seleccionada
    cell.selectionStyle = UITableViewCellSelectionStyleGray; 

    return cell;
}

- (void)dealloc
{
    [view1 release];
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
    
    //Passar a informaçao dos tweets para um array/dicionário
    statuses = [parser objectWithString:json_string error:nil];

    //criaçao de arrays estáticos (init e o alloc permitem, a inserçao de novos objectos no array, por isso é necessário faze-lo), para conter a informaçao pretendida
    NSMutableArray *text = [[NSMutableArray alloc]init];
    NSMutableArray *createdAt = [[NSMutableArray alloc]init];
    NSMutableArray *name = [[NSMutableArray alloc]init];
    NSMutableArray *profileImgUrl = [[NSMutableArray alloc]init];
    NSMutableArray *description = [[NSMutableArray alloc]init];
    
    int i=0;
    //correr o array tweets
    for(NSDictionary *dic in statuses){
        //forma de inserir um novo objecto no array
        [text insertObject:[dic objectForKey:@"text"] atIndex:i];
        [createdAt insertObject:[dic objectForKey:@"created_at"] atIndex:i];
        
        NSDictionary *user = [dic objectForKey:@"user"];

        [name insertObject:[user objectForKey:@"name"] atIndex:i];
        [profileImgUrl insertObject:[user objectForKey:@"profile_image_url"] atIndex:i];
        [description insertObject:[user objectForKey:@"description"] atIndex:i];
        
        i++;
    }
    
    //afectar as variáveis NSArray criadas no ficheiro TwitterAPIConnViewController, com os arrays construídos em runtime, da informaçao (que se quer) 
    textTweet = text; createdTweet = createdAt;nameUser = name;imgUser = profileImgUrl;descriptionUser=description;
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
