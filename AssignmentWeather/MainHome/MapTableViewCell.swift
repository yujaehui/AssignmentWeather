//
//  MapTableViewCell.swift
//  AssignmentWeather
//
//  Created by Jaehui Yu on 2/12/24.
//

import UIKit
import MapKit
import SnapKit

class MapTableViewCell: BaseTableViewCell {
    let mapView = MKMapView()
    
    override func configureHierarchy() {
        contentView.addSubview(mapView)
    }
    
    override func configureView() {
        let coordinate = CLLocationCoordinate2D(latitude: 35.133331,
                                                longitude: 128.699997)
        let region = MKCoordinateRegion(center: coordinate,
                                        latitudinalMeters: 500,
                                        longitudinalMeters: 500)
        mapView.setRegion(region, animated: true)
        
        let annotation = MKPointAnnotation()
        annotation.coordinate = coordinate
        mapView.addAnnotation(annotation)
    }
    
    override func configureConstraints() {
        mapView.snp.makeConstraints { make in
            make.edges.equalTo(contentView).inset(16)
            make.height.equalTo(200)
        }
    }
}
