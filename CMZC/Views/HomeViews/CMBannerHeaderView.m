//
//  CMBannerHeaderView.m
//  CMZC
//
//  Created by 财猫 on 16/3/2.
//  Copyright © 2016年 郑浩然. All rights reserved.
//

#import "CMBannerHeaderView.h"
#import "CMBanners.h"


@interface CMBannerHeaderView ()  <UIScrollViewDelegate>

@property (nonatomic, strong) UIScrollView *scrollView;//滑动师徒
@property (strong, nonatomic) UIPageControl *pageControl;//选项

@property (nonatomic, assign) CGFloat width;//记录宽度
@property (nonatomic, assign) CGFloat height;//高度
@property (strong, nonatomic) NSTimer *pageTimer;//定时器

@end



@implementation CMBannerHeaderView
- (instancetype)init
{
    self = [super init];
    if (self) {
        _banners = [NSArray array];
        _width = [UIScreen mainScreen].bounds.size.width;
        _height = 160;
        self.frame = CGRectMake(0.0, 0.0, _width, _height);
        _scrollView = [[UIScrollView alloc] init];
        _scrollView.pagingEnabled = YES;
        _scrollView.showsHorizontalScrollIndicator = NO;
        _scrollView.showsVerticalScrollIndicator = NO;
        _scrollView.bounces = NO;
        _scrollView.backgroundColor = [UIColor cmBackgroundGrey];
        _scrollView.frame = CGRectMake(0.0, 0.0, _width, _height);
        _scrollView.delegate = self;
        [self addSubview:_scrollView];
    }
    return self;
}

+ (CMBannerHeaderView *)bannerHeaderViewWithBanners:(NSArray *)banners {
    CMBannerHeaderView *headerView = [[CMBannerHeaderView alloc] init];
    headerView.banners = banners;
    return headerView;
}

- (void)setBanners:(NSArray *)banners {
    _banners = banners;
    
   // _pageTimer = [NSTimer scheduledTimerWithTimeInterval:2 target:self selector:@selector(changeBanner) userInfo:nil repeats:YES];
    
    [self configureBannerHeaderView];
}

- (void)configureBannerHeaderView {
    
    _scrollView.contentSize = CGSizeMake(_width * _banners.count, _height);
    
    //_scrollView.translatesAutoresizingMaskIntoConstraints = NO;
    //[self addConstraintsToContentView];
    
    _pageControl = [[UIPageControl alloc] initWithFrame:CGRectMake(_width/2-10, 135, 20, 10)];
    _pageControl.hidden = YES;
    _pageControl.backgroundColor = [UIColor grayColor];
    _pageControl.numberOfPages = _banners.count;
    [self addSubview:_pageControl];
    
    for (NSInteger i = 0; i < _banners.count; i++) {
        UIImageView *imageView = [[UIImageView alloc] init];
        imageView.frame = CGRectMake(i*_width, 0, _width, _height);
        if (i == 1) {
            imageView.backgroundColor = [UIColor redColor];
        } else {
            imageView.backgroundColor = [UIColor yellowColor];
        }
        CMBanners *banner = _banners[i];
        UIImage *placeholder = [UIImage imageNamed:@"title_log"];
        [imageView sd_setImageWithURL:[NSURL URLWithString:banner.pictureurl] placeholderImage:placeholder];
        imageView.userInteractionEnabled = YES;
        imageView.contentMode = UIViewContentModeScaleAspectFill;
        UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tapImageView:)];
        [imageView addGestureRecognizer:tap];
        imageView.tag = i;
        [_scrollView addSubview:imageView];
        //imageView.translatesAutoresizingMaskIntoConstraints = NO;
        //[self addConstraintsWithView:imageView contentView:_scrollView index:i];
    }
}

- (void)tapImageView:(UITapGestureRecognizer *)recognizer {
    
    CMBanners *banners = _banners[recognizer.view.tag];
    
    if (self.didSelectedBlack) {
        self.didSelectedBlack(banners.link);
    }
}

- (void)restartScrollBanner {
    if (!_pageTimer.isValid) {
        _pageTimer = [NSTimer scheduledTimerWithTimeInterval:4 target:self selector:@selector(changeBanner) userInfo:nil repeats:YES];
    }
}

- (void)stopScrollBanner {
    if (_pageTimer.isValid) {
        [_pageTimer invalidate];
    }
    _pageControl.currentPage = 0;
    _scrollView.contentOffset = CGPointMake(0, _scrollView.contentOffset.y);
}

-(void)changeBanner {
    if (_banners && _banners.count > 1) {
        if (_pageControl.currentPage < (_banners.count-1)) {
            _pageControl.currentPage++;
        }else{
            _pageControl.currentPage = 0;
        }
        [_scrollView setContentOffset:CGPointMake(_width*_pageControl.currentPage, 0) animated:YES];
        //NSLog(@"changeBanner page = %ld", (long)_pageControl.currentPage);
    }
}

#pragma mark - scrollview delegate
- (void)scrollViewDidScroll:(UIScrollView *)scrollView {
    CGFloat pageWidth = scrollView.frame.size.width;
    int page = floor((scrollView.contentOffset.x - pageWidth / 2) / pageWidth) + 1;
    if ((int)scrollView.contentOffset.x % (int)scrollView.frame.size.width == 0) {
        _pageControl.currentPage = page;
    }
}
/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
