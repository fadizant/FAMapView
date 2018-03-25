//
//  FAMap.h
//  FAMapView
//
//  Created by Fadi Abuzant on 3/24/18.
//

#import <UIKit/UIKit.h>
#import <MapKit/MapKit.h>
#import <CoreLocation/CoreLocation.h>

// closure

typedef void (^updateCoordinate)(CLLocationCoordinate2D coordinate);

typedef void (^updateCoordinateWithAddress)(CLLocationCoordinate2D coordinate,NSString* address);

typedef void (^updateCoordinateWithPlacemark)(CLLocationCoordinate2D coordinate,CLPlacemark *placemark);

IB_DESIGNABLE
@interface FAMap : MKMapView<MKMapViewDelegate,CLLocationManagerDelegate>

#pragma mark - Property
@property (nonatomic) IBInspectable BOOL pinInUserLocation;
@property (nonatomic) IBInspectable BOOL dragable;
@property (nonatomic) IBInspectable double latitudeCoordinate;
@property (nonatomic) IBInspectable double longitudeCoordinate;

@property (nonatomic,retain) CLLocationManager *locationManager;
@property (nonatomic,retain) CLLocation *pinLocation;
@property (nonatomic,retain) CLGeocoder *geocoder;
@property (nonatomic,retain) CLPlacemark *placemark;
@property (nonatomic,retain) NSString *address;

// closure
@property (nonatomic) updateCoordinate updateCoordinate;
@property (nonatomic) updateCoordinateWithAddress updateCoordinateWithAddress;
@property (nonatomic) updateCoordinateWithPlacemark updateCoordinateWithPlacemark;

#pragma mark - init
- (instancetype)initUserLocationWithDragable:(BOOL)isDragable updateCoordinate:(updateCoordinate)coordinate;

- (instancetype)initUserLocationWithDragable:(BOOL)isDragable updateCcoordinateWithAddress:(updateCoordinateWithAddress)coordinateWithAddress;

- (instancetype)initUserLocationWithDragable:(BOOL)isDragable updateCcoordinateWithPlacemark:(updateCoordinateWithPlacemark)coordinateWithPlacemark;

- (instancetype)initUserLocationWithDragable:(BOOL)isDragable;

- (instancetype)initWithCoordinate:(CLLocationCoordinate2D)coordinate Dragable:(BOOL)isDragable updateCoordinate:(updateCoordinate)updateCoordinate;

- (instancetype)initWithCoordinate:(CLLocationCoordinate2D)coordinate Dragable:(BOOL)isDragable updateCcoordinateWithAddress:(updateCoordinateWithAddress)coordinateWithAddress;

- (instancetype)initWithCoordinate:(CLLocationCoordinate2D)coordinate Dragable:(BOOL)isDragable updateCcoordinateWithPlacemark:(updateCoordinateWithPlacemark)coordinateWithPlacemark;

- (instancetype)initWithCoordinate:(CLLocationCoordinate2D)coordinate Dragable:(BOOL)isDragable;

@end
