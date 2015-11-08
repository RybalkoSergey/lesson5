//
//  Game.m
//  Matcho
//
//  Created by Anton Lookin on 10/27/15.
//  Copyright © 2015 geekub. All rights reserved.
//

#import "Game.h"
#import "GameOverViewController.h"

@interface Game ()

@property (nonatomic, readwrite) NSInteger score;
@property (nonatomic, strong) NSMutableArray *cards;

- (BOOL)hasMachedCard:(Card *)choosenCard;

@end


@implementation Game


- (instancetype)initWithCardCount:(NSUInteger)count
						usingDeck:(Deck *)deck {
	self = [super init];
	
	if (self) {
		for (NSUInteger i = 0; i < count; i++) {
			Card *card = [deck drawRandomCard];
			
			if (card) {
				[self.cards addObject:card];
			} else {
				self = nil;
				break;
			}
		}
	}
	
	return self;
}


- (NSMutableArray *)cards {
	if (!_cards) _cards = [[NSMutableArray alloc] init];
	return _cards;
}


static const int MISMATCH_PENALTY = 2;
static const int MATCH_BONUS = 4;
static const int COST_TO_CHOOSE = 1;


- (void)chooseCardAtIndex:(NSUInteger)index {
	Card *card = [self cardAtIndex:index];
	
	if (!card.isMatched) {

//        [self.mainViewDelegate openGameOverView];
//        return;
//        
        if (card.isChosen) {
			card.chosen = NO;
            self.currentAction = [NSString stringWithFormat:@"Close card %@", card.contents];
		} else {
			NSMutableArray *chosenCards = [[NSMutableArray alloc] init];
			
            self.currentAction = [NSString stringWithFormat:@"Open card %@", card.contents];
            
			for (Card *otherCard in self.cards) {
				if (otherCard.isChosen && !otherCard.isMatched) {
					[chosenCards addObject:otherCard];
				}
			}
			
			if ([chosenCards count]) {
				int matchScore = [card match:chosenCards];
				if (matchScore) {
					self.score += (matchScore * MATCH_BONUS);
					
					card.chosen = YES;
					card.matched = YES;
					for (Card *otherCard in chosenCards) {
						otherCard.matched = YES;
                        self.currentAction = [NSString stringWithFormat:@"Cards %@ and %@ mached!!!", card.contents, otherCard.contents];
					}
				} else {
					int penalty = MISMATCH_PENALTY;
					
					self.score -= penalty;
					
					card.chosen = YES;
					for (Card *otherCard in chosenCards) {
						otherCard.chosen = NO;
                        self.currentAction = [NSString stringWithFormat:@"Cards %@ and %@ not mached", card.contents, otherCard.contents];
					}
                    
				}
			} else {
				self.score -= COST_TO_CHOOSE;
				card.chosen = YES;
                
			}
            
            if (![self hasMachedCard:card]) {
                self.currentAction = [NSString stringWithFormat:@"Game over"];
                [self.mainViewDelegate showGameOverWindow];
            }
		}
	}
    
//    [self.mainViewDelegate openGameOverView];
}

- (BOOL)hasMachedCard:(Card *)choosenCard {
    NSMutableArray *closeCards = [[NSMutableArray alloc] init];
    for (Card *card in self.cards) {
        if (!card.isChosen && !card.isMatched) {
            [closeCards addObject:card];
        }
    }
    
    for (Card *closeCard in closeCards) {
        if ([choosenCard match:@[closeCard]]) {
            return YES;
        }
    }
    
    return NO;
}

- (Card *)cardAtIndex:(NSUInteger)index {
	return (index < [self.cards count]) ? self.cards[index] : nil;
}


@end
