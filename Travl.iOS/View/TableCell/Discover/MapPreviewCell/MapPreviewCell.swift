//
//  MapPreviewCell.swift
//  Travl.iOS
//
//  Created by Ikmal Azman on 12/09/2021.
//

import UIKit
import MapKit
import CoreLocation

final class MapPreviewCell: UITableViewCell {
    
    //MARK:- Outlets
    @IBOutlet weak var previewImage: UIImageView!
    
    //MARK:- Variables
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
    
    
    func configureCell(with data: Days) {
        let coordinate = CLLocationCoordinate2D(latitude: data.coordinate.lat, longitude: data.coordinate.lon)
        let span = MKCoordinateSpan(latitudeDelta: 0.0055, longitudeDelta: 0.0055)
        let region = MKCoordinateRegion(center: coordinate, span: span)
        
        mapSnapshotOptions.region = region
        
        mapSnapshotOptions.scale = UIScreen.main.scale
        mapSnapshotOptions.size = CGSize(width: 400, height: 400)
        
        mapSnapshotOptions.showsBuildings = true
        mapSnapshotOptions.pointOfInterestFilter = .includingAll
        
        createSnapshot(with : mapSnapshotOptions)
    }
    
    private func createSnapshot(with snapOptions: MKMapSnapshotter.Options) {
        
        let snapShot = MKMapSnapshotter(options: snapOptions)
        
        snapShot.start { [weak self] snapShot, error in
            //guard snapShot != nil, error != nil else{  return}
            self?.previewImage.image = snapShot?.image
        }
        
    }
}
