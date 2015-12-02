//
//  BTBreadcrumbView.m
//  BTFloatingMenu
//
//  Created by Meiwin Fu on 13/1/13.
//  Copyright (c) 2013 BlockThirty. All rights reserved.
//

#import "BTBreadcrumbView.h"
#import <QuartzCore/QuartzCore.h>

#define kAnimationDuration 0.5

#define kShadowOpacity   0.0
#define kShadowOffset    CGSizeMake(1, 2)
#define kShadowRadius    2.5
#define kShadowColor     [UIColor blackColor].CGColor

#define mSetShadow(_view) \
CALayer *layer = [_view layer]; \
layer.shadowOffset = kShadowOffset; \
layer.shadowOpacity = kShadowOpacity; \
layer.shadowRadius = kShadowRadius; \
layer.shadowColor = kShadowColor

#define mRGBA(_red,_green,_blue,_alpha) \
[UIColor colorWithRed:(_red/255.0) green:(_green/255.0) blue:(_blue/255.0) alpha:_alpha]

#define mRect(_w,_h) CGRectMake(0,0,_w,_h)

////////////////////////////////////////////////////////////////////////////////
////////////////////////////////////////////////////////////////////////////////
////////////////////////////////////////////////////////////////////////////////
@implementation BTBreadcrumbItem
@synthesize title = _title;
@end

////////////////////////////////////////////////////////////////////////////////
////////////////////////////////////////////////////////////////////////////////
////////////////////////////////////////////////////////////////////////////////
@interface BTBreadcrumbView (Private)
- (UIButton *)startButton;
- (UIButton *)itemButton:(BTBreadcrumbItem *)item;
- (void)didTapStartButton;
- (void)didTapItemAtIndex:(NSUInteger)index;
- (void)tapStartButton:(id)sender;
- (void)tapItemButton:(id)sender;
@end

#define kStartButtonWidth 0
#define kBreadcrumbHeight 44
@implementation BTBreadcrumbView
@synthesize items = _items;
@synthesize delegate = _delegate;

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
        self.backgroundColor = [UIColor whiteColor];
        self.autoresizesSubviews = YES;
        mSetShadow(self);
        
        _containerView = [[UIView alloc] initWithFrame:self.bounds];
        _containerView.autoresizingMask = UIViewAutoresizingFlexibleHeight|UIViewAutoresizingFlexibleWidth;
        _containerView.backgroundColor = [UIColor colorWithRed:58.0/255.0 green:2.0/255.0 blue:86.0/255.0 alpha:1.0];
        _containerView.clipsToBounds = YES;
        [self addSubview:_containerView];
        
        // Create fixed subviews
        //_startButton = [self startButton];
        //[_containerView addSubview:_startButton];
    }
    return self;
}

- (CGSize)sizeThatFits:(CGSize)size
{
    CGFloat total_width = kStartButtonWidth;
    for (UIView *itemView in _itemViews) {
        total_width += itemView.bounds.size.width;
    }
    if (_itemViews.count > 0)
    {
        UIButton *lastButton = [_itemViews lastObject];
        if (lastButton.titleEdgeInsets.right > 10)
        {
            total_width -= 12;
        }
    }
    return CGSizeMake(total_width, kBreadcrumbHeight);
}

#pragma mark Private
- (UIButton *)startButton
{
    UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
    button.contentMode = UIViewContentModeLeft;
    [button setBackgroundImage:[UIImage imageNamed:@"button_start.png"] forState:UIControlStateNormal];
    button.frame = mRect(kStartButtonWidth+1, kBreadcrumbHeight);
    [button addTarget:self action:@selector(tapStartButton:) forControlEvents:UIControlEventTouchUpInside];
    return button;
}

