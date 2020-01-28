//
//  MapAddressViewController.swift
//  Delivery
//
//  Created by Nurzhigit Smailov on 9/9/19.
//  Copyright © 2019 Nurzhigit Smailov. All rights reserved.
//

import UIKit
import MapKit
import CoreLocation

class MapAddressViewController: UIViewController {
    
    // MARK: - Properties
    var addressLabel: UILabel = {
        let label = UILabel()
        label.font = .getMullerBoldFont(on: 20)
        label.textAlignment = .center
        label.textColor = #colorLiteral(red: 0.3176470588, green: 0.3607843137, blue: 0.4352941176, alpha: 1)
        return label
    }()
    let regionInMeters: Double  = 1000
    lazy var mapView: MKMapView = {
        let view = MKMapView()
        view.delegate = self
        return view
    }()
    let trackerView: UIImageView = {
        let image = UIImageView()
        image.image = #imageLiteral(resourceName: "Frame")
        image.contentMode = .scaleAspectFit
        return image
    }()
    lazy var agreeButton: UIButton = {
        let button = UIButton()
        button.setTitle("Подтвердить", for: .normal)
        button.titleLabel?.font = .getMullerBoldFont(on: 18)
        button.setTitleColor(.white, for: .normal)
        button.backgroundColor = #colorLiteral(red: 0.1647058824, green: 0.5960784314, blue: 1, alpha: 1)
        button.layer.cornerRadius = 10
        button.addTarget(self, action: #selector(sendAddress), for: .touchUpInside)
        return button
    }()
    let locationManager = CLLocationManager()
    var previousLocation: CLLocation?
    
    // MARK: - Lifecycle
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationItem.title = "Карта"
        tabBarController?.tabBar.isHidden = true
        navigationController?.setNavigationBarHidden(false, animated: animated)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupViews()
        checkLocationServices()
    }
    
    func setupViews() {
        view.addSubviews(views: [mapView, addressLabel, trackerView, agreeButton])
        
        mapView.snp.makeConstraints { (make) in
            make.top.left.right.equalToSuperview()
            make.bottom.equalToSuperview()
        }
        mapView.delegate = self
        addressLabel.snp.makeConstraints { (make) in
            make.left.right.equalToSuperview()
            make.top.equalToSuperview().offset(80)
            make.height.equalTo(80)
        }
        agreeButton.snp.makeConstraints { (make) in
            make.left.equalToSuperview().offset(16)
            make.right.equalToSuperview().offset(-16)
            make.bottom.equalTo(view.safeAreaLayoutGuide.snp.bottom).offset(-16)
            make.height.equalTo(60)
        }
        trackerView.snp.makeConstraints { (make) in
            make.centerX.equalToSuperview()
            make.centerY.equalToSuperview().offset(-20)
        }
    }
    
    func setupLocationManager() {
        locationManager.delegate = self
        locationManager.desiredAccuracy = kCLLocationAccuracyBest
    }
    
    // MARK: - Functions
    func checkLocationServices() {
        if CLLocationManager.locationServicesEnabled() {
            setupLocationManager()
            checkLocationAuthorization()
        } else {
            
        }
    }
    
    func centerViewOnUserLocation () {
        if let location = locationManager.location?.coordinate {
            let region = MKCoordinateRegion.init(center: location, latitudinalMeters: regionInMeters, longitudinalMeters: regionInMeters )
            mapView.setRegion(region, animated: true)
        }
    }
    
    func checkLocationAuthorization() {
        switch CLLocationManager.authorizationStatus() {
        case .authorizedWhenInUse:
            trackingUserLocation()
        case .denied:
            break
        case .notDetermined:
            locationManager.requestWhenInUseAuthorization()
        case .restricted:
            break
        case .authorizedAlways:
            break
        @unknown default:
            break
        }
    }
    
    func trackingUserLocation(){
        mapView.showsUserLocation = true
        centerViewOnUserLocation()
        locationManager.startUpdatingLocation()
        previousLocation = getCenterLocation(for: mapView)
    }
    
    func getCenterLocation(for mapView: MKMapView)-> CLLocation {
        let lat = mapView.centerCoordinate.latitude
        let long = mapView.centerCoordinate.longitude
        return CLLocation(latitude: lat, longitude: long)
    }
    
    // MARK: - Actions
    @objc func sendAddress() {
        let vc = self.navigationController!.viewControllers[0] as! ProfileViewController
        vc.addNewAddressView.streetTextField.textField.text = addressLabel.text
        let lastAddressCoordinate = getCenterLocation(for: mapView)
        print(lastAddressCoordinate)
        vc.lat = lastAddressCoordinate.coordinate.latitude
        vc.lng = lastAddressCoordinate.coordinate.longitude
        self.navigationController!.popToRootViewController(animated: true)
    }
    
}

// MARK: - CLLocationDelegate
extension MapAddressViewController:  CLLocationManagerDelegate {
    func locationManager(_ manager: CLLocationManager, didChangeAuthorization status: CLAuthorizationStatus) {
        checkLocationAuthorization()
    }
}

// MARK: - MKMapViewDelegate
extension MapAddressViewController: MKMapViewDelegate {
    
    func mapView(_ mapView: MKMapView, regionDidChangeAnimated animated: Bool) {
        let center = getCenterLocation(for: mapView)
        let geoCoder = CLGeocoder()
        
        guard let previousLocation = self.previousLocation else { return }
        
        guard center.distance(from: previousLocation) > 50 else { return }
        self.previousLocation = center
        
        geoCoder.reverseGeocodeLocation(center) { [weak self] (placemarks, error) in
            guard let self = self else { return }
            if let message = error {
                DispatchQueue.main.async {
                    self.showErrorMessage(message.localizedDescription)
                }
            }
            guard let placemark = placemarks?.first else {
                DispatchQueue.main.async {
                    self.showErrorMessage("Ошибка попробуйте еще раз")
                }
                return
            }
            let streetNumber = placemark.subThoroughfare ?? ""
            let streetName = placemark.thoroughfare ?? ""
            DispatchQueue.main.async {
                self.addressLabel.text = "\(streetNumber) \(streetName)"
            }
        }
    }
}
