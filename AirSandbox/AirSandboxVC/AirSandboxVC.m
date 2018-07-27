//
//  SKAirSandboxVC.m
//  SKAirSandboxVC
//
//  Created by shavekevin on 2018/7/27.
//  Copyright © 2018年 shavekevin. All rights reserved.
//

#import "AirSandboxVC.h"
#import "AirSandboxCell.h"
#import "AirSandboxModel.h"

static NSString *const  cellIdentifier = @"AirSandboxCellIdentifier";

@interface AirSandboxVC ()
<UITableViewDataSource,
UITableViewDelegate>

@property(nonatomic,strong) UITableView  *tableView;

@property (nonatomic, copy) NSArray *items;

@property (nonatomic, copy) NSString *rootPath;

@property (nonatomic, strong) UIButton *btnClose;


@end

@implementation AirSandboxVC

- (void)viewDidLoad {
    [super viewDidLoad];
    [self setupData];
    [self loadPath:nil];
   
}

- (void)setupData{
    _items = @[];
    _rootPath = NSHomeDirectory();
}

- (void)loadPath:(NSString*)filePath {
    
    NSMutableArray* files = @[].mutableCopy;
    NSFileManager* fileManager= [NSFileManager defaultManager];
    NSString* targetPath = filePath;
    if (targetPath.length == 0 || [targetPath isEqualToString:_rootPath]) {
        targetPath = _rootPath;
    } else {
        AirSandboxModel* file = [AirSandboxModel new];
        file.name = @"🔙..";
        file.type = eSKFileItemUp;
        file.path = filePath;
        [files addObject:file];
    }
    NSError* err = nil;
    NSArray* paths = [fileManager contentsOfDirectoryAtPath:targetPath error:&err];
    for (NSString* path in paths) {
        if ([[path lastPathComponent] hasPrefix:@"."]) {
            continue;
        }
        BOOL isDir = false;
        NSString* fullPath = [targetPath stringByAppendingPathComponent:path];
        [fileManager fileExistsAtPath:fullPath isDirectory:&isDir];
        AirSandboxModel* file = [AirSandboxModel new];
        file.path = fullPath;
        if (isDir) {
            file.type = eSKFileItemDirectory;
            file.name = [NSString stringWithFormat:@"%@ %@", @"📁", path];
        } else {
            file.type = eSKFileItemFile;
            file.name = [NSString stringWithFormat:@"%@ %@", @"📄", path];
        }
        [files addObject:file];
        
    }
    _items = files.copy;
    [self.tableView reloadData];
}
- (void)viewWillLayoutSubviews {
    
    [super viewWillLayoutSubviews];
    int viewWidth = [UIScreen mainScreen].bounds.size.width - 2*20;
    int closeWidth = 60;
    int closeHeight = 28;
    self.btnClose.frame = CGRectMake(viewWidth-closeWidth-4, 4, closeWidth, closeHeight);
    CGRect tableFrame = self.view.frame;
    tableFrame.origin.y += (closeHeight+4);
    tableFrame.size.height -= (closeHeight+4);
    self.tableView.frame = tableFrame;
}
#pragma mark- UITableViewDelegate
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return _items.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    if (indexPath.row > _items.count-1) {
        return [UITableViewCell new];
    }
    AirSandboxModel* item = [_items objectAtIndex:indexPath.row];
    AirSandboxCell* cell = [tableView dequeueReusableCellWithIdentifier:cellIdentifier];
    if (!cell) {
        cell = [[AirSandboxCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellIdentifier];
    }
    [cell renderCellWithItem:item];
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 48;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    if (indexPath.row > _items.count-1) {
        return;
    }
    [tableView deselectRowAtIndexPath:indexPath animated:false];
    AirSandboxModel* item = [_items objectAtIndex:indexPath.row];
    if (item.type == eSKFileItemUp) {
        [self loadPath:[item.path stringByDeletingLastPathComponent]];
    }
    else if(item.type == eSKFileItemFile) {
        [self sharePath:item.path];
    }
    else if(item.type == eSKFileItemDirectory) {
        [self loadPath:item.path];
    }
}

- (void)sharePath:(NSString*)path {
    NSURL *url = [NSURL fileURLWithPath:path];
    NSArray *objectsToShare = @[url];
    
    UIActivityViewController *controller = [[UIActivityViewController alloc] initWithActivityItems:objectsToShare applicationActivities:nil];
    NSArray *excludedActivities = @[UIActivityTypePostToTwitter, UIActivityTypePostToFacebook,
                                    UIActivityTypePostToWeibo,
                                    UIActivityTypeMessage, UIActivityTypeMail,
                                    UIActivityTypePrint, UIActivityTypeCopyToPasteboard,
                                    UIActivityTypeAssignToContact, UIActivityTypeSaveToCameraRoll,
                                    UIActivityTypeAddToReadingList, UIActivityTypePostToFlickr,
                                    UIActivityTypePostToVimeo, UIActivityTypePostToTencentWeibo];
    controller.excludedActivityTypes = excludedActivities;
    
    if ([(NSString *)[UIDevice currentDevice].model hasPrefix:@"iPad"]) {
        controller.popoverPresentationController.sourceView = self.view;
        controller.popoverPresentationController.sourceRect = CGRectMake([UIScreen mainScreen].bounds.size.width * 0.5, [UIScreen mainScreen].bounds.size.height, 10, 10);
    }
    [self presentViewController:controller animated:YES completion:nil];
}
- (void)btnCloseClick {
    self.view.window.hidden = YES;
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


- (UITableView *)tableView {
    if (!_tableView) {
        _tableView = [[UITableView alloc]initWithFrame:CGRectZero style:UITableViewStylePlain];
        _tableView.backgroundColor = [UIColor clearColor];
        _tableView.delegate = self;
        _tableView.dataSource = self;
        _tableView.separatorStyle = UITableViewCellSeparatorStyleSingleLine;
        _tableView.tableFooterView = [UIView new];
        [_tableView registerClass:[AirSandboxCell class] forCellReuseIdentifier:cellIdentifier];
        [self.view addSubview:_tableView];
    }
    return _tableView;
}
- (UIButton *)btnClose {
    if (!_btnClose) {
        _btnClose = [UIButton buttonWithType:UIButtonTypeCustom];
        _btnClose.backgroundColor = [UIColor blackColor];
        [_btnClose setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        [_btnClose setTitle:@"Close" forState:UIControlStateNormal];
        [_btnClose addTarget:self action:@selector(btnCloseClick) forControlEvents:UIControlEventTouchUpInside];
        [self.view addSubview:_btnClose];
    }
    return _btnClose;
}
@end
