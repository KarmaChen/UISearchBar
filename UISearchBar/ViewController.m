//
//  ViewController.m
//  UISearchBar
//
//  Created by Karma on 16/5/24.
//  Copyright © 2016年 陈昆涛. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()<UISearchBarDelegate,UITableViewDataSource,UITableViewDelegate>
@property (nonatomic,strong) UISearchBar *searchBar;
@property (nonatomic,strong) NSMutableArray *dataList;//原始数据
@property (nonatomic,strong) NSMutableArray *searchList;//显示数据
@property (nonatomic,strong) UITableView *myTableView;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    //设置代理
    self.searchBar.delegate=self;
    
}
-(UISearchBar *)searchBar{
    if (!_searchBar) {
        //1.创建
        _searchBar = [[UISearchBar alloc]initWithFrame:CGRectMake(0, 20, self.view.bounds.size.width,50)];
        
        //2.设置属性
        //默认风格 白色搜索框，	多出的背景为灰色
        _searchBar.barStyle = UIBarStyleDefault;
        //设置搜索框整体的风格为不显示背景,默认为Prominent显示
        _searchBar.searchBarStyle = UISearchBarStyleMinimal;
        //设置默认搜索框的文字
//        _searchBar.text = @"搜索框";
        //显示在searchBar顶部的一行文字，基本不会用到
        //    searchBar.prompt = @"prompt";
        //当输入框没有内容时候显示的文字
        _searchBar.placeholder = @"请输入文字";
        //是否在搜索框右侧显示一个图书的按钮，默认为NO
        _searchBar.showsBookmarkButton = YES;
        //是否显示取消按钮，默认为NO;
        _searchBar.showsCancelButton = YES;
        //是否显示搜索结果按钮，默认为NO,与bookmarkButton只能存在一个
        // searchBar.showsSearchResultsButton = YES;
        //设置搜索框中的光标的颜色为黄色
        _searchBar.tintColor = [UIColor yellowColor];
        //设置搜索框的背景颜色
        _searchBar.barTintColor = [UIColor redColor];
        //设置是否半透明
        _searchBar.translucent = YES;
        
        //3.searchBar输入框及其输入文字位置的调整
        //调整搜索框field的位置，其他searchbar上面其他控件位置不发生改变
        _searchBar.searchFieldBackgroundPositionAdjustment = UIOffsetMake(0,0);
        //field里面的文字在field中的位置调整
        _searchBar.searchTextPositionAdjustment = UIOffsetMake(50, 0);
        //4.自定义搜索图标
        //自定义搜索框放大镜的图标
        [_searchBar setImage:[UIImage imageNamed:@"2"] forSearchBarIcon:UISearchBarIconSearch state:UIControlStateNormal];
        //Bookmark图标的设置
        [_searchBar setImage:[UIImage imageNamed:@"2"] forSearchBarIcon:UISearchBarIconBookmark state:UIControlStateNormal];
        [self.view addSubview:_searchBar];

    }
    return _searchBar;
}
//创建一个tableview
- (UITableView *)myTableView{
    
    if (!_myTableView) {
        _myTableView = [[UITableView alloc] init];
        _myTableView.frame = CGRectMake(0, 70, 377, self.view.bounds.size.height-70);
        _myTableView.dataSource = self;
        _myTableView.delegate = self;
        [self.view addSubview:_myTableView];
        
    }
    return _myTableView;
}

//模拟数据
- (NSMutableArray *)dataList{
    
    if (!_dataList) {
        _dataList = [NSMutableArray arrayWithCapacity:100];//容量
        for (NSInteger i=0; i<100; i++) {
            [_dataList addObject:[NSString stringWithFormat:@"%ld",(long)i]];
        }
    }
    return _dataList;
}

- (NSMutableArray *)searchList{
    if (!_searchList) {
        _searchList = [NSMutableArray array];
    }
    return _searchList;
}


#pragma mark --UISearchDelegate
//当搜索框将要开始使用时调用。yes表示搜索框可以使用，默认为yes否则搜索框无法使用
- (BOOL)searchBarShouldBeginEditing:(UISearchBar *)searchBar{
    NSLog(@"ShouldBegin");
    return YES;
}
//当搜索框开始编辑时候调用
- (void)searchBarTextDidBeginEditing:(UISearchBar *)searchBar{
    NSLog(@"DidBegin");
    
}
//当搜索框将要将要结束使用时调用。
- (BOOL)searchBarShouldEndEditing:(UISearchBar *)searchBar{
    NSLog(@"ShouldEnd");
    
    return YES;
}
//当搜索框结束编辑时候调用
- (void)searchBarTextDidEndEditing:(UISearchBar *)searchBar{
    NSLog(@"DidEnd");
}

//当field里面内容改变时候就开始掉用。
- (void)searchBar:(UISearchBar *)searchBar textDidChange:(NSString *)searchText{
    /*
     思路:
     当searchtext为空时,直接显示datalist的数据
     不为空时,通过tempStr匹配datalist 的数据 添加到searchlist数组中
     */
    if (searchText!=nil && searchText.length>0) {
        //需要清空searchList数组否则原来的数据会一直存在
        self.searchList = [NSMutableArray array];
        for (NSString *tempStr in self.dataList)
        {
            if ([tempStr rangeOfString:searchText options:NSCaseInsensitiveSearch].length >0 )
            {
                [self.searchList addObject:tempStr];
                NSLog(@"%ld",[self.searchList count]);
            }
            
        }
        [self.myTableView reloadData];
    }
    else
    {
        self.searchList = [NSMutableArray arrayWithArray:self.dataList];
        [self.myTableView reloadData];
    }

    
}
//在field里面输入时掉用，询问是否允许输入，yes表示允许，默认为yes，否则无法输入
- (BOOL)searchBar:(UISearchBar *)searchBar shouldChangeTextInRange:(NSRange)range replacementText:(NSString *)text {
    NSLog(@"shouldChange");
    return YES;
}
//点击SearchButton调用
- (void)searchBarSearchButtonClicked:(UISearchBar *)searchBar{
    NSLog(@"SearchButtonClicked");
}
//点击BookmarkButton调用
- (void)searchBarBookmarkButtonClicked:(UISearchBar *)searchBar {
    NSLog(@"BookmarkButtonClicked");
    
}
//点击CancelButton调用
- (void)searchBarCancelButtonClicked:(UISearchBar *)searchBar {
    NSLog(@"CancelButton");
}
//点击ResultsListButton调用
- (void)searchBarResultsListButtonClicked:(UISearchBar *)searchBar{
    NSLog(@"ResultsListButton");
}
#pragma mark --UITableViewDelegate
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
   return [self.searchList count] > 0 ? [self.searchList count] : 0;
}
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 1;
}


-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    static NSString *tableIdentifier = @"cell";
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:tableIdentifier];
    
    if (cell == nil) {
        
        cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:tableIdentifier];
    }
    if (self.searchList != nil && self.searchList.count > 0) {
        NSInteger row = [indexPath row];
        cell.textLabel.text = [self.searchList objectAtIndex:row];
    }else{

    }
    return cell;
    
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
