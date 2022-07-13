//
//  LocationModel.swift
//  MapDemo
//
//  Created by 残云cyun on 2022/7/1.
//


import MapKit

final class LocationModel: NSObject, ObservableObject, CLLocationManagerDelegate {
    @Published var region = MKCoordinateRegion(
        center: CLLocationCoordinate2D(latitude: 39.9087242, longitude: 116.3952859),
        span: MKCoordinateSpan(latitudeDelta: 0.05, longitudeDelta: 0.05))
    
    var locationManager: CLLocationManager?
    func checkIfServiceIsEnable() {
        if CLLocationManager.locationServicesEnabled() {
            locationManager = CLLocationManager.init()
            checkedLocationAuthorization()
        }else {
            debugPrint("some error")
        }
    }
    
    func checkedLocationAuthorization() {
        guard let locationManager = locationManager else {
            return
        }
        
        switch locationManager.authorizationStatus {
            case .notDetermined:
                locationManager.requestWhenInUseAuthorization()
            case .restricted:
                debugPrint("restricted")
            case .denied:
                debugPrint("denied")
            case .authorizedAlways, .authorizedWhenInUse:
                region = MKCoordinateRegion(
                    center: locationManager.location!.coordinate,
                    span: MKCoordinateSpan(latitudeDelta: 0.05, longitudeDelta: 0.05))
                break
            @unknown default:
                break
        }
    }
    
    func locationManagerDidChangeAuthorization(_ manager: CLLocationManager) {
        checkedLocationAuthorization()
    }
}
