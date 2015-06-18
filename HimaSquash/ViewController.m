//
//  ViewController.m
//  HimaSquash
//
//  Created by Minami Sophia Aramaki on 2015/05/10.
//  Copyright (c) 2015年 Minami Sophia Aramaki. All rights reserved.
//

#import "ViewController.h"

#import "HimaData.h"

#define SCREEN_WIDTH [UIScreen mainScreen].applicationFrame.size.width
#define SCREEN_HEIGHT [UIScreen mainScreen].applicationFrame.size.height

#define VELOCOTY 4

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    
    labelDraw = [NSMutableArray array];
	fontsArray = [NSArray arrayWithObjects:@"Hiragino Kaku Gothic ProN", @"Hiragino Mincho ProN", @"FOT-GMaruGo Pro M", nil];
    
    HimaData *himaData = [[HimaData alloc] init];
    himaData.x = SCREEN_WIDTH / 2;
	himaData.y = SCREEN_HEIGHT / 2;
	if(level) himaData.font = @"Hiragino Kaku Gothic ProN";
	else himaData.font = @"Hiragino Mincho ProN";
	
    [labelDraw addObject:himaData];
	
	level = 1;
	levelLabel = [[UILabel alloc] initWithFrame:CGRectMake(10, 20, 100, 30)];
	levelLabel.text = [NSString stringWithFormat:@"Level: %d", level];
	levelLabel.textColor = [UIColor blackColor];
	levelLabel.font = [UIFont fontWithName:@"Hiragino Kaku Gothic ProN" size:20];
	[self.view addSubview:levelLabel];
	
	expBar.transform = CGAffineTransformMakeScale(1.0, 4.0);
    
    [NSTimer scheduledTimerWithTimeInterval:0.03 target:self selector:@selector(update) userInfo:nil repeats:YES];
	
}

-(void)update{
    /*if(!sec && rand() % 500 == 1){//動かす
        int hoge = rand() % 2 - 1;
        if(hoge == 0) hoge = 1;
        
        sec = rand() % 3 + 1;
        xVel = rand() % (VELOCOTY * 2 * 10) / 10 - VELOCOTY;
        yVel = (VELOCOTY - abs(xVel)) * hoge;
        
    }else if(sec){
        label.center = CGPointMake(label.center.x + xVel, label.center.y + yVel);
        if (label.center.x < 0 || label.center.x > SCREEN_WIDTH) {
            xVel *= -1;
        }
        if(label.center.y < 0 || label.center.y > SCREEN_HEIGHT){
            yVel *= -1;
        }
        
        sec -= 0.05;
        if(sec <= 0.0) sec = 0.0;
    }*/
    if(labelDraw.count < 20) makeCount++;
    if(makeCount >= 100 * 3) {//生成
		[self generateHima];
        makeCount = 0;
    }
	
	/*
	for (UIView *view in [self.view subviews]) {
		if ([view.class isSubclassOfClass:[UIButton class]]){
			[view removeFromSuperview];
		}
	}
	 */
	
    for (int i = 0; i < labelDraw.count; i++) {
        HimaData *himaData = [labelDraw objectAtIndex:i];
        if(!himaData.sec && arc4random() % 300 == 1){//動かす
            int hoge = arc4random() % 2 - 1;
            if(hoge == 0) hoge = 1;
            
            himaData.sec = arc4random() % 3 + 1;
            himaData.xVel = arc4random() % (VELOCOTY * 2 * 10) / 10.0 - VELOCOTY;
            himaData.yVel = (VELOCOTY - fabsf(himaData.xVel)) * hoge;
            
        }else if(himaData.sec){//移動中
            himaData.x += himaData.xVel;
            himaData.y += himaData.yVel;
            
            if (himaData.x < 0 || himaData.x > SCREEN_WIDTH) {
                himaData.xVel *= -1;
            }
            if(himaData.y < 0 || himaData.y > SCREEN_HEIGHT){
                himaData.yVel *= -1;
            }
            
            himaData.sec -= 0.05;
            if(himaData.sec <= 0.0) himaData.sec = 0.0;
        }
		
		himaBtn[i].frame = CGRectMake(himaData.x, himaData.y, 50, 50);
        //himaBtn[i].titleLabel.font = [UIFont fontWithName:himaData.font size:30];
		
		//NSLog(@"updated: %.0f, %.0f", himaData.x, himaData.y);
		himaBtn[i].titleLabel.font = [UIFont fontWithName:himaData.font size:30];
		himaBtn[i].tag = i;
    }
}

