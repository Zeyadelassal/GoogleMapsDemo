//
//  ViewController.swift
//  GoogleMapsDemo
//
//  Created by Zeyad Elassal on 10/13/20.
//

import UIKit
import GoogleMaps
import CoreLocation

class MapViewController: UIViewController {
    @IBOutlet weak var mapView: GMSMapView!

    let locationManager = CLLocationManager()
    var tappedMarker : GMSMarker?
    var infoWindow : CustomView?
    
    override func viewDidLoad() {
        super.viewDidLoad()
 //        if CLLocationManager.locationServicesEnabled(){
//          locationManager.requestLocation()
//          mapView.isMyLocationEnabled = true
//          mapView.settings.myLocationButton = true
//        //fetchPlaces(near: mapView.camera.target)
//        }else{
//          locationManager.requestWhenInUseAuthorization()
//        }
        setupMap()
        requestUserLocation()
        addMarker()
        setupMarkerWithCustomInfoWindow()
    }
    
    func setupMap(){
        mapView.delegate = self
        let camera : GMSCameraPosition = GMSCameraPosition(latitude: 48.857165, longitude: 2.354613, zoom: 15.0)
        mapView.camera = camera
    }
    
    func requestUserLocation(){
        locationManager.requestWhenInUseAuthorization()
        locationManager.delegate = self
        locationManager.desiredAccuracy = kCLLocationAccuracyBest
    }
    
    func addMarker(){
        let coordinate = CLLocationCoordinate2D(latitude: 48.857165, longitude: 2.354613)
        let marker = GMSMarker(position: coordinate)
//        marker.title = "C'est Paris"
//        marker.snippet = "France"
        marker.appearAnimation = .pop
        marker.icon = GMSMarker.markerImage(with: .blue)
        marker.map = self.mapView
    }
    
    func setupMarkerWithCustomInfoWindow(){
        self.tappedMarker = GMSMarker()
        self.infoWindow = CustomView().loadView()
    }
}

extension MapViewController:GMSMapViewDelegate{
    
    func mapView(_ mapView: GMSMapView, didTap marker: GMSMarker) -> Bool {
        return false
    }
    
    func mapView(_ mapView: GMSMapView, markerInfoWindow marker: GMSMarker) -> UIView? {
        return self.infoWindow
    }
}


extension MapViewController:CLLocationManagerDelegate{
    func locationManager(_ manager: CLLocationManager, didChangeAuthorization status: CLAuthorizationStatus) {
        guard status == .authorizedWhenInUse else{
            return
        }
        locationManager.startUpdatingLocation()
        mapView.isMyLocationEnabled = true
        mapView.settings.myLocationButton = true
    }
    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        guard let location = locations.first else{
            return
        }
        let marker = GMSMarker(position: location.coordinate)
        marker.title = "You are here"
        marker.map = self.mapView
        mapView.camera = GMSCameraPosition(latitude: location.coordinate.latitude, longitude: location.coordinate.longitude, zoom: 15)
        locationManager.stopUpdatingLocation()
    }
    
    func locationManager(_ manager: CLLocationManager, didFailWithError error: Error) {
        print("Error: \(error)")
    }
}
