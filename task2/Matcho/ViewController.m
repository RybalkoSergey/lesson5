//
//  ViewController.m
//  Matcho
//
//  Created by Anton Lookin on 10/19/15.
//  Copyright © 2015 geekub. All rights reserved.
//

#import "Game.h"
#import "PlayingCardDeck.h"
#import "ViewController.h"
#import "GameOverViewController.h"



@interface ViewController ()

@property (nonatomic, strong) Game *game;
@property (strong, nonatomic) IBOutletCollection(UIButton) NSArray *cardButtons;
@property (weak, nonatomic) IBOutlet UILabel *resultLabel;
@property (weak, nonatomic) IBOutlet UILabel *logLabel;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    NSLog(@"%@", self);
}

- (Game *)game {
	if (!_game) {
		_game = [[Game alloc] initWithCardCount:[self.cardButtons count]
									  usingDeck:[[PlayingCardDeck alloc] init]];
        
        _game.mainViewDelegate = self;
	}
	return _game;
}

- (IBAction)showGameOverWindow:(id)sender {
//    UIStoryboard *storyboard = [UIStoryboard storyboardWithName:@"Main" bundle: nil];
//    GameOverViewController *gameOveVC = [storyboard instantiateViewControllerWithIdentifier:@"GameOverView"];
//    [self.navigationController pushViewController:gameOveVC animated:YES];

    UIStoryboard *storyboard = [UIStoryboard storyboardWithName:@"Main" bundle: nil];
    GameOverViewController *gameOveVC = [storyboard instantiateViewControllerWithIdentifier:@"GameOverView"];
    [self presentViewController:gameOveVC animated:YES completion:nil];
    
//    [self performSegueWithIdentifier: @"GameOverVCModal" sender: self];
    
//    [self performSegueWithIdentifier: @"GameOverVC" sender: self];
    
}

- (IBAction)cardButtonTapped:(UIButton *)sender {
	NSUInteger cardIndex = [self.cardButtons indexOfObject:sender];
	[self.game chooseCardAtIndex:cardIndex];
    
    self.resultLabel.text = [NSString stringWithFormat:@"Your result: %li", (long)[self.game score]];
    self.logLabel.text = [NSString stringWithFormat:@"Log: %@", self.game.currentAction];
    
    [self updateUI];
}


-(void) updateUI {
	for (UIButton *cardButton in self.cardButtons) {
		NSUInteger cardIndex = [self.cardButtons indexOfObject:cardButton];
		Card *card = [self.game cardAtIndex:cardIndex];
		
		[cardButton setTitle:[self titleForCard:card] forState:UIControlStateNormal];
		[cardButton setBackgroundImage:[self backgroundImageForCard:card]
							  forState:UIControlStateNormal];
		cardButton.enabled = !card.isMatched;
	}
}


-(NSString *) titleForCard:(Card *)card {
	return (card.isChosen) ? card.contents : @"";
}


-(UIImage *) backgroundImageForCard:(Card *)card {
	return [UIImage imageNamed:(card.isChosen) ? @"cardfront" : @"cardback"];
}

-(void)openGameOverView {
    [self performSegueWithIdentifier: @"GameOverVC" sender: self];
    
//    UIStoryboard *storyboard = [UIStoryboard storyboardWithName:@"Main" bundle: nil];
//    GameOverViewController *gameOveVC = [storyboard instantiateViewControllerWithIdentifier:@"GameOverView"];
//    [self.navigationController pushViewController:gameOveVC animated:YES];
}

-(void)openModalGameOverView {
    [self performSegueWithIdentifier: @"GameOverVCModal" sender: self];
    
//    UIStoryboard *storyboard = [UIStoryboard storyboardWithName:@"Main" bundle: nil];
//    GameOverViewController *gameOveVC = [storyboard instantiateViewControllerWithIdentifier:@"GameOverView"];
//    [self presentViewController:gameOveVC animated:YES completion:nil];
}

-(void)showGameOverWindow {
        switch (self.tabBarController.selectedIndex)
        {
            case 0:
                [self openGameOverView];
                break;
            case 1:
                [self openModalGameOverView];
                break;
            default:
                break;
                
        }
}
    
@end
