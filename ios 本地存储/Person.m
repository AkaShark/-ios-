//
//  Person.m
//  ios 本地存储
//
//  Created by kys-20 on 2017/11/26.
//  Copyright © 2017年 kys-20. All rights reserved.
//

#import "Person.h"

@implementation Person
//对person对象进行归档时，此方法执行
//对person中想要进行归档的所有属性，进行序列化操作
- (void)encodeWithCoder:(NSCoder *)aCoder
{
    [aCoder encodeObject:self.name forKey:@"name"];
    [aCoder encodeObject:self.age forKey:@"age"];
}
//对person对象进行反归档时，该方法执行
//创建一个新的person对象，所有苏醒都是通过反序列化得到的
- (id)initWithCoder:(NSCoder *)aDecoder
{
    self = [super init];
    if (self)
    {
        self.name = [aDecoder decodeObjectForKey:@"name"];
        self.age = [aDecoder decodeObjectForKey:@"age"];
    }
    return self;
}
//准备一个可变DAta 用于保存归档后的对象
@end
