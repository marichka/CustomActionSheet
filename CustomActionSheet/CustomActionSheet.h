//
//  CustomActionSheet.h
//  AlertAndActionSheet
//
//  Created by Mariya Kholod on 4/15/13.
//  Copyright (c) 2013 Mariya Kholod. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface CustomActionSheet : UIView <UITableViewDelegate, UITableViewDataSource>
{
    NSArray *TableButtons;
    
    UITableView *ActionSheetTableView;
    
    id delegate;
    
    UIImage *ButtonImg;
    UILabel *TitleLbl;
}
@property id delegate;

- (id)initWithFrame:(CGRect)frame title:(NSString*)title buttons:(NSArray*)buttons delegate:(id)customActionSheetDelegate;

@end

@protocol CustomActionSheetDelegate
- (void)customActionSheet:(CustomActionSheet*)actionSheet clickedButtonAtIndex:(NSInteger)buttonIndex;
@end
