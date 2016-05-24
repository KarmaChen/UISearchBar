//
//  ViewController.m
//  UISearchBar
//
//  Created by Karma on 16/5/24.
//  Copyright © 2016年 陈昆涛. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    //1.创建
    UISearchBar *searchBar = [[UISearchBar alloc]initWithFrame:CGRectMake(0, 20, self.view.bounds.size.width-30,50)];
    
    //2.设置属性
    //默认风格 白色搜索框，	多出的背景为灰色
    searchBar.barStyle = UIBarStyleDefault;
    //设置搜索框整体的风格为不显示背景,默认为Prominent显示
    searchBar.searchBarStyle = UISearchBarStyleMinimal;
    //设置搜索框的文字
    searchBar.text = @"搜索框";
    //显示在searchBar顶部的一行文字，基本不会用到
//    searchBar.prompt = @"prompt";
    //当输入框没有内容时候显示的文字
    searchBar.placeholder = @"请输入文字";
    //是否在搜索框右侧显示一个图书的按钮，默认为NO
    searchBar.showsBookmarkButton = YES;
    //是否显示取消按钮，默认为NO;
    searchBar.showsCancelButton = YES;
    //是否显示搜索结果按钮，默认为NO,与bookmarkButton只能存在一个
    // searchBar.showsSearchResultsButton = YES;
    //设置搜索框中的光标的颜色为黄色
    searchBar.tintColor = [UIColor yellowColor];
    //设置搜索框的背景颜色
    searchBar.barTintColor = [UIColor redColor];
    //设置是否半透明
    searchBar.translucent = YES;
    
    //3.searchBar输入框及其输入文字位置的调整
    //调整搜索框field的位置，其他searchbar上面其他控件位置不发生改变
    searchBar.searchFieldBackgroundPositionAdjustment = UIOffsetMake(0,0);
    //field里面的文字在field中的位置调整
    searchBar.searchTextPositionAdjustment = UIOffsetMake(50, 0);
    //4.自定义搜索图标
    //自定义搜索框放大镜的图标
    [searchBar setImage:[UIImage imageNamed:@"2"] forSearchBarIcon:UISearchBarIconSearch state:UIControlStateNormal];
    //Bookmark图标的设置
    [searchBar setImage:[UIImage imageNamed:@"2"] forSearchBarIcon:UISearchBarIconBookmark state:UIControlStateNormal];
    
    
    
    [self.view addSubview:searchBar];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
