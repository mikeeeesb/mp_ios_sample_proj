//
//  MapViewController.swift
//  mp_ios_sample_proj
//
//  Created by mike on 8/4/17.
//  Copyright © 2017 mp. All rights reserved.
//

import UIKit
import MapKit

class MapViewController : UIViewController {
    
    var mapView : MKMapView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        print("MapViewController loaded its view.")
    }
    
    override func loadView() {
        mapView = MKMapView()
        // Set it as *the* view of this view controller
        view = mapView
    }
}
