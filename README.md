
------
###效果图
![](https://github.com/faimin/ZDHeadCoverView/blob/master/show.gif)

**主要方法**
------

```objc
#pragma mark - Core Method

- (void)scrollViewDidScroll:(UIScrollView *)scrollView
{
	CGFloat contentOffsetY = scrollView.contentOffset.y;
	CGFloat realH = DEFAULTHEIGHT;
	if (contentOffsetY < -realH) { // 下拉
		CGRect f = self.topImageView.frame;
		f.origin.y = contentOffsetY;
		f.size.height = -contentOffsetY;
		self.topImageView.frame = f;
	}
}
```
