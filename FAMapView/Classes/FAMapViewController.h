//
//  FAMapViewController.h
//  FAMapView
//
//  Created by Fadi Abuzant on 3/24/18.
//

#import <UIKit/UIKit.h>
#import "FAMap.h"

@interface FAMapViewController : UIViewController{
    BOOL _pinInUserLocation;
    BOOL _dragable;
    double _latitudeCoordinate;
    double _longitudeCoordinate;
    
    // closure
    updateCoordinate _updateCoordinate;
    updateCoordinateWithAddress _updateCoordinateWithAddress;
    updateCoordinateWithPlacemark _updateCoordinateWithPlacemark;
}

#pragma mark - Property
@property (weak, nonatomic) IBOutlet FAMap *mapView;

#pragma mark - init
- (instancetype)initUserLocationWithDragable:(BOOL)isDragable updateCoordinate:(updateCoordinate)coordinate
NS_SWIFT_NAME(init(userLocationCWithisDragable:coordinate:));

- (instancetype)initUserLocationWithDragable:(BOOL)isDragable updateCoordinateWithAddress:(updateCoordinateWithAddress)coordinateWithAddress
NS_SWIFT_NAME(init(userLocationCAWithisDragable:coordinateWithAddress:));

- (instancetype)initUserLocationWithDragable:(BOOL)isDragable updateCoordinateWithPlacemark:(updateCoordinateWithPlacemark)coordinateWithPlacemark
NS_SWIFT_NAME(init(userLocationCPWithisDragable:coordinateWithPlacemark:));

- (instancetype)initUserLocationWithDragable:(BOOL)isDragable
NS_SWIFT_NAME(init(userLocationWithisDragable:));

- (instancetype)initWithCoordinate:(CLLocationCoordinate2D)coordinate Dragable:(BOOL)isDragable updateCoordinate:(updateCoordinate)updateCoordinate
NS_SWIFT_NAME(init(customLocationCWithCoordinate:isDragable:withUpdateCoordinate:));

- (instancetype)initWithCoordinate:(CLLocationCoordinate2D)coordinate Dragable:(BOOL)isDragable updateCoordinateWithAddress:(updateCoordinateWithAddress)coordinateWithAddress
NS_SWIFT_NAME(init(customLocationCAWithCoordinate:isDragable:coordinateWithAddress:));

- (instancetype)initWithCoordinate:(CLLocationCoordinate2D)coordinate Dragable:(BOOL)isDragable updateCoordinateWithPlacemark:(updateCoordinateWithPlacemark)coordinateWithPlacemark
NS_SWIFT_NAME(init(customLocationCPWithCoordinate:isDragable:coordinateWithPlacemark:));

- (instancetype)initWithCoordinate:(CLLocationCoordinate2D)coordinate Dragable:(BOOL)isDragable
NS_SWIFT_NAME(init(customLocationWithCoordinate:isDragable:));

- (instancetype)init;
@end
