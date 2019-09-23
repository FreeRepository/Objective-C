//
//  MyTabBarController.m
//  TabBarController
//
//  Created by William on 2018/10/19.
//  Copyright © 2018年 William. All rights reserved.
//

#import "MyTabBarController.h"
#import "MyNavgationController.h"
#import "StudyViewController.h"
#import "MyUIViewController.h"
#import "SDKViewController.h"
#import "OtherViewController.h"

@interface UIImage (Extension)
// 快速的返回一个最原始的图片
+ (instancetype)imageWithOriRenderingImage:(NSString *)imageName;
@end

@interface MyTabBarController ()<UITabBarControllerDelegate>

/** 四个tabbar对应的动画图片数组 */
@property (strong, nonatomic) NSMutableArray <UIImage *>*homeImages;
@property (strong, nonatomic) NSMutableArray <UIImage *>*c2cImages;
@property (strong, nonatomic) NSMutableArray <UIImage *>*teamImages;
@property (strong, nonatomic) NSMutableArray <UIImage *>*mineImages;
/** 所有图片数组 */
@property (strong, nonatomic) NSMutableArray *allImages;
/** 当前的选中的tabbar按钮对应的图片 */
@property (strong, nonatomic) UIImageView *currentImageView;
/** 当前选中的tabbar下标 */
@property (assign, nonatomic) NSInteger currentIndex;

@end

@implementation MyTabBarController
// 动画图片个数
static NSInteger const ImageCount = 51;

- (void)dealloc {
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.currentIndex = 0;
    
    [self.allImages addObject:self.homeImages];
    [self.allImages addObject:self.c2cImages];
    [self.allImages addObject:self.teamImages];
    [self.allImages addObject:self.mineImages];
    
    // 设置代理监听tabBar的点击
    self.delegate = self;
    
    // 1.添加所有的子控制器
    [self addAllChildViewControllers];
}

#pragma mark - 1.添加所有的子控制器
- (void)addAllChildViewControllers
{
    // 1.1 首页
    [self addOneViewController:[[StudyViewController alloc] init] image:@"tab_home_normal" selectedImage:@"tab_home_50" title:@"language"];
    
    // 1.2 CTC
    [self addOneViewController:[[MyUIViewController alloc] init] image:@"tab_c2c_normal" selectedImage:@"tab_c2c_50" title:@"ui"];
    
    // 1.3 团队
    [self addOneViewController:[[SDKViewController alloc] init] image:@"tab_team_normal" selectedImage:@"tab_team_50" title:@"sdk"];
    
    // 1.4 我的
    [self addOneViewController:[[OtherViewController alloc] init] image:@"tab_mine_normal" selectedImage:@"tab_mine_50" title:@"other"];
}

#pragma mark - 1.1.添加一个子控制器的方法
- (void)addOneViewController:(UIViewController *)childViewController image:(NSString *)imageName selectedImage:(NSString *)selectedImageName title:(NSString *)title
{
    UINavigationController *nav = [[UINavigationController alloc] initWithRootViewController:childViewController];
    
    // 设置图片和文字之间的间距
    nav.tabBarItem.imageInsets = UIEdgeInsetsMake(-2, 0, 2, 0);
    nav.tabBarItem.titlePositionAdjustment = UIOffsetMake(0, -4);
    
    // 1.1.1 设置tabBar文字
    nav.tabBarItem.title = title;
    // 1.1.2 设置正常状态下的图标
    if (imageName.length) { // 图片名有具体
        nav.tabBarItem.image = [UIImage imageWithOriRenderingImage:imageName];
        // 1.1.3 设置选中状态下的图标
        nav.tabBarItem.selectedImage = [UIImage imageWithOriRenderingImage:selectedImageName];
    }
    
    // 1.1.5 添加tabBar为控制器的子控制器
    [self addChildViewController:nav];
}

