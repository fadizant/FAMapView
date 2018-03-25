//
//  FAMap.m
//  FAMapView
//
//  Created by Fadi Abuzant on 3/24/18.
//

#import "FAMap.h"
#import "UIAlertController+FAMapAlertController.h"

@implementation FAMap

#pragma mark - init
- (instancetype)initUserLocationWithDragable:(BOOL)isDragable updateCoordinate:(updateCoordinate)coordinate{
    _updateCoordinate = coordinate;
    return [self initUserLocationWithDragable:isDragable];
}

- (instancetype)initUserLocationWithDragable:(BOOL)isDragable updateCcoordinateWithAddress:(updateCoordinateWithAddress)coordinateWithAddress{
    _updateCoordinateWithAddress = coordinateWithAddress;
    return [self initUserLocationWithDragable:isDragable];
}

- (instancetype)initUserLocationWithDragable:(BOOL)isDragable updateCcoordinateWithPlacemark:(updateCoordinateWithPlacemark)coordinateWithPlacemark{
    _updateCoordinateWithPlacemark = coordinateWithPlacemark;
    return [self initUserLocationWithDragable:isDragable];
}

- (instancetype)initUserLocationWithDragable:(BOOL)isDragable
{
    self = [super init];
    if (self) {
        _pinInUserLocation = YES;
        _dragable = isDragable;
    }
    return self;
}

- (instancetype)initWithCoordinate:(CLLocationCoordinate2D)coordinate Dragable:(BOOL)isDragable updateCoordinate:(updateCoordinate)updateCoordinate{
    _updateCoordinate = updateCoordinate;
    return [self initWithCoordinate:coordinate Dragable:isDragable];
}

- (instancetype)initWithCoordinate:(CLLocationCoordinate2D)coordinate Dragable:(BOOL)isDragable updateCcoordinateWithAddress:(updateCoordinateWithAddress)coordinateWithAddress{
    _updateCoordinateWithAddress = coordinateWithAddress;
    return [self initWithCoordinate:coordinate Dragable:isDragable];
}

- (instancetype)initWithCoordinate:(CLLocationCoordinate2D)coordinate Dragable:(BOOL)isDragable updateCcoordinateWithPlacemark:(updateCoordinateWithPlacemark)coordinateWithPlacemark{
    _updateCoordinateWithPlacemark = coordinateWithPlacemark;
    return [self initWithCoordinate:coordinate Dragable:isDragable];
}

- (instancetype)initWithCoordinate:(CLLocationCoordinate2D)coordinate Dragable:(BOOL)isDragable
{
    self = [super init];
    if (self) {
        _pinInUserLocation = NO;
        _dragable = isDragable;
    }
    return self;
}

- (void)drawRect:(CGRect)rect{
    [super drawRect:rect];
    
    self.delegate = self;
    if (_pinInUserLocation && !_locationManager) {
        //check if user turn on GPS
        if ([CLLocationManager locationServicesEnabled]){
            if ([CLLocationManager authorizationStatus]==kCLAuthorizationStatusDenied){
                UIAlertController *alert = [UIAlertController alertControllerWithTitle:NSLocalizedString(@"Location permission denied", @"") message:NSLocalizedString(@"To re-enable, please go to Settings and turn on Location Service for this app.", @"") preferredStyle:UIAlertControllerStyleAlert];
                [alert addAction: [UIAlertAction actionWithTitle:NSLocalizedString(@"Cancel", @"") style:UIAlertActionStyleDestructive handler:^(UIAlertAction * _Nonnull action) {
                    
                }]];
                [alert addAction: [UIAlertAction actionWithTitle:NSLocalizedString(@"Settings", @"") style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
                    [[UIApplication sharedApplication] openURL:[NSURL URLWithString:UIApplicationOpenSettingsURLString]];
                }]];
                [alert show];
                
                return;
            }
            
            //get user location
            _locationManager = [[CLLocationManager alloc] init];
            _locationManager.delegate = self;
            _locationManager.desiredAccuracy = kCLLocationAccuracyBest;
            
            //place name
            _geocoder = [[CLGeocoder alloc] init];
            
            //ask for permission
            [_locationManager requestWhenInUseAuthorization];
            [_locationManager startUpdatingLocation];
            
        }else {
            UIAlertController *alert = [UIAlertController alertControllerWithTitle:NSLocalizedString(@"GPS is off", @"") message:NSLocalizedString(@"Please turn on GPS in your device", @"") preferredStyle:UIAlertControllerStyleAlert];
            [alert addAction: [UIAlertAction actionWithTitle:NSLocalizedString(@"Ok", @"") style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
                
            }]];
            [alert show];
        }
        
        
        
        
    } else if (_latitudeCoordinate && !_pinLocation) {
        //update location coordinate
        _pinLocation = [[CLLocation alloc] initWithLatitude:_latitudeCoordinate longitude:_longitudeCoordinate];
        
        //place name
        _geocoder = [[CLGeocoder alloc] init];
        
        //update location address
        [self updateLocationAddress:_pinLocation];
        
        //set pin in map
        [self setPinWithCoordinate:_pinLocation.coordinate];
        
        //zoom to location
        [self zoomToCoordinate:_pinLocation.coordinate];
    }
    
    
}

