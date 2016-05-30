//
//  ViewController.m
//  BBMenuList
//
//  Created by Biao on 16/5/30.
//  Copyright © 2016年 Biao. All rights reserved.
//

#import "ViewController.h"
#import "Header.h"
#import "AViewController.h"

@interface ViewController ()<UITableViewDataSource,UITableViewDelegate,UICollectionViewDataSource,UICollectionViewDelegate,UICollectionViewDelegateFlowLayout>
{
    NSMutableArray *_category_arr;
    UICollectionView *_collectionView;
    UITableView *_tableView;
    BOOL _isRelate;
}

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self.navigationItem setTitle:@"商品分类"];
    /** 设置导航栏标题内容颜色*/
    self.navigationController.navigationBar.titleTextAttributes = [NSDictionary dictionaryWithObjectsAndKeys:[UIColor whiteColor],NSForegroundColorAttributeName, nil];
    self.view.backgroundColor = [UIColor whiteColor];
    /**导航栏不透明*/
    self.navigationController.navigationBar.translucent = NO;
    /**导航栏背景颜色*/
    self.navigationController.navigationBar.barTintColor = BgColor;
    
    _category_arr = [NSMutableArray arrayWithObjects:@"古玩收藏",@"工艺一品",@"数码相机",@"男女饰品",@"品牌手表",@"男女包包",@"电脑手机",@"居家用品",@"运动休闲", nil];

    [self TableView];
    [self CollectionView];
}


#pragma mark  <UICollectionViewDelegate,UICollectionViewDataSource,UICollectionViewDelegateFlowLayout>
- (UICollectionView *)CollectionView
{
    if(!_collectionView)
    {
        UICollectionViewFlowLayout *layout = [[UICollectionViewFlowLayout alloc]init];
        /**初始化并设置布局*/
        _collectionView = [[UICollectionView alloc]initWithFrame:CGRectMake(WIDTH/4, 0, WIDTH*3/4, HEIGHT-64) collectionViewLayout:layout];
        _collectionView.backgroundColor = [UIColor whiteColor];
        /** 注册 */
        [_collectionView registerClass:[UICollectionViewCell class] forCellWithReuseIdentifier:@"collectionViewCell"];

        /**
         *  @author Biao
         *
         *  注册头部和尾部视图
         */
        [_collectionView registerClass:[UICollectionReusableView class] forSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:@"headerView"];
        [_collectionView registerClass:[UICollectionReusableView class] forSupplementaryViewOfKind:UICollectionElementKindSectionFooter withReuseIdentifier:@"footView"];
        _collectionView.dataSource = self;
        _collectionView.delegate = self;
        [self.view addSubview:_collectionView];
    }
    return _collectionView;
}

- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView
{
    return _category_arr.count;
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    return 13;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *collectionViewID = @"collectionViewCell";
    UICollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:collectionViewID forIndexPath:indexPath];
    cell.backgroundColor = [UIColor orangeColor];
    cell.layer.borderWidth = 1;
    cell.layer.borderColor = [UIColor whiteColor].CGColor;
    if(indexPath.item == 0)
    {
        for(UIView *view in cell.subviews)
        {
            [view removeFromSuperview];
        }
        
        UILabel *titleTextLable = [[UILabel alloc]initWithFrame:cell.frame];
        titleTextLable.textColor = [UIColor whiteColor];
        titleTextLable.text = _category_arr[indexPath.section];
        titleTextLable.backgroundColor = [UIColor redColor];
        cell.backgroundView = titleTextLable;
        cell.userInteractionEnabled = NO;
    }
    else
    {
        for (UIView *view in cell.subviews)
        {
            [view removeFromSuperview];
        }
        cell.userInteractionEnabled = YES;
    }
    
    return cell;
}



/**
 * 如果用头视图的方式进行相关联会出现,头视图的分类标题不能显示在可视范围,设置头视图的尺寸,如果想要使用头视图,则必须实现该方法
 */
- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout referenceSizeForHeaderInSection:(NSInteger)section
{
    /** 在此如果将头视图的尺寸设置为(0,0),则左侧的tableView的分类cel不会根据collectionView的滑动而滑动到相对应的分类的cell */
    return CGSizeMake(WIDTH*3/4, 1);
}


- (UICollectionReusableView *)collectionView:(UICollectionView *)collectionView viewForSupplementaryElementOfKind:(NSString *)kind atIndexPath:(NSIndexPath *)indexPath
{
    //根据类型以及标识获取注册过的头视图
    UICollectionReusableView *headerView = [collectionView dequeueReusableSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:@"headerView" forIndexPath:indexPath];
    headerView.backgroundColor = [UIColor whiteColor];
    
    for (UIView *view in headerView.subviews)
    {
        [view removeFromSuperview];
    }
    
    return headerView;
}


/**
 *  @author Biao
 *
 *  集合视图布局
 */
- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath
{
    //行 == 0
    if(indexPath.item == 0)
    {
        return  CGSizeMake(self.view.frame.size.width - WIDTH / 4, 40);
    }
    
    return CGSizeMake(self.view.frame.size.width / 4.0, self.view.frame.size.width / 4.0);
}

/**
 *  @author Biao
 *
 *  设置组距离上下左右的间距
 */
- (UIEdgeInsets)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout insetForSectionAtIndex:(NSInteger)section
{
    return UIEdgeInsetsMake(0, 0, 0, 0);
}

/**
 *  @author Biao
 *
 *  设置两个item的列间距
 */
- (CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout minimumInteritemSpacingForSectionAtIndex:(NSInteger)section
{
    return 0;
}


/**
 *  @author Biao
 *
 *  设置行间距
 */
- (CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout minimumLineSpacingForSectionAtIndex:(NSInteger)section
{
    return 0;
}

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath
{
    NSLog(@"%zi组, %zi组",indexPath.section,indexPath.item);
    AViewController *av = [AViewController new];
    self.hidesBottomBarWhenPushed = YES;
    [self.navigationController pushViewController:av animated:YES];
}

//讲显示视图
- (void)collectionView:(UICollectionView *)collectionView willDisplaySupplementaryView:(UICollectionReusableView *)view forElementKind:(NSString *)elementKind atIndexPath:(NSIndexPath *)indexPath
{
    if(_isRelate)
    {
        //获取当前显示的cell的下标
        NSInteger topCellSection = [[[collectionView indexPathsForVisibleItems]firstObject]section];
        if(collectionView == _collectionView)
        {
            [self.TableView selectRowAtIndexPath:[NSIndexPath indexPathForItem:topCellSection inSection:0] animated:YES scrollPosition:UITableViewScrollPositionMiddle];
        }
    }
}

/**
 *  @author Biao
 *
 *  将结束显示视图
 */
- (void)collectionView:(UICollectionView *)collectionView didEndDisplayingSupplementaryView:(UICollectionReusableView *)view forElementOfKind:(NSString *)elementKind atIndexPath:(NSIndexPath *)indexPath
{
    if(_isRelate)
    {
        //获取当前显示的cell的下标
        NSInteger itemSection = [[[collectionView indexPathsForVisibleItems]firstObject]section];
        if(collectionView == _collectionView)
        {
            //当CollectionView滑动时,tableView的cell自动选中相对应的分类
            [self.TableView selectRowAtIndexPath:[NSIndexPath indexPathForItem:itemSection inSection:0] animated:YES scrollPosition:UITableViewScrollPositionMiddle];
        }
    }
}

- (void)scrollViewDidEndDragging:(UIScrollView *)scrollView willDecelerate:(BOOL)decelerate
{
    _isRelate = YES;
}

#pragma mark - <UITableViewDataSource,UITableViewDelegate>

- (UITableView *)TableView
{
    if(!_tableView)
    {
        _tableView = [[UITableView alloc]initWithFrame:CGRectMake(0, 0, WIDTH/4, HEIGHT) style:UITableViewStylePlain];
        _tableView.delegate = self;
        _tableView.dataSource = self;
        _tableView.rowHeight = 40;
        /**设置滑动*/
        _tableView.scrollEnabled = YES;
        [self.view addSubview:_tableView];
    }
    return _tableView;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return _category_arr.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *tableViewID = @"tableViewCell";
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:tableViewID];
    if(!cell)
    {
        cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:tableViewID];
    }
    cell.backgroundColor = [UIColor clearColor];
    cell.textLabel.text = _category_arr[indexPath.row];
    cell.textLabel.font = [UIFont systemFontOfSize:15];
    
    /**
     *  @author Biao
     *
     *  选中背景视图
     */
    UIView *selectedBackgroundView = [[UIView alloc]initWithFrame:cell.frame];
    selectedBackgroundView.backgroundColor = [UIColor whiteColor];
    selectedBackgroundView.alpha = 0.8;
    
    /**
     *  @author Biao
     *
     *  点中的线
     */
    UILabel *lineLabel = [[UILabel alloc]initWithFrame:CGRectMake(0, 0, 5, 40)];
    lineLabel.backgroundColor = [UIColor redColor];
    [selectedBackgroundView addSubview:lineLabel];
    cell.selectedBackgroundView = selectedBackgroundView;
    
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    if(tableView == _tableView)
    {
        _isRelate = NO;
        [self.TableView selectRowAtIndexPath:indexPath animated:NO scrollPosition:UITableViewScrollPositionMiddle];
        
        /** 讲CollectionView 的滑动范围调整到tableView相对应的cell的内容*/
        [self.CollectionView scrollToItemAtIndexPath:[NSIndexPath indexPathForItem:0 inSection:indexPath.row] atScrollPosition:UICollectionViewScrollPositionTop animated:YES];
    }
}

@end
