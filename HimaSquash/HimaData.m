//
//  HimaData.m
//  HimaSquash
//
//  Created by Minami Sophia Aramaki on 2015/05/10.
//  Copyright (c) 2015年 Minami Sophia Aramaki. All rights reserved.
//

#import "HimaData.h"

@implementation HimaData
@synthesize x = _x;
@synthesize y = _y;
@synthesize sec = _sec;
@synthesize xVel = _xVel;
@synthesize yVel = _yVel;
@synthesize font = _font;

- (id)initWithCoder:(NSCoder *)coder {
    self = [self init];
    if (self) {
        _x = [coder decodeFloatForKey:@"himaX"];
        _y = [coder decodeFloatForKey:@"himaY"];
        _sec = [coder decodeFloatForKey:@"himaSec"];
        _xVel = [coder decodeFloatForKey:@"himaXVel"];
        _yVel = [coder decodeFloatForKey:@"himaYVel"];
        _font = [coder decodeObjectForKey:@"font"];
    }
    return self;
}

- (void)encodeWithCoder:(NSCoder *)coder {
    [coder encodeFloat:_x forKey:@"himaX"];
    [coder encodeFloat:_y forKey:@"himaY"];
    [coder encodeFloat:_sec forKey:@"himaSec"];
    [coder encodeFloat:_xVel forKey:@"himaXVel"];
    [coder encodeFloat:_yVel forKey:@"himaYVel"];
    [coder encodeObject:_font forKey:@"font"];
}

- (void)dealloc
{
    self.x = 0;
    self.y = 0;
    self.sec = 0;
    self.xVel = 0;
    self.yVel = 0;
    self.font = nil;
}

@end
