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
    
    //MARK: - Outlets
    @IBOutlet weak var mapView: MKMapView!
    @IBOutlet weak var directionImage: UIImageView!
    @IBOutlet weak var directionView: UIView!
    
    var latitude : Double?
    var logitude : Double?
    var locationName : String?

    //MARK: - Life Cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        configureDirectionView()
        configureMapView(lat: latitude ?? 0.0, lon: logitude ?? 0.0)
    }
    //MARK: - Action
    @IBAction func undoButtonPressed(_ sender: UIBarButtonItem) {
        dismiss(animated: true, completion: nil)
    }
    
    @objc private func openMapsApp(_ sender : UITapGestureRecognizer) {
        guard let latitude = latitude, let logitude = logitude, let locationName = locationName else {return}
        let coordinate = CLLocationCoordinate2D(latitude: latitude, longitude: logitude)
        let placemark = MKPlacemark(coordinate: coordinate)
        let span = MKCoordinateSpan(latitudeDelta: 0.005, longitudeDelta: 0.005)
        let mkMapItem = MKMapItem(placemark: placemark)
        mkMapItem.name = locationName
        // Open maps app based on coordinate given in mkMapItem
        mkMapItem.openInMaps(launchOptions: [MKLaunchOptionsMapSpanKey: span])
    }
}

//MARK: - Private Methods
extension ItenaryMapViewVC {
    private func configureDirectionView() {
        directionView.addRoundedCorners(radius: 35)
        directionView.backgroundColor = .secondaryLightTurqoise
        directionImage.tintColor = .white
        let tap = UITapGestureRecognizer(target: self, action: #selector(openMapsApp(_:)))
        directionView.addGestureRecognizer(tap)
    }
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
