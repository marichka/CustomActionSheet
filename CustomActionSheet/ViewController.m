//
//  ViewController.m
//  CustomActionSheet
//
//  Created by Mariya Kholod on 4/29/13.
//  Copyright (c) 2013 Mariya Kholod. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)customActionSheet:(CustomActionSheet*)actionSheet clickedButtonAtIndex:(NSInteger)buttonIndex
{
    switch (buttonIndex) {
        case -1://cancel
            break;
        case 0://Red
            self.view.backgroundColor = [UIColor colorWithRed:0.99 green:0.66 blue:0.65 alpha:1.0];
            break;
        case 1://Green
            self.view.backgroundColor = [UIColor colorWithRed:0.8 green:1.0 blue:0.69 alpha:1.0];
            break;
        case 2://Blue
            self.view.backgroundColor = [UIColor colorWithRed:0.82 green:0.9 blue:1.0 alpha:1.0];
            break;
        case 3://Orange
            self.view.backgroundColor = [UIColor colorWithRed:1.0 green:0.81 blue:0.62 alpha:1.0];
            break;
        default:
            break;
    }
}

- (void)onActionSheetBtnPressed
{
    CustomActionSheet *actionSheet = [[CustomActionSheet alloc] initWithFrame:self.view.bounds title:@"Set background color:" buttons:[NSArray arrayWithObjects:@"Red", @"Green", @"Blue", @"Orange"/*, @"Purple"*/, nil] delegate:self];
    [self.view addSubview:actionSheet];
}

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
    UIButton *ActionSheetBtn = [UIButton buttonWithType:UIButtonTypeRoundedRect];
    ActionSheetBtn.frame = CGRectMake((int)((self.view.frame.size.width-200.0)/2.0), 240.0, 200.0, 50.0);
    [ActionSheetBtn setTitle:@"Show Action Sheet" forState:UIControlStateNormal];
    [ActionSheetBtn addTarget:self action:@selector(onActionSheetBtnPressed) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:ActionSheetBtn];
    ActionSheetBtn.autoresizingMask = UIViewAutoresizingFlexibleLeftMargin | UIViewAutoresizingFlexibleRightMargin | UIViewAutoresizingFlexibleTopMargin | UIViewAutoresizingFlexibleBottomMargin;

}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