#pragma mark - CLLocationManagerDelegate
- (void)locationManager:(CLLocationManager *)manager didFailWithError:(NSError *)error
{
    UIAlertController *alert = [UIAlertController alertControllerWithTitle:NSLocalizedString(@"Current location", @"")
                                                                   message:NSLocalizedString(@"Failed to get current location", @"")
                                                            preferredStyle:UIAlertControllerStyleAlert];
    
    [alert addAction:[UIAlertAction actionWithTitle:NSLocalizedString(@"Ok", @"") style:UIAlertActionStyleDefault handler:nil]];
    [alert show];
}

//- (void)locationManager:(CLLocationManager *)manager didUpdateToLocation:(CLLocation *)newLocation fromLocation:(CLLocation *)oldLocation
- (void)locationManager:(CLLocationManager *)manager didUpdateLocations:(NSArray<CLLocation *> *)locations
{
    if (_pinLocation) {
        return;
    }
    
    // Stop Location Manager
    [_locationManager stopUpdatingLocation];
    
    // Got current location
//    NSLog(@"didUpdateToLocation: %@", locations.firstObject);
    _pinLocation = locations.firstObject;
    
    //set pin in map
    [self setPinWithCoordinate:_pinLocation.coordinate];
    
    //zoom to location
    [self zoomToCoordinate:_pinLocation.coordinate];
}

#pragma mark - pin
#pragma mark Current location
-(void)setPinWithCoordinate:(CLLocationCoordinate2D)coordinate{
    [self setPinWithCoordinate:coordinate Title:nil];
}

-(void)setPinWithCoordinate:(CLLocationCoordinate2D)coordinate Title:(NSString*)title{
    // Place a single pin
    MKPointAnnotation *annotation = [[MKPointAnnotation alloc] init];
    [annotation setCoordinate:coordinate];
    if (title) {
        [annotation setTitle:@"Title"];
    }
    [self addAnnotation:annotation];
    
}

#pragma mark Zoom
-(void)zoomToCoordinate:(CLLocationCoordinate2D)coordinate{
    MKCoordinateSpan span = MKCoordinateSpanMake(0.1, 0.1);
    MKCoordinateRegion region = {coordinate, span};
    [self setRegion:region animated:YES];
}


#pragma mark Location info
-(void)updateLocationAddress:(CLLocation *)location{
    // Reverse Geocoding
//    NSLog(@"Resolving the Address");
    [_geocoder reverseGeocodeLocation:location completionHandler:^(NSArray *placemarks, NSError *error) {
//        NSLog(@"Found placemarks: %@, error: %@", placemarks, error);
        if (error == nil && [placemarks count] > 0) {
            self->_placemark = [placemarks lastObject];
            self->_address = @"";
            if (self->_placemark.name) // place name
                self->_address = [self->_address stringByAppendingString:[NSString stringWithFormat:@"%@, ",self->_placemark.name]];
            if (self->_placemark.thoroughfare) // street
                self->_address = [self->_address stringByAppendingString:[NSString stringWithFormat:@"%@, ",self->_placemark.thoroughfare]];
            if (self->_placemark.locality) // city
                self->_address = [self->_address stringByAppendingString:[NSString stringWithFormat:@"%@, ",self->_placemark.locality]];
            if (self->_placemark.country) // country
                self->_address = [self->_address stringByAppendingString:[NSString stringWithFormat:@"%@",self->_placemark.country]];
            
            //call closures
            if (self->_updateCoordinate) {
                self->_updateCoordinate(self->_pinLocation.coordinate);
            }
            
            if (self->_updateCoordinateWithAddress) {
                self->_updateCoordinateWithAddress(location.coordinate,self->_address);
            }
            
            if (self->_updateCoordinateWithPlacemark) {
                self->_updateCoordinateWithPlacemark(location.coordinate,self->_placemark);
            }
        } else {
            NSLog(@"%@", error.debugDescription);
        }
    } ];
}

#pragma mark Dragable
- (MKAnnotationView *)mapView:(MKMapView *)mapView viewForAnnotation:(id<MKAnnotation>)annotation
{
    if ([annotation isKindOfClass:[MKUserLocation class]])
        return nil;
    
    static NSString *reuseId = @"pin";
    MKPinAnnotationView *pav = (MKPinAnnotationView *)[mapView dequeueReusableAnnotationViewWithIdentifier:reuseId];
    if (pav == nil)
    {
        pav = [[MKPinAnnotationView alloc] initWithAnnotation:annotation reuseIdentifier:reuseId];
        pav.draggable = _dragable;
        pav.animatesDrop = YES;
    }
    else
    {
        pav.annotation = annotation;
    }
    
    //update location address
    [self updateLocationAddress:_pinLocation];
    
    return pav;
}

- (void)mapView:(MKMapView *)mapView
 annotationView:(MKAnnotationView *)annotationView
didChangeDragState:(MKAnnotationViewDragState)newState
   fromOldState:(MKAnnotationViewDragState)oldState
{
    if (newState == MKAnnotationViewDragStateEnding)
    {
        CLLocationCoordinate2D droppedAt = annotationView.annotation.coordinate;
//        NSLog(@"dropped at %f,%f", droppedAt.latitude, droppedAt.longitude);
        
        //update location coordinate
        _pinLocation = [[CLLocation alloc] initWithLatitude:droppedAt.latitude longitude:droppedAt.longitude];
        
        //update location address
        [self updateLocationAddress:_pinLocation];
    }
}

@end