- (BOOL)tabBarController:(UITabBarController *)tabBarController shouldSelectViewController:(UIViewController *)viewController {
#pragma tabBar上做动画的功能在Xcode11运行会出问题,等以后找到解决方法再做
    /*
    NSInteger index = [tabBarController.childViewControllers indexOfObject:viewController];
     
    //取到选中的tabBar 上的button
    UIButton *tabBarBtn = tabBarController.tabBar.subviews[index+1];
    //取到button上的imageView
    UIImageView *imageView = tabBarBtn.subviews.firstObject;
    // 切换过了,就停止上一个动画
    if (self.currentIndex != index) {
        // 把上一个图片的动画停止
        [self.currentImageView stopAnimating];
        // 把上一个图片的动画图片数组置为空
        self.currentImageView.animationImages = nil;
    } else {
        return NO;
    }
    
    imageView.animationImages = self.allImages[index];
    imageView.animationRepeatCount = 1;
    imageView.animationDuration = ImageCount * 0.025;
    
    // 开始动画
    [imageView startAnimating];
    
    // 记录当前选中的按钮的图片视图
    self.currentImageView = imageView;
    // 记录当前选中的下标
    self.currentIndex = index;
    */
    return YES;
}

#pragma mark - 2.设置tabBarItems的文字属性
+ (void)load
{
    // 2.0 设置TabBar的背景图片
    UITabBar *tabBarAppearance = [UITabBar appearance];
    [tabBarAppearance setShadowImage:[UIImage new]];
    [tabBarAppearance setBackgroundColor:[UIColor blackColor]];
    tabBarAppearance.translucent = NO;
    
    // 2.1 正常状态下的文字
    NSMutableDictionary *normalAttr = [NSMutableDictionary dictionary];
    normalAttr[NSForegroundColorAttributeName] = [UIColor colorWithRed:169 / 255.0 green:172 / 255.0 blue:174 / 255.0 alpha:1.0];
    normalAttr[NSFontAttributeName] = [UIFont systemFontOfSize:10];
    
    // 2.2 选中状态下的文字
    NSMutableDictionary *selectedAttr = [NSMutableDictionary dictionary];
    selectedAttr[NSForegroundColorAttributeName] = [UIColor colorWithRed:101 / 255.0 green:216 / 255.0 blue:255 / 255.0 alpha:1.0];
    selectedAttr[NSFontAttributeName] = [UIFont systemFontOfSize:10];
    
    // 2.3 统一设置UITabBarItem的文字属性
    UITabBarItem *item = [UITabBarItem appearance];
    // 2.3.1 设置UITabBarItem的正常状态下的文字属性
    [item setTitleTextAttributes:normalAttr forState:UIControlStateNormal];
    // 2.3.2 设置UITabBarItem的选中状态下的文字属性
    [item setTitleTextAttributes:selectedAttr forState:UIControlStateSelected];
}

#pragma mark - 懒加载
- (NSMutableArray *)allImages {
    if (!_allImages) {
        _allImages = [NSMutableArray array];
    }
    return _allImages;
}

- (NSMutableArray<UIImage *> *)homeImages {
    if (!_homeImages) {
        _homeImages = [self addImage:@"home"];
    }
    return _homeImages;
}

- (NSMutableArray<UIImage *> *)c2cImages {
    if (!_c2cImages) {
        _c2cImages = [self addImage:@"c2c"];
    }
    return _c2cImages;
}

- (NSMutableArray<UIImage *> *)teamImages {
    if (!_teamImages) {
        _teamImages = [self addImage:@"team"];
    }
    return _teamImages;
}

- (NSMutableArray<UIImage *> *)mineImages {
    if (!_mineImages) {
        _mineImages = [self addImage:@"mine"];
    }
    return _mineImages;
}

- (NSMutableArray <UIImage *>*)addImage:(NSString *)imageName
{
    NSMutableArray <UIImage *>*images = [NSMutableArray arrayWithCapacity:ImageCount];
    for (int i = 0; i < ImageCount; i++) {
        NSString *name = [NSString stringWithFormat:@"tab_%@_%02d", imageName, i];
        UIImage *img = [UIImage imageNamed:name];
        [images addObject:img];
    }
    return images;
}

@end

@implementation UIImage (Extension)

// 快速的返回一个最原始的图片
+ (instancetype)imageWithOriRenderingImage:(NSString *)imageName {
    UIImage *image = [UIImage imageNamed:imageName];
    return [image imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
}
@end
