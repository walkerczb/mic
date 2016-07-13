//
//  GuideViewController.m
//  mic
//
//  Created by Zhongbo on 16/7/12.
//  Copyright © 2016年 tailong. All rights reserved.
//

#import "GuideViewController.h"
#import "LoginViewController.h"

#define kImageCount 4
#define kIntoButtonRatio 0.8//intoButton相对于pageImageView的高度比
#define kPageControlRatio 0.9//pageControl相对于根视图的高度比

@interface GuideViewController ()
@property(nonatomic,strong)UIPageControl *pageControl;
@end

@implementation GuideViewController

-(void)loadView{
    [super loadView];
    //    要设置背景图片,创建一个rootImageView作为父视图
    [self createRootImageView];
}
#pragma mark 创建rootImageView
-(void)createRootImageView{
    UIImageView *rootImageView=[[UIImageView alloc] initWithFrame:self.view.bounds];
    [rootImageView setImage:[UIImage imageNamed:@"new_feature_background.png"]];
    [self.view addSubview:rootImageView];
    //    因为父视图是一个imageView,要开启互动,否则无法做任何操作
    [self.view setUserInteractionEnabled:YES];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    //     创建第二层的scrollView
    [self createScrollView];
    //     创建第二层的pageControl
    [self createPageControl];
    // Do any additional setup after loading the view.
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
#pragma mark 创建第二层视图scrollView
-(void)createScrollView{
    UIScrollView *scrollView=[[UIScrollView alloc]initWithFrame:self.view.bounds];
    //    设置scrollView内容大小--可滑动范围
    [scrollView setContentSize:CGSizeMake(self.view.bounds.size.width*kImageCount, 0)];
    //    向其中添加pageImageView
    CGFloat width=self.view.bounds.size.width;
    CGFloat height=self.view.bounds.size.height;
    for (NSInteger i=0; i<kImageCount; i++) {
        //        相对于scrollView内容的位置
        UIImageView *pageImageView=[[UIImageView alloc] initWithFrame:CGRectMake(i*width, 0, width, height)];
        [pageImageView setImage:[UIImage imageNamed:[NSString stringWithFormat:@"new_feature_%ld.png",i + 1]]];
        if (i==kImageCount - 1) {
            [self createLoginButton:pageImageView];
        }
        [scrollView addSubview:pageImageView];
    }
    //    设置分页,否则滚动效果很糟糕
    [scrollView setPagingEnabled:YES];
    //    去掉弹性
    [scrollView setBounces:NO];
    //    去掉滚动条
    [scrollView setShowsHorizontalScrollIndicator:NO];
    [scrollView setShowsVerticalScrollIndicator:NO];
    //    设置代理,以便于滑动时改变pageControl
    [scrollView setDelegate:self];
    //    scrollView目前为第二层视图
    [self.view addSubview:scrollView];
}
#pragma mark 创建最后一页的“立即体验”按钮
-(void)createLoginButton:(UIImageView*)pageImageView{
    //    开启父视图交互
    [pageImageView setUserInteractionEnabled:YES];
    UIButton *loginButton=[[UIButton alloc] init];
    //    设置背景图片
    UIImage *backImage=[UIImage imageNamed:@"new_feature_finish_button.png"];
    UIImage *backImageHL=[UIImage imageNamed:@"new_feature_finish_button_highlighted.png"];
    [loginButton setBackgroundImage:backImage forState:UIControlStateNormal];
    [loginButton setBackgroundImage:backImageHL forState:UIControlStateHighlighted];
    //    设置中心点和大小,大小根据背景
    CGFloat centerX=pageImageView.bounds.size.width/2;
    CGFloat centerY=pageImageView.bounds.size.height * kIntoButtonRatio;
    CGFloat width=backImage.size.width;
    CGFloat height=backImage.size.height;
    [loginButton setBounds:CGRectMake(0, 0, width, height)];
    [loginButton setCenter:CGPointMake(centerX, centerY)];
    //    消息响应
    [loginButton addTarget:self action:@selector(loginButtonClick) forControlEvents:UIControlEventTouchUpInside];
    //    添加到pageImageView
    [pageImageView addSubview:loginButton];
    
}
#pragma mark "立即体验"按钮消息响应
-(void)loginButtonClick{
    UIStoryboard* mainStroyBoard = [UIStoryboard storyboardWithName:@"Main" bundle:nil];
    LoginViewController* loginViewController = [mainStroyBoard instantiateViewControllerWithIdentifier:@"loginViewController"];
    [UIApplication sharedApplication].keyWindow.rootViewController = loginViewController;
    
    [[NSUserDefaults standardUserDefaults] setBool:YES forKey:@"firstLaunch"];
}
#pragma mark 创建和scrollView同为第二层视图的pageControl
-(void)createPageControl{
    
    _pageControl=[[UIPageControl alloc] init];
    //    设置位置
    [_pageControl setCenter:CGPointMake(self.view.bounds.size.width/2, self.view.bounds.size.height * kPageControlRatio)];
    [_pageControl setBounds:CGRectMake(0, 0, 150, 44)];
    //    设置页数
    [_pageControl setNumberOfPages:kImageCount];
    //    设置页面轨道颜色
    [_pageControl setPageIndicatorTintColor:[UIColor grayColor]];
    [_pageControl setCurrentPageIndicatorTintColor:[UIColor orangeColor]];
    //    注意，父视图不是ScrollView!
    [self.view addSubview:_pageControl];
}

#pragma mark scrollView的代理方法
-(void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView{
    NSInteger index=scrollView.contentOffset.x/scrollView.bounds.size.width;
    [_pageControl setCurrentPage:index];
}


@end
