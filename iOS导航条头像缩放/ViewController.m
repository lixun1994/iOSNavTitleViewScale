//
//  ViewController.m
//  iOS导航条头像缩放
//
//  Created by liXun on 16/7/12.
//  Copyright © 2016年 lixun. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()<UITableViewDelegate,UITableViewDataSource,UIScrollViewDelegate>
@property (weak, nonatomic) IBOutlet UITableView *tableView;

@property (nonatomic, strong) UIImageView *headerImage;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    
    
    UIView *titleView = [[UIView alloc] init];
    self.navigationItem.titleView = titleView;
    
    UIImageView *imageView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"test.jpg"]];
    imageView.frame = CGRectMake(0, 0, 70, 70);
    imageView.layer.cornerRadius = 35;
    imageView.layer.masksToBounds = YES;
    imageView.center = CGPointMake(titleView.center.x, 0);
    self.headerImage = imageView;
    [titleView addSubview:imageView];
    
    
    
}


- (NSInteger )tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 50;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell"];
    if (!cell) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"cell"];
    }
    
    cell.textLabel.text = [NSString stringWithFormat:@"李勋tableview---%lu",indexPath.row];
    return cell;
}



- (void) scrollViewDidScroll:(UIScrollView *)scrollView
{
    
    
//    计算放大系数： MIN(1.5, 1 – offsetY / 300);
//    计算缩小系数： MAX(0.45, 1 – offsetY / 300);
//    
//    假设正常状态下用户头像的大小为70，当放大到最大时，不得超过105；当缩小到最小时，不得小于31.5.则这个最大倍数1.5就是我们期望用户头像可放大的最大值除以正常状态下的值，即105/70.0=1.5。同样，最小倍数0.45计算公式为：31.5 / 70.0 = 0.45.
    
    CGFloat offsetY = scrollView.contentOffset.y + scrollView.contentInset.top;
    
//    NSLog(@"%f---%f",scrollView.contentOffset.y,scrollView.contentInset.top);
    
    CGFloat scale = 1.0;
    
    if (offsetY < 0) {
    //向下拉
        scale = MIN(1.5, 1 - offsetY / 300);
        
    }else if (offsetY > 0){
        //向上拉
        
        scale = MAX(0.45, 1 - offsetY / 300);
    }
    
    
    self.headerImage.transform = CGAffineTransformMakeScale(scale, scale);
    
    
    CGRect frame = self.headerImage.frame;
    frame.origin.y =  - self.headerImage.layer.cornerRadius / 2;
    self.headerImage.frame = frame;
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

@end
