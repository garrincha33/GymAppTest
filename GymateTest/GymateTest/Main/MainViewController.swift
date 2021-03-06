//
//  MainViewController.swift
//  GymateTest
//
//  Created by Richard Price on 03/12/2019.
//  Copyright © 2019 twisted echo. All rights reserved.
//

import UIKit
import LBTATools
import MapKit

extension MainViewController: MKMapViewDelegate {
    func mapView(_ mapView: MKMapView, viewFor annotation: MKAnnotation) -> MKAnnotationView? {
        if (annotation is MKPointAnnotation) {

        let anotationView = MKPinAnnotationView(annotation: annotation, reuseIdentifier: "id")
        anotationView.canShowCallout = true
        anotationView.image = #imageLiteral(resourceName: "GYmPinSmall")
        return anotationView
        }
        return nil
    }
}

class MainViewController: UIViewController, CLLocationManagerDelegate {
    
    let locationManager = CLLocationManager()
    let mapView = MKMapView()
    override func viewDidLoad() {
        super.viewDidLoad()
        locationsController.mainController = self
        requestUserLocation()
        mapView.showsUserLocation = true
        title = "test"
        mapView.delegate = self
        view.addSubview(mapView)
        mapView.TEfillSuperview()
        setupRegionForMap()
        performLocalSearch()
        setupLocationsCarousel()
        setupNavBar()

    }

    fileprivate func requestUserLocation() {
        locationManager.requestWhenInUseAuthorization()
        locationManager.delegate = self
    }

    func locationManager(_ manager: CLLocationManager, didChangeAuthorization status: CLAuthorizationStatus) {
        switch status {
        case .authorizedWhenInUse:
            print("Authorisation recieved")
            locationManager.startUpdatingLocation()
        default:
            print("Failed to authorise")
        }
    }
    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        guard let firstLocation = locations.first else {return}
        mapView.setRegion(.init(center: firstLocation.coordinate, span: .init(latitudeDelta: 0.1, longitudeDelta: 0.1)), animated: false)

        locationManager.stopUpdatingLocation()
    }

    fileprivate func setupNavBar() {
        let lable: UILabel = {
            let lable = UILabel(text: "GYMATE", font: UIFont.boldSystemFont(ofSize: 25), textColor: .orange, textAlignment: .left, numberOfLines: 0)
            return lable
        }()
       
 
        let blackView = UIView()
        blackView.backgroundColor = .black

        let stackView = UIStackView(arrangedSubviews: [blackView])
        stackView.axis = .horizontal
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.sendSubviewToBack(blackView)
        
        let lableStackView = UIStackView(arrangedSubviews: [lable])
        lableStackView.axis = .horizontal
        lableStackView.translatesAutoresizingMaskIntoConstraints = false

        view.addSubview(stackView)
        stackView.TEanchor(top: view.topAnchor, leading: view.leadingAnchor, bottom: nil, trailing: view.trailingAnchor)
        stackView.heightAnchor.constraint(equalToConstant: 100).isActive = true

        view.addSubview(lableStackView)
        lableStackView.TEanchor(top: view.topAnchor, leading: view.leadingAnchor, bottom: nil, trailing: view.trailingAnchor, padding: .init(top: 35, left: 150, bottom: 15, right: 15))
    }
    
    
    let locationsController = LocationsCarouselController(scrollDirection: .horizontal)
    
    fileprivate func setupLocationsCarousel() {
        let locationsView = locationsController.view!
        view.addSubview(locationsView)
        locationsView.TEanchor(top: nil, leading: view.leadingAnchor, bottom: view.safeAreaLayoutGuide.bottomAnchor, trailing: view.trailingAnchor, padding: .init(top: 0, left: 16, bottom: 10, right: 16), size: .init(width: 0, height: 150))
    }
    
    fileprivate func performLocalSearch() {
        let request = MKLocalSearch.Request()
        request.naturalLanguageQuery = "Gym"
        
        let centerCoordinate = CLLocationCoordinate2D(latitude: 51.535536, longitude: -3.142308)
        let span = MKCoordinateSpan(latitudeDelta: 0.1, longitudeDelta: 0.1)
        let region = MKCoordinateRegion(center: centerCoordinate, span: span)
        request.region = region
        
        let localSearch = MKLocalSearch(request: request)
        localSearch.start { (resp, err) in
            if let err = err {
                print("unable to retrieve search", err)
            }

            self.mapView.removeAnnotations(self.mapView.annotations)
            self.locationsController.items.removeAll()
            
            resp?.mapItems.forEach({ (mapItem) in
                print(mapItem.name ?? "")
                let annotation = MKPointAnnotation()
                annotation.coordinate = mapItem.placemark.coordinate
                annotation.title = mapItem.name
                self.mapView.addAnnotation(annotation)

                self.locationsController.items.append(mapItem)
                
            })
            self.mapView.showAnnotations(self.mapView.annotations, animated: true)
        }
    }
    
    fileprivate func setupAnnotationsForMap() {
        let annotations = MKPointAnnotation()
        annotations.coordinate = CLLocationCoordinate2D(latitude: 51.535536, longitude: -3.142308)
        annotations.title = "Home"
        annotations.subtitle = "sweet home"
        mapView.addAnnotation(annotations)
        
        let spireHospital = MKPointAnnotation()
        spireHospital.coordinate = .init(latitude: 51.531330, longitude: -3.141665)
        spireHospital.title = "Spire Hospital"
        mapView.addAnnotation(spireHospital)
        mapView.showAnnotations(self.mapView.annotations, animated: true)
        
    }
    
    fileprivate func setupRegionForMap() {
        let centerCoord = CLLocationCoordinate2D(latitude: 51.535536, longitude: -3.142308)
        let span = MKCoordinateSpan(latitudeDelta: 0.1, longitudeDelta: 0.1)
        let region = MKCoordinateRegion(center: centerCoord, span: span)
        mapView.setRegion(region, animated: true)
    }
    
}

import SwiftUI

struct MainPreview: PreviewProvider {
    
    static var previews: some View {
        
        ContainerView().edgesIgnoringSafeArea(.all)
    }
    
    struct ContainerView: UIViewControllerRepresentable {
        func makeUIViewController(context: UIViewControllerRepresentableContext<MainPreview.ContainerView>) -> MainViewController {
            return MainViewController()
        }
        
        func updateUIViewController(_ uiViewController: MainViewController, context: UIViewControllerRepresentableContext<MainPreview.ContainerView>) {
            
            
        }
        
        typealias UIViewControllerType = MainViewController
    }
}
