//
//  MapViewVC.swift
//  Travl.iOS
//
//  Created by Ikmal Azman on 14/09/2021.
//

import UIKit
import MapKit
import CoreLocation

final class ItenaryMapViewVC: UIViewController {
    
    //MARK:- Outlets
    @IBOutlet weak var mapView: MKMapView!
    
    var latitude : Double?
    var logitude : Double?
    var locationName : String?

    
    //MARK:- Life Cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        configureMapView(lat: latitude ?? 0.0, lon: logitude ?? 0.0)
    }
    
    //MARK:- Action
    @IBAction func undoButtonPressed(_ sender: UIBarButtonItem) {
        dismiss(animated: true, completion: nil)
    }
    
}

//MARK:- Private Methods
extension ItenaryMapViewVC {
    
    private func configureMapView(lat : Double, lon : Double) {
        
        let span = MKCoordinateSpan(latitudeDelta: 0.0050, longitudeDelta: 0.0050)
        
        let coordinate = CLLocationCoordinate2D(latitude: lat, longitude: lon)
        
        let region = MKCoordinateRegion(center: coordinate, span: span)
        print(region)
        
        mapView.setRegion(region, animated: true)
        
        configureAnnotation(from : coordinate)
        
        
    }
    
    private func configureAnnotation( from coordinate : CLLocationCoordinate2D) {
        
        let annotation = MKPointAnnotation()
        annotation.title = locationName
        annotation.coordinate = coordinate
        mapView.addAnnotation(annotation)
        
    }
}
