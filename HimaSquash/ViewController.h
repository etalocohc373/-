//
//  ViewController.h
//  HimaSquash
//
//  Created by Minami Sophia Aramaki on 2015/05/10.
//  Copyright (c) 2015年 Minami Sophia Aramaki. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ViewController : UIViewController{
    IBOutlet UIProgressView *expBar;
    UILabel *levelLabel;
    
    NSMutableArray *labelDraw;
    int makeCount;
    int squashCount;
    int level;
}


@end

