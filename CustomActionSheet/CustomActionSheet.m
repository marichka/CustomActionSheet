//
//  CustomActionSheet.m
//  AlertAndActionSheet
//
//  Created by Mariya Kholod on 4/15/13.
//  Copyright (c) 2013 Mariya Kholod. All rights reserved.
//

#import "CustomActionSheet.h"
#define MAX_HEIGHT 300.0

@implementation CustomActionSheet

@synthesize delegate;

- (id)initWithFrame:(CGRect)frame title:(NSString*)title buttons:(NSArray*)buttons delegate:(id)customActionSheetDelegate
{
    self = [super initWithFrame:frame];
    if (self) {
        delegate = customActionSheetDelegate;
        TableButtons = [[NSArray alloc] initWithArray:buttons];
        
        ButtonImg = [UIImage imageNamed:@"button.png"];
        
        self.alpha = 0.0;
        self.backgroundColor = [UIColor colorWithRed:0.0 green:0.0 blue:0.0 alpha:0.6];
        self.autoresizingMask = UIViewAutoresizingFlexibleHeight | UIViewAutoresizingFlexibleWidth;
        
        UIImage *ActionSheetBg = [UIImage imageNamed:@"action_bg.png"];
        
        if ([ActionSheetBg respondsToSelector:@selector(resizableImageWithCapInsets:)])
            ActionSheetBg = [[UIImage imageNamed: @"action_bg.png"] resizableImageWithCapInsets:UIEdgeInsetsMake(40.0, 25.0, 25.0, 25.0)];
        else
            ActionSheetBg = [[UIImage imageNamed: @"action_bg.png"] stretchableImageWithLeftCapWidth: 25 topCapHeight: 40];
        
        
        UIImageView *BgImgView = [[UIImageView alloc] initWithImage:ActionSheetBg];
        
        TitleLbl = [[UILabel alloc] initWithFrame:CGRectMake(0.0, 0.0, BgImgView.frame.size.width-20.0, 0.0)];
        TitleLbl.backgroundColor = [UIColor clearColor];
        TitleLbl.font = [UIFont boldSystemFontOfSize:18.0];
        TitleLbl.textColor = [UIColor whiteColor];
        TitleLbl.numberOfLines = 0;
        TitleLbl.textAlignment = UITextAlignmentCenter;
        TitleLbl.text = title;
        [TitleLbl sizeToFit];
        
        TitleLbl.frame = CGRectMake(0.0, 0.0, BgImgView.frame.size.width-20.0, TitleLbl.frame.size.height+20.0);
        
        BOOL ShouldAllowScroll = NO;
        
        float view_height = (ButtonImg.size.height+10)*[TableButtons count]+TitleLbl.frame.size.height+20.0;
        
        if (view_height>MAX_HEIGHT)
        {
            ShouldAllowScroll = YES;
            view_height = MAX_HEIGHT;
        }
        
        UIView *bgView = [[UIView alloc] initWithFrame:CGRectMake((int)((self.frame.size.width-BgImgView.frame.size.width)/2.0), (int)((self.frame.size.height-view_height)/2.0), BgImgView.frame.size.width, view_height)];
        bgView.autoresizingMask = UIViewAutoresizingFlexibleLeftMargin | UIViewAutoresizingFlexibleRightMargin | UIViewAutoresizingFlexibleTopMargin | UIViewAutoresizingFlexibleBottomMargin;
        bgView.backgroundColor = [UIColor clearColor];
        [self addSubview:bgView];
        
        
        BgImgView.frame = bgView.bounds;
        
        [bgView addSubview:BgImgView];
        
        ActionSheetTableView = [[UITableView alloc] initWithFrame:CGRectMake(10.0, 5.0, BgImgView.frame.size.width-20.0, view_height-20.0) style:UITableViewStylePlain];
        ActionSheetTableView.delegate = self;
        ActionSheetTableView.dataSource = self;
        ActionSheetTableView.scrollEnabled = ShouldAllowScroll;
        ActionSheetTableView.backgroundColor = [UIColor clearColor];
        ActionSheetTableView.separatorStyle = UITableViewCellSeparatorStyleNone;
        ActionSheetTableView.rowHeight = ButtonImg.size.height+10;
        [bgView addSubview:ActionSheetTableView];

        [self ShowViewAnimated];

    }
    return self;
}

-(void)ShowViewAnimated
{
    self.alpha = 0.0;
    [UIView beginAnimations:nil context:nil];
    [UIView setAnimationDuration:0.1];
    self.alpha = 0.95;
    [UIView commitAnimations];
}

- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event
{
    [delegate customActionSheet:self clickedButtonAtIndex:-1];
    [self removeFromSuperview];
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    // Return the number of sections.
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    // Return the number of rows in the section.
    return [TableButtons count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSString *CellIdentifier = [NSString stringWithFormat:@"row%dsection%d", indexPath.row, indexPath.section];
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if (cell == nil)
    {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;

        UIImageView *bgImgView = [[UIImageView alloc] initWithImage:ButtonImg];
        bgImgView.autoresizingMask = UIViewAutoresizingFlexibleLeftMargin | UIViewAutoresizingFlexibleRightMargin | UIViewAutoresizingFlexibleTopMargin | UIViewAutoresizingFlexibleBottomMargin;
        bgImgView.center = cell.center;
        [cell addSubview:bgImgView];
        
        UILabel *CellTitleLbl = [[UILabel alloc] initWithFrame:bgImgView.bounds];
        CellTitleLbl.backgroundColor = [UIColor clearColor];
        CellTitleLbl.text = [TableButtons objectAtIndex:indexPath.row];
        CellTitleLbl.font = [UIFont boldSystemFontOfSize:18.0];
        CellTitleLbl.textColor = [UIColor whiteColor];
        CellTitleLbl.textAlignment = UITextAlignmentCenter;
        CellTitleLbl.adjustsFontSizeToFitWidth = YES;
        [bgImgView addSubview:CellTitleLbl];
    }
    
    return cell;
}

#pragma mark - Table view delegate

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    return TitleLbl.frame.size.height;
}
- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    return TitleLbl;
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    [delegate customActionSheet:self clickedButtonAtIndex:indexPath.row];
    [self removeFromSuperview];
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect
{
    // Drawing code
}
*/

@end
