//
//  MapPreviewCell.swift
//  Travl.iOS
//
//  Created by Ikmal Azman on 12/09/2021.
//

import UIKit
import MapKit
import CoreLocation

protocol MapPreviewCellDelegate : AnyObject {
    func presentCoordinateFromQuery(_ vc : MapPreviewCell, latitude : Double, longitude : Double, coordinate : CLLocationCoordinate2D)
}
final class MapPreviewCell: UITableViewCell {
    
    //MARK:- Outlets
    @IBOutlet weak var previewImage: UIImageView!
    
    //MARK:- Variables
    static let identifier = "MapPreviewCell"
    weak var delegate : MapPreviewCellDelegate?
    
    static func nib() -> UINib {
        return UINib(nibName: R.nib.mapPreviewCell.name, bundle: nil)
    }
    
    private let mapSnapshotOptions = MKMapSnapshotter.Options()
    
    //MARK:- Life Cycle
    override func awakeFromNib() {
        super.awakeFromNib()
    }
    
    override func prepareForReuse() {
        previewImage.image = nil
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        contentView.addRoundedCorners()
        contentView.addCellPadding(top: 10)
        selectionStyle = .none
    }
    
    
    func configureCell(with data: Days) {
        let coordinate = CLLocationCoordinate2D(latitude: data.coordinate.lat, longitude: data.coordinate.lon)
        let span = MKCoordinateSpan(latitudeDelta: 0.0055, longitudeDelta: 0.0055)
        let region = MKCoordinateRegion(center: coordinate, span: span)
        

        let mapSnapOptions = createMapSnapshotOptions(withRegion: region)
        createSnapshot(with : mapSnapOptions)
    }
    
    func configureCell(fromQuery query: String) {
        let searchRequest = MKLocalSearch.Request()
        searchRequest.naturalLanguageQuery = query
        searchRequest.resultTypes = .pointOfInterest
        
        let search = MKLocalSearch(request: searchRequest)
        search.start { [weak self] response, error in
            guard error == nil else {
                return
            }
            guard let location = response?.mapItems.first?.placemark else {return}
            let coordinate = CLLocationCoordinate2D(latitude: location.coordinate.latitude, longitude: location.coordinate.longitude)
            let span = MKCoordinateSpan(latitudeDelta: 0.0055, longitudeDelta: 0.0055)
            let region = MKCoordinateRegion(center: coordinate, span: span)
            let mapSnapshotOptions = self?.createMapSnapshotOptions(withRegion: region)
            self?.delegate?.presentCoordinateFromQuery(self!, latitude: coordinate.latitude, longitude: coordinate.longitude, coordinate: coordinate)
            self?.createSnapshot(with: mapSnapshotOptions!)
        }
        
        
    }
    
    private func createMapSnapshotOptions(withRegion region : MKCoordinateRegion) -> MKMapSnapshotter.Options {
        mapSnapshotOptions.region = region
        
        mapSnapshotOptions.scale = UIScreen.main.scale
        mapSnapshotOptions.size = CGSize(width: 400, height: 400)
        
        mapSnapshotOptions.showsBuildings = true
        mapSnapshotOptions.pointOfInterestFilter = .includingAll
        return mapSnapshotOptions
    }
    
    private func createSnapshot(with snapOptions: MKMapSnapshotter.Options) {
        
        let snapShot = MKMapSnapshotter(options: snapOptions)
        
        snapShot.start { [weak self] snapShot, error in
            //guard snapShot != nil, error != nil else{  return}
            self?.previewImage.image = snapShot?.image
        }
        
    }
}



