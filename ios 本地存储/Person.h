//
//  Person.h
//  ios 本地存储
//
//  Created by kys-20 on 2017/11/26.
//  Copyright © 2017年 kys-20. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Person : NSObject<NSCoding>
@property (nonatomic,copy) NSString *name;
@property (nonatomic,copy) NSString *age;


@end
