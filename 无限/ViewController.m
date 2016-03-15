//
//  ViewController.m
//  无限
//
//  Created by hunuo on 16/3/15.
//  Copyright © 2016年 hunuo. All rights reserved.
//

#import "ViewController.h"

#define Width [UIScreen mainScreen].bounds.size.width
#define Height [UIScreen mainScreen].bounds.size.height

@interface ViewController ()<UIScrollViewDelegate>
{
    UIScrollView *_scrollView;
    UIImageView *_leftImageView;
    UIImageView *_centerImageView;
    UIImageView *_rightImageView;
    UIPageControl *_pageControl;
    UILabel *_label;
    NSArray *_imageData;//图片数据
    int _currentImageIndex;//当前图片索引
    int _imageCount;//图片总数
}


@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    // Do any additional setup after loading the view, typically from a nib.
    
    //加载数据
    [self loadImageData];
    //添加滚动控件
    [self addScrollView];
    //添加图片控件
    [self addImageViews];
    //添加分页控件
    [self addPageControl];
    //添加图片信息描述控件
    [self addLabel];
    //加载默认图片
    [self setDefaultImage];
}

- (void)loadImageData
{
    _imageData = @[@"youhou_10", @"youhou_11", @"youhou_12", @"youhou_13", @"youhou_14", @"youhou_15"];
//    _imageData = @[@"youhou_10", @"youhou_11"];
    _imageCount = (int)_imageData.count;
    
}

- (void)addScrollView
{
    _scrollView=[[UIScrollView alloc]initWithFrame:[UIScreen mainScreen].bounds];
    [self.view addSubview:_scrollView];
    //设置代理
    _scrollView.delegate=self;
    //设置contentSize
    _scrollView.contentSize=CGSizeMake(3*Width, 200) ;
    //设置当前显示的位置为中间图片
    [_scrollView setContentOffset:CGPointMake(Width, 0) animated:NO];
    //设置分页
    _scrollView.pagingEnabled=YES;
    //去掉滚动条
    _scrollView.showsHorizontalScrollIndicator=NO;
}

#pragma mark 添加图片三个控件
-(void)addImageViews{
    _leftImageView=[[UIImageView alloc]initWithFrame:CGRectMake(0, 0, Width, 200)];
//    _leftImageView.contentMode=UIViewContentModeScaleAspectFit;
    [_scrollView addSubview:_leftImageView];
    _centerImageView=[[UIImageView alloc]initWithFrame:CGRectMake(Width, 0, Width, 200)];
//    _centerImageView.contentMode=UIViewContentModeScaleAspectFit;
    [_scrollView addSubview:_centerImageView];
    _rightImageView=[[UIImageView alloc]initWithFrame:CGRectMake(2*Width, 0, Width, 200)];
//    _rightImageView.contentMode=UIViewContentModeScaleAspectFit;
    [_scrollView addSubview:_rightImageView];
    
}

#pragma mark 设置默认显示图片
-(void)setDefaultImage{
    //加载默认图片
   
    _leftImageView.image=[UIImage imageNamed:_imageData[_imageCount-1]];
    _centerImageView.image=[UIImage imageNamed:_imageData[0]];
    _rightImageView.image=[UIImage imageNamed:_imageData[1]];
    _currentImageIndex=0;
    //设置当前页
    _pageControl.currentPage=_currentImageIndex;
   
    _label.text=_imageData[0];
}

- (void)addPageControl
{
    _pageControl=[[UIPageControl alloc]init];
    //注意此方法可以根据页数返回UIPageControl合适的大小
    CGSize size= [_pageControl sizeForNumberOfPages:_imageCount];
    _pageControl.bounds=CGRectMake(0, 0, size.width, size.height);
    _pageControl.center=CGPointMake(Width/2, 180);
    //设置颜色
    _pageControl.pageIndicatorTintColor=[UIColor colorWithRed:193/255.0 green:219/255.0 blue:249/255.0 alpha:1];
    //设置当前页颜色
    _pageControl.currentPageIndicatorTintColor=[UIColor colorWithRed:0 green:150/255.0 blue:1 alpha:1];
    //设置总页数
    _pageControl.numberOfPages=_imageCount;
    
    [self.view addSubview:_pageControl];
}

#pragma mark 添加信息描述控件
-(void)addLabel{
    
    _label=[[UILabel alloc]initWithFrame:CGRectMake(0, 10, Width,30)];
    _label.textAlignment=NSTextAlignmentCenter;
    _label.textColor=[UIColor colorWithRed:0 green:150/255.0 blue:1 alpha:1];
    
    [self.view addSubview:_label];
}

- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView
{
    [self reloadImage];
    
    [_scrollView setContentOffset:CGPointMake(Width, 0) animated:NO];
    
    _pageControl.currentPage = _currentImageIndex;
    
    _label.text = _imageData[_currentImageIndex];
}

- (void)reloadImage
{
    int leftImageIndex, rightImageIndex;
    CGPoint offset = [_scrollView contentOffset];
    if (offset.x > Width) {//向右滑动
        _currentImageIndex =  (_currentImageIndex + 1) % _imageCount;
    }else if (offset.x < Width)
    {
        _currentImageIndex = (_currentImageIndex + _imageCount - 1) % _imageCount;
    }
    
    _centerImageView.image = [UIImage imageNamed:_imageData[_currentImageIndex]];
    
    //重新设置左右图片
    leftImageIndex = (_currentImageIndex + _imageCount - 1) % _imageCount;
    rightImageIndex = (_currentImageIndex + 1) % _imageCount;
    _leftImageView.image = [UIImage imageNamed:_imageData[leftImageIndex]];
    _rightImageView.image = [UIImage imageNamed:_imageData[rightImageIndex]];
}

@end
