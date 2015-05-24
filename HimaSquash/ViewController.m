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
    if(makeCount >= 100 * 3) {
        HimaData *newData = [[HimaData alloc] init];
        newData.x = arc4random() % (int)SCREEN_WIDTH;
        newData.y = arc4random() % (int)SCREEN_HEIGHT;
		if(level >= 2) newData.font = @"Hiragino Kaku Gothic ProN";
		else newData.font = @"Hiragino Mincho ProN";
        [labelDraw addObject:newData];
        
        makeCount = 0;
    }
    
	for (UIView *view in [self.view subviews]) {
		if ([view.class isSubclassOfClass:[UIButton class]])
			[view removeFromSuperview];
		
	}
	
    for (int i = 0; i < labelDraw.count; i++) {
        HimaData *himaData = [labelDraw objectAtIndex:i];
        if(!himaData.sec && arc4random() % 300 == 1){//動かす
            int hoge = arc4random() % 2 - 1;
            if(hoge == 0) hoge = 1;
            
            himaData.sec = arc4random() % 3 + 1;
            himaData.xVel = arc4random() % (VELOCOTY * 2 * 10) / 10.0 - VELOCOTY;
            himaData.yVel = (VELOCOTY - abs(himaData.xVel)) * hoge;
            
        }else if(himaData.sec){
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
        
        UIButton *btn = [[UIButton alloc] initWithFrame:CGRectMake(himaData.x, himaData.y, 50, 50)];
        [btn setTitle:@"暇" forState:UIControlStateNormal];
        btn.titleLabel.font = [UIFont fontWithName:himaData.font size:30];
		[btn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
		btn.tag = i;
        [btn addTarget:self action:@selector(squashHima:) forControlEvents:UIControlEventTouchDown];
        [self.view addSubview:btn];
    }
}

/*-(void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event{
    UITouch *touch = [[event allTouches] anyObject];
    
    NSLog(@"aaa: %ld", (long)touch.view.tag);
    
    switch (touch.view.tag) {
        case 0:
            break;
            
        default:
            [labelDraw removeObjectAtIndex:touch.view.tag - 1];
            break;
    }
}*/

-(void)squashHima:(UIButton *)btn{
	squashCount++;
	[labelDraw removeObjectAtIndex:btn.tag];
	
	[expBar setProgress:(float)squashCount / 5 animated:YES];
	
	if(squashCount >= 5){
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
