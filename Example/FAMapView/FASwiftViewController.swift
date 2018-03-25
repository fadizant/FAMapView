//
//  FASwiftViewController.swift
//  FAMapView_Example
//
//  Created by Fadi Abuzant on 3/24/18.
//  Copyright © 2018 fadizant. All rights reserved.
//

import UIKit
import FAMapView

class FASwiftViewController: UIViewController {

    // MARK - UI
    @IBOutlet weak var mapView: FAMap!
    @IBOutlet weak var addressLabel: UILabel!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        mapView.updateCoordinate = {(coordinate) in
            print("Coordinate = \(coordinate.latitude):\(coordinate.longitude)")
        }
        
        mapView.updateCoordinateWithAddress = {(coordinate, address) in
            self.title = address
            print("Address = \(address ?? "")")
        }
        
        mapView.updateCoordinateWithPlacemark = {(coordinate, placemark) in
            print("Country = \(placemark?.country ?? "") , City = \(placemark?.locality ?? "")")
        }
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func showMap(_ sender: UIButton) {
        
//        let mapView = FAMapViewController.init(userLocationCWithisDragable: true) { (coordinate) in
//            print("Coordinate = \(coordinate.latitude):\(coordinate.longitude)")
//        }
        
        let mapView = FAMapViewController.init(userLocationCAWithisDragable: true) { (coordinate, address) in
            self.addressLabel.text = address
            print("Address = \(address ?? "")")
        }

//        let mapView = FAMapViewController.init(userLocationCPWithisDragable: true) { (coordinate, placemark) in
//            print("Country = \(placemark?.country ?? "") , City = \(placemark?.locality ?? "")")
//        }
        
        
        if let map = mapView {
            self.navigationController?.pushViewController(map, animated: true)
        }

        
    }
    


}
