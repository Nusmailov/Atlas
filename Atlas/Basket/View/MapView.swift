//
//  MapView.swift
//  InMaster
//
//  Created by Nurzhigit Smailov on 11/15/19.
//  Copyright © 2019 Nurzhigit Smailov. All rights reserved.
//

import UIKit
import MapKit
import CoreLocation

class MapView: MKMapView {
    
    //MARK: - Properties
    var initialLocation = CLLocation(latitude: 37.385365, longitude: -122.084074)
    let regionRadius: CLLocationDistance = 800
    let userName = ""
    lazy var addressView: UIView = {
        let view = UIView()
        view.layer.cornerRadius = 10
        view.backgroundColor = .white
        return view
    }()
    lazy var addressLabel: UILabel = {
        let label = UILabel()
        label.font = .getMontserraBoldFont(on: 12)
        label.textColor = UIColor(red: 0.173, green: 0.184, blue: 0.2, alpha: 1)
        label.text = "г.Алматы, Абая 160"
        return label
    }()

    init(lat: Double, lng: Double) {
        self.initialLocation = CLLocation(latitude: lat, longitude: lng)
        super.init(frame: CGRect(x: 0, y: 0, width: 0, height: 0))
        setupViews()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    //MARK: - SetupViews
    func setupViews() {
        delegate = self
        addSubview(addressView)
        addressView.snp.makeConstraints { (make) in
            make.right.bottom.equalTo(-10)
        }
        addressView.addSubview(addressLabel)
        addressLabel.snp.makeConstraints { (make) in
            make.top.equalTo(4)
            make.left.equalTo(8)
            make.bottom.equalTo(-4)
            make.right.equalTo(-8)
        }
        self.centerMapOnLocation(location: self.initialLocation)
    }
    
    func centerMapOnLocation(location: CLLocation) {
        let coordinateRegion = MKCoordinateRegion(center: location.coordinate,
                                                  latitudinalMeters: regionRadius, longitudinalMeters: regionRadius)
        self.setRegion(coordinateRegion, animated: true)
        let location = CLLocationCoordinate2D(latitude: initialLocation.coordinate.latitude, longitude: initialLocation.coordinate.longitude)
        let pin = MapClass(pinTitle: userName, pinSubTitle: "", location: location)
        self.addAnnotation(pin)
    }
}

//MARK: - MKMapViewDelegate
extension MapView: MKMapViewDelegate {
    func mapView(_ mapView: MKMapView, viewFor annotation: MKAnnotation) -> MKAnnotationView? {
        if annotation is MKUserLocation {
            return nil
        }
        
        let annotationView = MKAnnotationView(annotation: annotation, reuseIdentifier: "custonidentifier")
        annotationView.image = UIImage(named: "location")
        annotationView.canShowCallout = true
        return annotationView
    }
}