-(void)generateHima{
	HimaData *newData = [[HimaData alloc] init];
	newData.x = arc4random() % (int)SCREEN_WIDTH;
	newData.y = arc4random() % (int)SCREEN_HEIGHT;
	
	newData.font = [fontsArray objectAtIndex:level - 1];
	
	[self animateHima:newData];
	NSLog(@"created: %.0f, %.0f", newData.x, newData.y);
}

-(void)animateHima:(HimaData *)newData{
	UIButton *btn  = [[UIButton alloc] initWithFrame:CGRectMake(newData.x, newData.y, 20, 20)];
	[btn setTitle:@"暇" forState:UIControlStateNormal];
	btn.titleLabel.font = [UIFont fontWithName:newData.font size:0.1];
	//btn.titleLabel.font = [UIFont systemFontOfSize:3];
	[btn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
	[btn addTarget:self action:@selector(squashHima:) forControlEvents:UIControlEventTouchDown];
	[self.view addSubview:btn];
	[self.view sendSubviewToBack:btn];
	
	[UIView animateWithDuration:0.05f
						  delay:0.0f
						options:UIViewAnimationOptionCurveEaseIn
					 animations:^{
						 btn.transform = CGAffineTransformMakeScale(2.5, 2.5);
						 btn.titleLabel.font = [UIFont fontWithName:newData.font size:12];
					 }completion:^(BOOL finished) {
						 newData.x -= btn.bounds.size.width / 2 + 5;
						 newData.y -= btn.bounds.size.height / 2 + 5;

						 himaBtn[labelDraw.count] = [[UIButton alloc] initWithFrame:CGRectMake(newData.x, newData.y, 50, 50)];
						 himaBtn[labelDraw.count].titleLabel.font = [UIFont fontWithName:newData.font size:1];
						 [himaBtn[labelDraw.count] setTitle:@"暇" forState:UIControlStateNormal];
						 [himaBtn[labelDraw.count] setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
						 [himaBtn[labelDraw.count] addTarget:self action:@selector(squashHima:) forControlEvents:UIControlEventTouchDown];
						 [self.view addSubview:himaBtn[labelDraw.count]];
						 [self.view sendSubviewToBack:himaBtn[labelDraw.count]];
						 
						 [labelDraw addObject:newData];
						 [btn removeFromSuperview];
					 }];
}

-(void)squashHima:(UIButton *)btn{
	HimaData *himaData = [labelDraw objectAtIndex:btn.tag];
	squashCount += 1 + (int)[fontsArray indexOfObject:himaData.font];
	
	[labelDraw removeObjectAtIndex:btn.tag];
	[himaBtn[btn.tag] removeFromSuperview];
	
	[expBar setProgress:(float)squashCount / 10 animated:YES];
	
	if(squashCount >= 10){
		squashCount = 0;
		level++;
		[self levelUp];
	}
	
}

-(void)levelUp{
	[[[UIAlertView alloc] initWithTitle:@"レベルアップ！" message:@"新しいフォントが解禁されました" delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil, nil] show];
	
	levelLabel.text = [NSString stringWithFormat:@"Level: %d", level];
}

-(void)alertView:(UIAlertView*)alertView clickedButtonAtIndex:(NSInteger)buttonIndex {
	switch (buttonIndex) {
		case 0:
			[expBar setProgress:0.0 animated:NO];
			break;
	}
	
}

@end
