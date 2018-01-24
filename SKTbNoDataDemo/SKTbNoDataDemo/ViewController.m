//
//  ViewController.m
//  SKTbNoDataDemo
//
//  Created by AY on 2018/1/24.
//  Copyright © 2018年 AY. All rights reserved.
//

#import "ViewController.h"
#define SCREEN_WIDTH   [UIScreen mainScreen].bounds.size.width
#define SCREEN_HEIGHT [UIScreen mainScreen].bounds.size.height
#import "LYEmptyViewHeader.h"

@interface ViewController ()<UITableViewDelegate,UITableViewDataSource>

/** 背景 tableview */
@property (nonatomic,strong)UITableView *mainTableView;
/** 默认的数据源 */
@property (nonatomic,strong)NSMutableArray *dataArray;
/** 无数据占位的视图 Holder View */
@property (nonatomic,strong)UIView *holderView;






@end

@implementation ViewController

// 自定义Holder 的视图
-(UIView *)holderView
{
	if (!_holderView) {
    	_holderView = [[UIView alloc]init];
		UILabel *lbl = [[UILabel alloc]init];
		lbl.text = @"暂无数据";
		lbl.textColor = [UIColor blackColor];
		_holderView.backgroundColor = [UIColor cyanColor];
		[_holderView addSubview:lbl];
		lbl.backgroundColor = [UIColor redColor];
		lbl.textAlignment = NSTextAlignmentCenter;
		lbl.frame = CGRectMake(_holderView.frame.origin.x - 50, _holderView.frame.size.height/2 - 25,100, 50);
	}
	return _holderView;
}

- (NSMutableArray *)dataArray
{
	if (!_dataArray) {
		_dataArray = [NSMutableArray arrayWithObjects:@"上海", nil];
		
	}
	return _dataArray;
}


- (void)viewDidLoad {
	[super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
	
	[self createMainTB];
}


- (void)createMainTB
{


    self.mainTableView = [[UITableView alloc]initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT - 44) style:UITableViewStylePlain];
    self.mainTableView.delegate = self;
    self.mainTableView.dataSource = self;
    self.mainTableView.bounces = NO;
//    self.mainTableView.separatorStyle = UITableViewCellSelectionStyleGray;
    self.mainTableView.showsVerticalScrollIndicator = NO;
	
	// self.mainTableView.backgroundColor = kMainColor;
    [self.view addSubview:self.mainTableView];
	self.mainTableView.separatorStyle = NO;
	// 使用demo的例子
//	self.mainTableView.ly_emptyView = [LYEmptyView emptyActionViewWithImageStr:@"noData" titleStr:@"暂无数据，点击重新加载" detailStr:@"暂无数据，点击重新加载" btnTitleStr:@"点击重试" btnClickBlock:^{
//		NSLog(@"Done");
//	}];
	
	self.mainTableView.ly_emptyView = [LYEmptyView emptyViewWithCustomView:self.holderView];

}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
	return self.dataArray.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *ID = @"cellID";
    UITableViewCell *cell = [tableView cellForRowAtIndexPath:indexPath];
    if (!cell) {
        cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:ID];
    }
	
	cell.selectionStyle = UITableViewCellSelectionStyleNone;
	cell.textLabel.text = [NSString stringWithFormat:@"%@ --左滑删除 显示占位图",self.dataArray[indexPath.row]];
	return cell;

}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
	return 60;
}

// 编辑的方法
- (NSArray<UITableViewRowAction *> *)tableView:(UITableView *)tableView editActionsForRowAtIndexPath:(NSIndexPath *)indexPath
{


	
	// 添加一个删除的按钮
	UITableViewRowAction *deleteAction = [UITableViewRowAction rowActionWithStyle:UITableViewRowActionStyleDestructive title:@"删除" handler:^(UITableViewRowAction * _Nonnull action, NSIndexPath * _Nonnull indexPath) {
		// 做对应的操作
		
		[self.dataArray removeObjectAtIndex:indexPath.row];
		[self.mainTableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationAutomatic];
		
	}];
	// 设置颜色
	deleteAction.backgroundColor = [UIColor redColor];
	
	// 添加一个标记未读按钮
	UITableViewRowAction *unreadAction = [UITableViewRowAction rowActionWithStyle:UITableViewRowActionStyleDefault title:@"标记未读" handler:^(UITableViewRowAction * _Nonnull action, NSIndexPath * _Nonnull indexPath) {
		
		UIAlertView *alert = [[UIAlertView alloc]initWithTitle:@"show" message:@"标记未读" delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil];
		[alert show];
		
	}];
	
	unreadAction.backgroundColor = [UIColor blueColor];
	return @[deleteAction,unreadAction];
	
	
}

- (void)didReceiveMemoryWarning {
	[super didReceiveMemoryWarning];
	// Dispose of any resources that can be recreated.
}


@end
