# FAMapView

[![CI Status](http://img.shields.io/travis/fadizant/FAMapView.svg?style=flat)](https://travis-ci.org/fadizant/FAMapView)
[![Version](https://img.shields.io/cocoapods/v/FAMapView.svg?style=flat)](http://cocoapods.org/pods/FAMapView)
[![License](https://img.shields.io/cocoapods/l/FAMapView.svg?style=flat)](http://cocoapods.org/pods/FAMapView)
[![Platform](https://img.shields.io/cocoapods/p/FAMapView.svg?style=flat)](http://cocoapods.org/pods/FAMapView)

## Example

To run the example project, clone the repo, and run `pod install` from the Example directory first.

## Requirements

- iOS 9.0
- use Location Description in plist
```ruby
    <key>NSLocationWhenInUseUsageDescription</key>
	<string>$(EXECUTABLE_NAME) needs to access your Location</string>
```

## How to use
FAMapView can add pin for you in map started from your location or custom location and you can make it dragable to change it,
FAMapView will return pin coordinate , address or placemark info for you.

You can use FAMap by add custom class to Map Kit View or call "FAMapViewController".

Show FAMapViewController inside UINavigationController at least to can close view, FAMapViewController will show close button if there is no buttons in UINavigationBar.

### Use FAMap
##### Objc
- Coordinate 
```ruby
    _mapView.updateCoordinate = ^(CLLocationCoordinate2D coordinate) {
        NSLog(@"Coordinate = %f:%f",coordinate.latitude,coordinate.longitude);
    };
```
- Coordinate and Address
```ruby
    _mapView.updateCoordinateWithAdress = ^(CLLocationCoordinate2D coordinate, NSString *address) {
        NSLog(@"Address = %@",address);
    };
```
- Coordinate and Placemark
```ruby
    _mapView.updateCoordinateWithPlacemark = ^(CLLocationCoordinate2D coordinate, CLPlacemark *placemark) {
        NSLog(@"Country = %@ , City = %@",placemark.country,placemark.locality);
    };
```

##### Swift4
- Coordinate 
```ruby
    mapView.updateCoordinate = {(coordinate) in
        print("Coordinate = \(coordinate.latitude):\(coordinate.longitude)")
    }
```
- Coordinate and Address
```ruby
    mapView.updateCoordinateWithAdress = {(coordinate, address) in
        print("Address = \(address ?? "")")
    }
```
- Coordinate and Placemark
```ruby
    mapView.updateCoordinateWithPlacemark = {(coordinate, placemark) in
        print("Country = \(placemark?.country ?? "") , City = \(placemark?.locality ?? "")")
    }
```


### use FAMapViewController
##### Objc
- Coordinate 
```ruby
    FAMapViewController *mapView = [[FAMapViewController alloc]initUserLocationWithDragable:YES updateCoordinate:^(CLLocationCoordinate2D coordinate) {
        NSLog(@"Coordinate = %f:%f",coordinate.latitude,coordinate.longitude);
    }];
    UINavigationController *nav = [[UINavigationController alloc]initWithRootViewController:mapView];
    mapView.title = @"pik location";
    [self presentViewController:nav animated:YES completion:nil];
```
- Coordinate and Address
```ruby
    FAMapViewController *mapView = [[FAMapViewController alloc]initUserLocationWithDragable:YES updateCoordinateWithAddress:^(CLLocationCoordinate2D coordinate, NSString *address) {
        NSLog(@"Address = %@",address);
    }];
    UINavigationController *nav = [[UINavigationController alloc]initWithRootViewController:mapView];
    mapView.title = @"pik location";
    [self presentViewController:nav animated:YES completion:nil];
```
- Coordinate and Placemark
```ruby
    FAMapViewController *mapView = [[FAMapViewController alloc]initUserLocationWithDragable:YES updateCoordinateWithPlacemark:^(CLLocationCoordinate2D coordinate, CLPlacemark *placemark) {
        NSLog(@"Country = %@ , City = %@",placemark.country,placemark.locality);
    }];
    UINavigationController *nav = [[UINavigationController alloc]initWithRootViewController:mapView];
    mapView.title = @"pik location";
    [self presentViewController:nav animated:YES completion:nil];
```

##### Swift4
- Coordinate 
```ruby
    let mapView = FAMapViewController.init(userLocationCWithisDragable: true) { (coordinate) in
        print("Coordinate = \(coordinate.latitude):\(coordinate.longitude)")
    }
    if let map = mapView {
        self.navigationController?.pushViewController(map, animated: true)
    }
```
- Coordinate and Address
```ruby
    let mapView = FAMapViewController.init(userLocationCAWithisDragable: true) { (coordinate, address) in
        print("Address = \(address ?? "")")
    }
    if let map = mapView {
        self.navigationController?.pushViewController(map, animated: true)
    }
```
- Coordinate and Placemark
```ruby
    let mapView = FAMapViewController.init(userLocationCPWithisDragable: true) { (coordinate, placemark) in
        print("Country = \(placemark?.country ?? "") , City = \(placemark?.locality ?? "")")
    }
    if let map = mapView {
        self.navigationController?.pushViewController(map, animated: true)
    }
```
## Installation

FAMapView is available through [CocoaPods](http://cocoapods.org). To install
it, simply add the following line to your Podfile:

```ruby
pod 'FAMapView'
```

## Author

fadizant, fadizant@yahoo.com

## License

FAMapView is available under the MIT license. See the LICENSE file for more info.
