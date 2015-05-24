//
//  HimaData.h
//  HimaSquash
//
//  Created by Minami Sophia Aramaki on 2015/05/10.
//  Copyright (c) 2015年 Minami Sophia Aramaki. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface HimaData : NSObject <NSCoding>

@property (nonatomic) float x;
@property (nonatomic) float y;
@property (nonatomic) float sec;
@property (nonatomic) float xVel;
@property (nonatomic) float yVel;
@property (nonatomic) NSString *font;

- (id)initWithCoder:(NSCoder *)coder;
- (void)encodeWithCoder:(NSCoder *)coder;
- (void)dealloc;

@end
