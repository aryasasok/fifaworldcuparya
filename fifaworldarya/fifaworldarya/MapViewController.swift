//
//  MapViewController.swift
//  fifaworldarya
//
//  Created by Arya S  Asok on 2019-07-02.
//  Copyright © 2019 Parrot. All rights reserved.
//

import Foundation
import UIKit
import MapKit

class MapViewController: UIViewController, MKMapViewDelegate {
    
    @IBOutlet weak var mapView: MKMapView?
    
    var games: [Game]?
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        let initialLocation = CLLocationCoordinate2D(latitude: 48.8566, longitude: 2.3522)
        mapView?.setCenter(initialLocation, animated: false)
    }
    
    func reloadMap() {
        
        if games != nil {
            for game in games! {
                let annotation = MKPointAnnotation()
                annotation.title = game.location
                annotation.coordinate = CLLocationCoordinate2D(latitude: game.latitude, longitude: game.longitude)
                mapView?.addAnnotation(annotation)
            }
        }
    }
}
