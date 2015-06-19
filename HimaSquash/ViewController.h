//
//  ViewController.h
//  HimaSquash
//
//  Created by Minami Sophia Aramaki on 2015/05/10.
//  Copyright (c) 2015年 Minami Sophia Aramaki. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <AudioToolbox/AudioToolbox.h>

@interface ViewController : UIViewController{
    IBOutlet UIProgressView *expBar;
    UILabel *levelLabel;
    UIButton *himaBtn[20];
    
    NSMutableArray *labelDraw;
    NSArray *fontsArray;
    int makeCount;
    int squashCount;
    int level;
    
    SystemSoundID born_sound;
    SystemSoundID squash_sound;
}


@end

