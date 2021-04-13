//
//  HYBaseViewController.m
//  ObjcProjectTemplate
//
//  Created by 臻尚 on 2021/3/22.
//

#import "HYBaseViewController.h"
#import "Masonry.h"
#import "UIViewController+HYNavigation.h"

@interface HYBaseViewController ()

#pragma mark - scrollView
// 滚动视图
@property (nonatomic, strong) UIScrollView *scrollView;

// scrollView内部背景视图，控制scrollView的contentSize
// 注:scrollContentView的高度没有添加约束，需要在内部添加子视图的时候设置约束把scrollContentView撑起来
@property (nonatomic, strong) UIView *scrollContentView;

#pragma mark - 导航栏相关
// viewWillAppear记录导航栏状态 viewWillDisappear恢复，防止影响其他控制器显示
@property (nonatomic, assign) BOOL navOriginHiddenState;

@end

@implementation HYBaseViewController

#pragma mark - 控制器生命周期
- (void)viewDidLoad {
    [super viewDidLoad];
    
    // 子视图设置
    [self setupSubviews];
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    
    // 记录导航栏的显示状态
    self.navOriginHiddenState = self.navigationController.navigationBarHidden;
    
    // 去掉导航栏下面自带的线条
    self.navigationController.navigationBar.shadowImage = [[UIImage alloc] init];
}

- (void)viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:animated];
    
    // 恢复导航栏进入该页面时的显示状态
    self.navigationController.navigationBarHidden = self.navOriginHiddenState;
}

#pragma mark - 设置子视图
// 子视图设置
- (void)setupSubviews
{
    // 默认白色view
    self.view.backgroundColor = [UIColor whiteColor];
    

    // 设置返回按钮
    self.navigationItem.backBarButtonItem = self.backButtonItem;
//    self.navigationItem.backBarButtonItem = self.backButtonItem;
//    if (self.navigationController) {
//        if (self.navigationController.viewControllers.count > 1) {
//            [self.navigationItem setLeftBarButtonItem:self.backButtonItem];
//        }
//    }
    
    // 导航栏状态设置
    self.navigationController.navigationBarHidden = self.navBarHidden;
}

// 添加scroll(需要的时候主动调用)
- (void)addScrollView
{
    [self.view addSubview:self.scrollView];
    [self.scrollView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.bottom.right.equalTo(self.view);
        make.top.equalTo(self.view);
    }];
    [self.scrollView addSubview:self.scrollContentView];
    [self.scrollContentView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(self.scrollView);
        make.width.mas_equalTo(self.scrollView);
    }];
}

#pragma mark - 事件
// 返回
- (void)backAction
{
    [self.navigationController popViewControllerAnimated:YES];
}

#pragma mark - setter
// 设置导航栏显示状态
- (void)setNavBarHidden:(BOOL)navBarHidden
{
    _navBarHidden = navBarHidden;
    self.navigationController.navigationBarHidden = navBarHidden;
}

#pragma mark - 其他


/**
 如果是表单类型控制器，提交前需校验所有内容是否都填写完成
 * 哪一项内容没有填写,返回提示用户填写该项信息的文本,否则返回 nil
 */
- (NSString *)checkBeforeCommit
{
    return nil;
}

#pragma mark - 懒加载
// 滚动视图
- (UIScrollView *)scrollView
{
    if (!_scrollView) {
        _scrollView = [[UIScrollView alloc]init];
    }
    return _scrollView;
}

// scrollView内部背景视图，控制scrollView的contentSize
- (UIView *)scrollContentView
{
    if (!_scrollContentView) {
        _scrollContentView = UIView.new;
    }
    return _scrollContentView;
}


@end
