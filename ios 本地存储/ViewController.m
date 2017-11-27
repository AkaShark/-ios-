//
//  ViewController.m
//  ios 本地存储
//
//  Created by kys-20 on 2017/11/26.
//  Copyright © 2017年 kys-20. All rights reserved.
//

#import "ViewController.h"
#import "Person.h"
#import "linePesist.h"
#define CodeStr @"CodeStr"
@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    //字符串
//    [self NSStringSaveAndRead];
    //数组
//    [self NSArraySaveAndRead];
    //NSData
//    [self DataSaveAndRead];
    //NSDic
//    [self NSDicSaveAndRead];
    //使用文件管理器创建文件夹
//    [self creatTheFolder];
    //使用文件管理器创建文件
//    [self creatTheFile];
    //文件移动 （存在问题）
//    [self moveTheFile];
    //文件对接器
//    [self DocumentsDockingDevice];
    //归档操作(归档的时候要写入数据要不以为没读取呢)
//    [self ArchiveTheData];
    //解档操作
//    [self UnArchiverTheData];
    // Do any additional setup after loading the view, typically from a nib.
}
- (void)UnArchiverTheData
{
    //路径
    NSString *cahces = [NSSearchPathForDirectoriesInDomains(NSCachesDirectory, NSUserDomainMask, YES)lastObject];
    NSString *filePath = [cahces stringByAppendingPathComponent:@"person"];
    
    //反归档
    //filePath路径读取
    // 反归档
    // 从filePath文件路径读取
    NSData *data = [NSData dataWithContentsOfFile:filePath];
    // 反归档工具
    NSKeyedUnarchiver *unArchiver = [[NSKeyedUnarchiver alloc] initForReadingWithData:data];
    // 反归档成对象
    Person *p2 = [unArchiver decodeObjectForKey:@"1"];
    // 反归档结
    [unArchiver finishDecoding];
    
}
//导入数据模型类
- (NSString *)dataFile
{
    NSArray *array = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    NSString *filePath = [array objectAtIndex:0];
    return [filePath stringByAppendingPathComponent:@"data.archive"];
    //修改后缀名，以免与属性列表的创建的文件重复，而加载成旧的文件
}
- (void)ArchiveTheData
{
    //准备一个nsmutableData 用于保存归档后的对象
    NSMutableData *data = [NSMutableData data];
    //创建归档工具
    NSKeyedArchiver *archiver = [[NSKeyedArchiver alloc] initForWritingWithMutableData:data];
    //创建person
    Person *p = [[Person alloc] init];

    //归档
//   [archiver encodeObject:p] forKey:@"p1"];
    [archiver encodeObject:p forKey:@"1"];
    //结束
    [archiver finishEncoding];
    //拼音写入沙盒路径
    NSString *cahces = [NSSearchPathForDirectoriesInDomains(NSCachesDirectory, NSUserDomainMask, YES)lastObject];
    NSString *filePath = [cahces stringByAppendingPathComponent:@"person"];
    //写入沙盒
    [data writeToFile:filePath atomically:YES];
}

/**
 *  练习要求：从一个文件中指定的位置开始追加内容
 提示:
 1、在documents目录下创建一个test.txt文件,文件中的内容为"abcdefg"
 2、从文件偏移量为3那个位置开始追加内容"1234"
 */
//这是取代原本文本的第三位后的但是大于添加的部分还是之前的样子

