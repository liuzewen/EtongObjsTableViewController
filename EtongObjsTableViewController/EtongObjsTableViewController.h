//
//  EtongObjsTableViewController.h
//  
//
//  Created by liuzewen on 15/12/18.
//  Copyright © 2015年 刘泽文. All rights reserved.
//

#import <UIKit/UIKit.h>
/**刷新模式*/
typedef  NS_ENUM(NSInteger,RefreshMode){
    /**Nomal*/
    RefreshNomalMode=0,
    /**head刷新*/
    RefreshHeadMode,
    /**foot刷新*/
    RefreshFootMode
};
@interface EtongObjsTableViewController : UITableViewController

@property (nonatomic,strong) NSMutableArray *serverDataOjects;
@property (nonatomic,strong) NSMutableArray *serverAllDataObjects;
@property (nonatomic,assign) BOOL needAutoRefresh;
@property (nonatomic,assign) BOOL needHeadRefresh;
@property (nonatomic,assign) BOOL needFootRefresh;

@property (nonatomic,assign) NSUInteger page;
@property (nonatomic,assign) NSUInteger pageCount;

@property (nonatomic,assign) NSUInteger currentRequestMode;
@property (nonatomic,strong) UIView     *emptyView;

@property (nonatomic,copy) void(^requestServerData)(BOOL isCache);
@property (nonatomic,copy) void(^anotherNetWorking)();

- (void)reloadTableView;
- (void)emptyViewHidden;
@end
