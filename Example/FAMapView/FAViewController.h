//
//  FAViewController.h
//  FAMapView
//
//  Created by fadizant on 03/24/2018.
//  Copyright (c) 2018 fadizant. All rights reserved.
//

@import UIKit;
#import "FAMapView.h"

@interface FAViewController : UIViewController
@property (weak, nonatomic) IBOutlet FAMap *mapView;
@property (weak, nonatomic) IBOutlet UILabel *addressLabel;

@end
