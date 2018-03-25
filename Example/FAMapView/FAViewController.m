//
//  FAViewController.m
//  FAMapView
//
//  Created by fadizant on 03/24/2018.
//  Copyright (c) 2018 fadizant. All rights reserved.
//

#import "FAViewController.h"

@interface FAViewController ()

@end

@implementation FAViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.

}

-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    
    _mapView.updateCoordinate = ^(CLLocationCoordinate2D coordinate) {
        NSLog(@"Coordinate = %f:%f",coordinate.latitude,coordinate.longitude);
    };
    
    _mapView.updateCoordinateWithAddress = ^(CLLocationCoordinate2D coordinate, NSString *address) {
        self.title = address;
        NSLog(@"Address = %@",address);
    };
    
    _mapView.updateCoordinateWithPlacemark = ^(CLLocationCoordinate2D coordinate, CLPlacemark *placemark) {
        NSLog(@"Country = %@ , City = %@",placemark.country,placemark.locality);
    };
    
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)showMap:(UIButton *)sender {
    
//    FAMapViewController *mapView = [[FAMapViewController alloc]initUserLocationWithDragable:YES updateCoordinate:^(CLLocationCoordinate2D coordinate) {
//        NSLog(@"Coordinate = %f:%f",coordinate.latitude,coordinate.longitude);
//    }];
    
    FAMapViewController *mapView = [[FAMapViewController alloc]initUserLocationWithDragable:YES updateCoordinateWithAddress:^(CLLocationCoordinate2D coordinate, NSString *address) {
        _addressLabel.text = address;
        NSLog(@"Address = %@",address);
    }];
    
//    FAMapViewController *mapView = [[FAMapViewController alloc]initUserLocationWithDragable:YES updateCoordinateWithPlacemark:^(CLLocationCoordinate2D coordinate, CLPlacemark *placemark) {
//        NSLog(@"Country = %@ , City = %@",placemark.country,placemark.locality);
//    }];
    
    
    UINavigationController *nav = [[UINavigationController alloc]initWithRootViewController:mapView];
    nav.title = @"pik location";
    [self presentViewController:nav animated:YES completion:nil];
}

@end
