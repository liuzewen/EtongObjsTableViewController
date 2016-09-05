//
//  EtongObjsTableViewController.m
//  
//
//  Created by 刘泽文 on 15/12/18.
//  Copyright © 2015年 刘泽文. All rights reserved.
//

#import "EtongObjsTableViewController.h"
#import "MJRefresh.h"

@implementation EtongObjsTableViewController

-(instancetype)init{
    self=[super init];
    if (self) {
        _page=1;
        _currentRequestMode=RefreshNomalMode;
        _serverDataOjects=[[NSMutableArray alloc] init];
        _serverAllDataObjects=[[NSMutableArray alloc] init];
    }
    return self;
}
- (void)viewDidLoad{
    [super viewDidLoad];
    self.tableView.tableFooterView=[[UIView alloc]init];
    [self setTableViewHeaderRefresh];
    [self requestServerData:NO];
    [self addEmptyView];
}

- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    if (_needAutoRefresh) {
        [self refresh];
    }
}
- (void)setTableViewHeaderRefresh{
    if (_needHeadRefresh) {
        self.tableView.mj_header =({
            MJRefreshNormalHeader *header = [MJRefreshNormalHeader headerWithRefreshingTarget:self refreshingAction:@selector(refresh)];
            header.lastUpdatedTimeLabel.hidden = NO;
            header.stateLabel.hidden = NO;
            // 设置颜色
            header.stateLabel.textColor = [UIColor lightGrayColor];
            header.lastUpdatedTimeLabel.textColor = [UIColor lightGrayColor];
            header;
        });
         //马上进入刷新状态
        [self.tableView.mj_header beginRefreshing];
    }
    if (_needFootRefresh) {
        self.tableView.mj_footer=({
            self.tableView.mj_footer =({
                MJRefreshAutoNormalFooter * footer= [MJRefreshAutoNormalFooter footerWithRefreshingTarget:self refreshingAction:@selector(loadFootData)];
                footer.stateLabel.textColor=[UIColor lightGrayColor];
                footer;
            });
        });
    }
}
#pragma mark 重写set
- (void)setServerAllDataObjects:(NSMutableArray *)serverDataOjects{
    if (_currentRequestMode==RefreshFootMode) {
        [_serverAllDataObjects addObjectsFromArray:(NSArray*)serverDataOjects];
        
    }else {
        _serverAllDataObjects=serverDataOjects;
        if (self.pageCount>self.serverDataOjects.count) {
            [self.tableView.mj_footer endRefreshingWithNoMoreData];
        }
    }

}
#pragma mark  刷新
- (void)refresh{
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
        _currentRequestMode=RefreshHeadMode;
        [self requestServerData:NO];
    });
    if (self.anotherNetWorking){
        self.anotherNetWorking();
    }
}
#pragma mark 刷新底部
- (void)loadFootData{
    if (self.pageCount<self.serverDataOjects.count) {
        _currentRequestMode=RefreshFootMode;
    }
    [self requestServerData:NO];
}
#pragma mark 请求服务器端数据源
- (void)requestServerData:(BOOL)isCache{
    if (self.requestServerData) {
        self.requestServerData(isCache);
    }
}
#pragma mark tableViewReload方法
-(void)reloadTableView{
    dispatch_async(dispatch_get_main_queue(), ^{
        if (self.tableView.mj_header.isRefreshing) {
            [self.tableView.mj_header endRefreshing];
        }
        
        if (self.pageCount>self.serverDataOjects.count) {
            if (self.tableView.mj_footer.isRefreshing) {
                [self.tableView.mj_footer endRefreshingWithNoMoreData];
            }

        }else{
            if (self.tableView.mj_footer.isRefreshing) {
                [self.tableView.mj_footer endRefreshing];
            }
        }
        [self.tableView reloadData];
    });
}
-(void)addEmptyView{
    if (!_emptyView) {
        _emptyView=[[UIView alloc]initWithFrame:self.view.frame];
        UIImageView *imgView=[[UIImageView alloc]initWithFrame:CGRectMake(10,100, self.view.frame.size.width-20,  (self.view.frame.size.width-20)*224/467)];
        imgView.image=[UIImage imageNamed:@"EmptyViewImage"];
        _emptyView.hidden=YES;
        [_emptyView addSubview:imgView];
        [self.view addSubview:_emptyView];
    }
}
-(void)emptyViewHidden{
    if (self.serverAllDataObjects.count!=0) {
        _emptyView.hidden=YES;
    }else{
        _emptyView.hidden=NO;
    }
}
@end
