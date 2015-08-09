//
//  DetailViewController.h
//  Greebler
//
//  Created by Adrian on 8/9/15.
//  Copyright (c) 2015 Adrian Secord. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface DetailViewController : UIViewController

@property (strong, nonatomic) id detailItem;
@property (weak, nonatomic) IBOutlet UILabel *detailDescriptionLabel;

@end

