//
//  linePesist.m
//  ios 本地存储
//
//  Created by kys-20 on 2017/11/27.
//  Copyright © 2017年 kys-20. All rights reserved.
//

#import "linePesist.h"
#define CodeStr @"CodeStr"
/* 通过遵循NSCoding和NSCoping中的方法，创建可归档的数据对象。*/
@implementation linePesist
//编码
- (void)encodeWithCoder:(NSCoder *)aCoder
{
    [aCoder encodeObject:self.array forKey:CodeStr];
}
//解码
- (id) initWithCoder:(NSCoder *)aDecoder
{
    self = [super init];
    if (self)
    {
        self.array = [aDecoder decodeObjectForKey:CodeStr];
    }
    return self;
}
//??? 这个方法是干啥的
#pragma mark =====coping =====
- (id)copyWithZone:(NSZone *)zone
{
   linePesist *copy = [[[self class]allocWithZone:zone] init];
    NSMutableArray *muArray = [[NSMutableArray alloc] init];
    for (id line in self.array)
    {
        [muArray addObject:[line copyWithZone:zone]];
    }
    copy.array = muArray;
    return copy;
}
@end
