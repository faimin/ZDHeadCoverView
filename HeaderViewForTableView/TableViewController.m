//
//  TableViewController.m
//  HeaderViewForTableView
//
//  Created by 符现超 on 15/12/14.
//  Copyright © 2015年 Fate.D.Bourne. All rights reserved.
//

#import "TableViewController.h"
//#import <Masonry.h>

#define KSCREENWIDTH	([[UIScreen mainScreen] bounds].size.width)
#define KSCREENHEIGHT	([[UIScreen mainScreen] bounds].size.height)
#define DEFAULTHEIGHT	(KSCREENWIDTH * 0.8)

@interface TableViewController () <UIScrollViewDelegate /*, UITableViewDelegate, UITableViewDataSource*/>

@property (weak, nonatomic) IBOutlet UITableView *tableView;
@property (weak, nonatomic) IBOutlet UIView *headerView;
@property (nonatomic, strong) UIImageView *topImageView;

@property (nonatomic, assign) CGFloat imageViewHeight;

@end

@implementation TableViewController

#pragma mark - LifeCycle

- (void)viewDidLoad
{
	[super viewDidLoad];
	// Do any additional setup after loading the view.

	self.imageViewHeight = DEFAULTHEIGHT;

	[self buildUI];
}

- (void)didReceiveMemoryWarning
{
	[super didReceiveMemoryWarning];
	// Dispose of any resources that can be recreated.
}

- (void)buildUI
{
	self.tableView.contentInset = UIEdgeInsetsMake(self.imageViewHeight, 0, 0, 0);
	self.topImageView = ({
		UIImageView *imageView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"tiger"]];
		imageView.frame = (CGRect) {0, -DEFAULTHEIGHT, KSCREENWIDTH, DEFAULTHEIGHT};
		imageView.backgroundColor = [UIColor magentaColor];
		imageView.clipsToBounds = YES;
		[self.tableView addSubview:imageView];
		imageView;
	});
}

#pragma mark - UITableViewDataSource && UITableViewDelegate

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
	return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
	return 100;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
	static NSString *CellIdentifier = @"cellIdentifier";
	UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];

	if (!cell) {
		cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier];
		cell.selectionStyle = UITableViewCellSelectionStyleNone;
	}
	return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
	return UITableViewAutomaticDimension;
}

#pragma mark - Core Method

- (void)scrollViewDidScroll:(UIScrollView *)scrollView
{
	CGFloat contentOffsetY = scrollView.contentOffset.y;
	CGFloat realH = DEFAULTHEIGHT;
	//NSLog(@"\n偏移量 = %f", contentOffsetY);
	if (contentOffsetY < -realH) { // 下拉
		CGRect f = self.topImageView.frame;
		f.origin.y = contentOffsetY;
		f.size.height = -contentOffsetY;
		self.topImageView.frame = f;
	}
}

#pragma mark - PrivateMethod

- (IBAction)changeHeight:(id)sender
{
    CGRect frame = self.headerView.frame;
    frame.size.height += 50;
    self.headerView.frame = frame;
    self.tableView.tableHeaderView = self.headerView;
    
}

- (IBAction)deleteH:(id)sender
{
    CGRect frame = self.headerView.frame;
    frame.size.height -= 50;
    self.headerView.frame = frame;
    self.tableView.tableHeaderView = self.headerView;
}


/*
 * #pragma mark - Navigation
 *
 *  // In a storyboard-based application, you will often want to do a little preparation before navigation
 *  - (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
 *   // Get the new view controller using [segue destinationViewController].
 *   // Pass the selected object to the new view controller.
 *  }
 */

@end