- (UIButton *)itemButton:(BTBreadcrumbItem *)item
{
    UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
    button.contentMode = UIViewContentModeLeft;
    button.titleLabel.font = [UIFont boldSystemFontOfSize:14];
    [button setTitle:item.title forState:UIControlStateNormal];
    //[button setTitleColor:mRGBA(77, 77, 77, 1) forState:UIControlStateNormal];
    [button setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [button setTitleColor: [UIColor whiteColor] forState:UIControlStateHighlighted];
    
    //UIImage *bgImage = [[UIImage imageNamed:@"button_item.png"] stretchableImageWithLeftCapWidth:1 topCapHeight:0];
    //[button setBackgroundImage:bgImage forState:UIControlStateNormal];
    //[button setBackgroundImage:bgImage forState:UIControlStateHighlighted];
    [button setBackgroundColor:[UIColor colorWithRed:58.0/255.0 green:2.0/255.0 blue:86.0/255.0 alpha:1.0]];
    button.titleEdgeInsets = UIEdgeInsetsMake(0, 5, 0, 5);
    
    
    [button sizeToFit];
    CGSize s = button.bounds.size;
    button.frame = CGRectMake(0, 0, s.width+10, kBreadcrumbHeight);
    [button addTarget:self action:@selector(tapItemButton:) forControlEvents:UIControlEventTouchUpInside];
    
    return button;
}

- (void)didTapStartButton
{
    if (_delegate && [(id)_delegate respondsToSelector:@selector(breadcrumbViewDidTapStartButton:)])
    {
        [_delegate breadcrumbViewDidTapStartButton:self];
    }
}
- (void)didTapItemAtIndex:(NSUInteger)index
{
    if (_delegate && [(id)_delegate respondsToSelector:@selector(breadcrumbView:didTapItemAtIndex:)])
    {
        [_delegate breadcrumbView:self didTapItemAtIndex:index];
    }
}

- (void)tapStartButton:(id)sender
{
    [self didTapStartButton];
}
- (void)tapItemButton:(id)sender
{
    [self didTapItemAtIndex:[_itemViews indexOfObject:sender]];
}

#pragma mark Layout
- (void)layoutSubviews
{
    [super layoutSubviews];
    
    CGFloat cx = kStartButtonWidth;
    for (UIView *view in _itemViews)
    {
        CGSize s = view.bounds.size;
        view.frame = CGRectMake(cx, 0, s.width, s.height);
        cx += s.width;
    }
}

#pragma mark Public
- (void)setItems:(NSArray *)items
{
    if (_animating) return;
    
    // remove existings
    for (UIView *view in _itemViews) {
        [view removeFromSuperview];
    }
    
    // add all
    _itemViews = [NSMutableArray arrayWithCapacity:0];
    _items = items;
    int i = 0;
    for (BTBreadcrumbItem *item in _items) {
        UIButton *itemButton = [self itemButton:item];
        [_containerView insertSubview:itemButton atIndex:0];
        [_itemViews addObject:itemButton];
        i++;
    }
    [self sizeToFit];
    [self setNeedsLayout];
}

- (void)updateButton:(UIButton *)button setLastItem:(BOOL)isLastItem
{
	
    CGPoint o = button.frame.origin;
    CGSize s = button.frame.size;
    CGFloat w = s.width;
	//NSLog(@"Updating button.  Frame was %f->%f", o.x, w);
    if (isLastItem)
    {
        if (button.currentBackgroundImage != nil)
        {
            button.titleEdgeInsets = UIEdgeInsetsMake(0, 5, 0, 5);
            //[button setBackgroundImage:nil forState:UIControlStateNormal];
            //[button setBackgroundImage:nil forState:UIControlStateHighlighted];
            button.backgroundColor = [UIColor colorWithRed:58.0/255.0 green:2.0/255.0 blue:86.0/255.0 alpha:1.0];
            w = s.width-12;
        }
    }
    else
    {
        if (button.currentBackgroundImage == nil)
        {
            button.titleEdgeInsets = UIEdgeInsetsMake(0, 5, 0, 5);
            //UIImage *bgImage = [[UIImage imageNamed:@"button_item.png"] stretchableImageWithLeftCapWidth:1 topCapHeight:0];
            //[button setBackgroundImage:bgImage forState:UIControlStateNormal];
            //[button setBackgroundImage:bgImage forState:UIControlStateHighlighted];
            button.backgroundColor = [UIColor colorWithRed:58.0/255.0 green:2.0/255.0 blue:86.0/255.0 alpha:1.0];
            w = s.width/*+12*/;
        }
    }
	//NSLog(@"Frame is now %f->%f", self.bounds.size.width-w, w);
    button.frame  = CGRectMake(self.bounds.size.width-w, o.y, w, s.height);
}

- (void)setItems:(NSArray *)items animated:(BOOL)animated
{
    if (_animating) return;
    
    if (animated)
    {
        // retract existings
        NSArray *oldItems = _items;
        _items = items;
        
        int oldCount = oldItems.count;
        int newCount = _items.count;
        
        int removeStartIndex = 0;
        for (int i = 0; i < oldCount; i++)
        {
            if (i < newCount)
            {
                BTBreadcrumbItem *oldItem = [oldItems objectAtIndex:i];
                BTBreadcrumbItem *newItem = [_items objectAtIndex:i];
                if (![newItem.title isEqual:oldItem.title])
                {
                    break;
                }
            }
            else
            {
                break;
            }
            removeStartIndex++;
        }
        
        NSArray *oldItemViews = _itemViews;
        _itemViews = [NSMutableArray arrayWithCapacity:0];
        for (int i = 0; i < removeStartIndex; i++)
        {
            [_itemViews addObject:[oldItemViews objectAtIndex:i]];
        }
        
        // retract first
        [UIView animateWithDuration:0.2 animations:^{
            
            _animating = YES;
            
            [self sizeToFit];
            
            // right bound
            for (int i = removeStartIndex; i < oldCount; i++)
            {
                UIButton *oldView = [oldItemViews objectAtIndex:i];
                CGSize s = oldView.bounds.size;
                oldView.frame = CGRectMake(self.bounds.size.width-s.width, 0, s.width, s.height);
            }
            
            if (removeStartIndex < newCount)
            {
                if (removeStartIndex > 0)
                {
                    UIButton *button = [_itemViews objectAtIndex:removeStartIndex-1];
					//NSLog(@"Update button with title %@", [[_itemViews objectAtIndex:removeStartIndex-1] title]);
                    [self updateButton:button setLastItem:NO];
                }
            }
            
            [self sizeToFit];
            
        } completion:^(BOOL finished) {
            
            for (int i = removeStartIndex; i < oldCount; i++)
            {
                UIView *oldView = [oldItemViews objectAtIndex:i];
                [oldView removeFromSuperview];
            }
            
            // adding new item
            if (removeStartIndex < newCount)
            {
                for (int i = removeStartIndex; i < newCount; i++)
                {
                    BTBreadcrumbItem *item = [_items objectAtIndex:i];
                    UIView *newView = [self itemButton:item];
                    CGSize s = newView.bounds.size;
                    newView.frame = CGRectMake(self.bounds.size.width-s.width, 0, s.width, s.height);
                    [_containerView insertSubview:newView atIndex:0];
                    [_itemViews addObject:newView];
                }
                if (newCount > 0)
                {
                    UIButton *lastButton = [_itemViews objectAtIndex:newCount-1];
					//NSLog(@"Update last button with title %@", [[_itemViews objectAtIndex:newCount-1] title]);
                    [self updateButton:lastButton setLastItem:YES];
                }
            }
            
            // animate them
            [UIView animateWithDuration:0.2 animations:^{
                [self sizeToFit];
                [self layoutSubviews];
            } completion:^(BOOL finished) {
                _animating = NO;
            }];
            
        }];
        
    }
    else
    {
        [self setItems:items];
    }
}
@end

