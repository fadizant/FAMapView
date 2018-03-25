//
//  FAMapViewController.m
//  FAMapView
//
//  Created by Fadi Abuzant on 3/24/18.
//

#import "FAMapViewController.h"

@interface FAMapViewController ()

@end

@implementation FAMapViewController

#pragma mark - init
- (instancetype)initUserLocationWithDragable:(BOOL)isDragable updateCoordinate:(updateCoordinate)coordinate{
    _updateCoordinate = coordinate;
    return [self initUserLocationWithDragable:isDragable];
}

- (instancetype)initUserLocationWithDragable:(BOOL)isDragable updateCoordinateWithAddress:(updateCoordinateWithAddress)coordinateWithAddress{
    _updateCoordinateWithAddress = coordinateWithAddress;
    return [self initUserLocationWithDragable:isDragable];
}

- (instancetype)initUserLocationWithDragable:(BOOL)isDragable updateCoordinateWithPlacemark:(updateCoordinateWithPlacemark)coordinateWithPlacemark{
    _updateCoordinateWithPlacemark = coordinateWithPlacemark;
    return [self initUserLocationWithDragable:isDragable];
}

- (instancetype)initUserLocationWithDragable:(BOOL)isDragable
{
    self = [self init];
    if (self) {
        _pinInUserLocation = YES;
        _dragable = isDragable;
    }
    return self;
}

- (instancetype)initWithCoordinate:(CLLocationCoordinate2D)coordinate Dragable:(BOOL)isDragable updateCoordinate:(updateCoordinate)updateCoordinate{
    updateCoordinate = updateCoordinate;
    return [self initWithCoordinate:coordinate Dragable:isDragable];
}

- (instancetype)initWithCoordinate:(CLLocationCoordinate2D)coordinate Dragable:(BOOL)isDragable updateCoordinateWithAddress:(updateCoordinateWithAddress)coordinateWithAddress{
    _updateCoordinateWithAddress = coordinateWithAddress;
    return [self initWithCoordinate:coordinate Dragable:isDragable];
}

- (instancetype)initWithCoordinate:(CLLocationCoordinate2D)coordinate Dragable:(BOOL)isDragable updateCoordinateWithPlacemark:(updateCoordinateWithPlacemark)coordinateWithPlacemark{
    _updateCoordinateWithPlacemark = coordinateWithPlacemark;
    return [self initWithCoordinate:coordinate Dragable:isDragable];
}

- (instancetype)initWithCoordinate:(CLLocationCoordinate2D)coordinate Dragable:(BOOL)isDragable
{
    self = [self init];
    if (self) {
        _pinInUserLocation = NO;
        _dragable = isDragable;
        _latitudeCoordinate = coordinate.latitude;
        _longitudeCoordinate = coordinate.longitude;
    }
    return self;
}

- (instancetype)init
{
    self = [super initWithNibName:@"FAMapViewController" bundle:[NSBundle bundleForClass:[FAMapViewController class]]];
    if (self) {
    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    //set values
    _mapView.pinInUserLocation = _pinInUserLocation;
    _mapView.dragable = _dragable;
    _mapView.latitudeCoordinate = _latitudeCoordinate;
    _mapView.longitudeCoordinate = _longitudeCoordinate;
    
    // closure
    _mapView.updateCoordinate = _updateCoordinate;
    _mapView.updateCoordinateWithAddress = _updateCoordinateWithAddress;
    _mapView.updateCoordinateWithPlacemark = _updateCoordinateWithPlacemark;

}

-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    //add close botton if view in top of navigation controller
    if (self.navigationController &&
        [self.navigationController.viewControllers.firstObject isEqual:self] &&
        !self.navigationController.navigationBar.topItem.leftBarButtonItem &&
        !self.navigationController.navigationBar.topItem.leftBarButtonItems &&
        !self.navigationController.navigationBar.topItem.rightBarButtonItem &&
        !self.navigationController.navigationBar.topItem.rightBarButtonItems) {
        UIBarButtonItem* closeBtn = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemStop target:self action:@selector(onTapClose:)];
        self.navigationController.navigationBar.topItem.leftBarButtonItem = closeBtn;
    }
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)onTapClose:(UIBarButtonItem*)item{
    [self.navigationController dismissViewControllerAnimated:YES completion:nil];
}

@end