//文件对接器
- (void)DocumentsDockingDevice
{
    //获取documnets
    NSString *docPath = [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES)lastObject];
    //创建文件路径
    NSString *filePath = [docPath stringByAppendingPathComponent:@"test.txt"];
    //使用文件管理对象创建文件
    NSFileManager *fileManger = [NSFileManager defaultManager];
    [fileManger createFileAtPath:filePath contents:[@"aaaaaaaaaaaaaaaaa" dataUsingEncoding:NSUTF8StringEncoding] attributes:nil];
    //创建文件文件对接对象
    NSFileHandle *handle = [NSFileHandle fileHandleForUpdatingAtPath:filePath];
    //将偏移量挪到3的位置
    [handle seekToFileOffset:3];
    //写入数据
    [handle writeData:[@"123" dataUsingEncoding:NSUTF8StringEncoding]];
    //操作完关闭文件(有点想py的文件操作)
    [handle closeFile];
    
}
////文件移动
//- (void)moveTheFile
//{
//    //创建文件夹
//    NSString *docPath = [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES)lastObject];
//    NSString *pathPath = [docPath stringByAppendingPathComponent:@"path"];
//
//    //创建文件
//    NSString *path = [pathPath stringByAppendingPathComponent:@"text.txt"];
//    //获取到cache路径
//    NSString *cachePath = [NSSearchPathForDirectoriesInDomains(NSCachesDirectory, NSUserDomainMask, YES)lastObject];
//    NSString *dirPath =[cachePath stringByAppendingPathComponent:@"testDirectory"];
//    NSString *desPath = [dirPath stringByAppendingPathComponent:@"test.txt"];
//    //创建文件管理器对象，进行文件移动操作
//    NSFileManager *fileManger = [NSFileManager defaultManager];
//
//     [fileManger createFileAtPath:path contents:[@"1" dataUsingEncoding:NSUTF8StringEncoding] attributes:nil];
//     [fileManger createFileAtPath:desPath contents:[@"2" dataUsingEncoding:NSUTF8StringEncoding] attributes:nil];
//    //移动文件
//    [fileManger moveItemAtPath:path toPath:desPath error:nil];//移动文件的核心代码
//
//}
//创建文件
- (void)creatTheFile
{
    //得到Documents路径
    NSString *docPath = [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES)lastObject];
    //创建一个文件路径
    NSString *filePath= [docPath stringByAppendingPathComponent:@"obj.txt"];
    NSFileManager *fileManger = [NSFileManager defaultManager];
    //创建文件
    NSString *content =@"哇啦啦";
    [fileManger createFileAtPath:filePath contents:[content dataUsingEncoding:NSUTF8StringEncoding] attributes:nil];
    //获取某个文件或者某个文件夹的大小
    //字典中包含了文件相关的信息
    NSDictionary *dic = [fileManger attributesOfItemAtPath:filePath error:nil];
    NSNumber *number = [dic objectForKey:NSFileSize];
    //大小
    NSInteger size = number.integerValue;
    
}
//创建文件夹
- (void)creatTheFolder
{
    //获取到Caches路径
    NSString *cachepath = [NSSearchPathForDirectoriesInDomains(NSCachesDirectory, NSUserDomainMask, YES)lastObject];
    //获取创建文件夹的路径
    NSString *dirPath = [cachepath stringByAppendingPathComponent:@"testDirectroy"];
    //创建文件管理对象
    NSFileManager *fileManger = [NSFileManager defaultManager];
    //创建文件夹
    [fileManger createDirectoryAtPath:dirPath withIntermediateDirectories:YES attributes:nil error:nil];

   
}
//NSDic的存储
- (void)NSDicSaveAndRead
{
    //获取Documents目录
    NSString *docPath = [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) lastObject];
    NSString *fileDicPath = [docPath stringByAppendingPathComponent:@"love.txt"];
    NSDictionary *dic = @{@"职业":@"程序员", @"梦想":@"代码无BUG"};
    //字典写入时的执行
    [dic writeToFile:fileDicPath atomically:YES];
    //读取操作
    NSDictionary *resultDic =[NSDictionary dictionaryWithContentsOfFile:fileDicPath];
}
//NSdata的存储
- (void)DataSaveAndRead
{
    //获取Documents目录
    NSString *docPath = [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) lastObject];
    //nsdata写入文件
    //穿件一个存放NSData数据的路径
    NSString *filePath = [docPath stringByAppendingPathComponent:@"icon"];
    //得到一个UIImage对象
    UIImage *image = [UIImage imageNamed:@"消息"];
    //将UIImage对象转成NSData对象
    NSData *data = UIImagePNGRepresentation(image);
    //写入文件
    [data writeToFile:filePath atomically:YES];
    //读取文件
    NSData *resultData = [NSData dataWithContentsOfFile:filePath];
    //将得到的NSData 转化成原有的图片对象
    UIImage *resultImage = [UIImage imageWithData:resultData];
    NSLog(@"%@",resultImage);
}
//数组的存储
- (void)NSArraySaveAndRead
{
    //获取Documents目录
    NSString *docPath = [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) lastObject];
    //数组写入一个文件
    //创建一个存储数组的文件路径
    NSString *filePath = [docPath stringByAppendingPathComponent:@"language.txt"];
    NSArray *array =@[@"C语言", @"JAVA",@"Objective-C", @"Swift", @"PHP", @"C++", @"C#"];
    //数组写入文件执行的方法
    [array writeToFile:filePath atomically:YES];
    
    //从文件中读取数据数组的方法
    NSArray *resultArray = [NSArray arrayWithContentsOfFile:filePath];
    
}
//字符串的写入与读取
- (void)NSStringSaveAndRead
{
    //获取Documents目录
    NSString *docPath = [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) lastObject];
 //字符串写入沙盒
    //在Documents下面穿件一个文本路径，假设文本的名称obic.txt
//此时仅存在路径，文件并没有真实存在
    //这个字符串的方法是拼接往后拼接不是单纯的接上
    NSString *txtPath = [docPath stringByAppendingPathComponent:@"objc.txt"];
    NSString *string = @"Objective-C";
    //字符串写入时执行的方法
    [string writeToFile:txtPath atomically:YES encoding:NSUTF8StringEncoding error:nil];
    NSLog(@"%@",txtPath);
    //字符串提取的方法
    NSString *result = [NSString stringWithContentsOfFile:txtPath encoding:NSUTF8StringEncoding error:nil];
    NSLog(@"%@",result);
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
