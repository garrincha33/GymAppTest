//
//  MainViewController.swift
//  GymateTest
//
//  Created by Richard Price on 03/12/2019.
//  Copyright © 2019 twisted echo. All rights reserved.
//

import UIKit
import MapKit
import LBTATools

extension MainViewController: MKMapViewDelegate {
    func mapView(_ mapView: MKMapView, viewFor annotation: MKAnnotation) -> MKAnnotationView? {
        let anotationView = MKPinAnnotationView(annotation: annotation, reuseIdentifier: "id")
        anotationView.canShowCallout = true
        anotationView.image = #imageLiteral(resourceName: "GYmPinSmall")
        return anotationView
    }
}

class MainViewController: UIViewController {

    let mapView = MKMapView()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        mapView.delegate = self
        view.addSubview(mapView)
        mapView.fillSuperview()
        setupRegionForMap()
        performLocalSearch()
        //MARK: step 5 call function
        setupLocationsCarousel()
    }
    
    //MARK: step 4 call outside view didload
    let locationsController = LocationsCarouselController(scrollDirection: .horizontal)
    
    //MARK: step 1 create setup locations carosuel function
    fileprivate func setupLocationsCarousel() {
        //MARK: step 4 call outside view didload
        let locationsView = locationsController.view!
        
        //MARK: step 1 (comment out after  generics implemnted)
//        let locationsView = UIView(backgroundColor: .red)
        view.addSubview(locationsView)
        locationsView.anchor(top: nil, leading: view.leadingAnchor, bottom: view.safeAreaLayoutGuide.bottomAnchor, trailing: view.trailingAnchor, padding: .init(top: 0, left: 16, bottom: 0, right: 16), size: .init(width: 0, height: 150))
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

            resp?.mapItems.forEach({ (mapItem) in
                print(mapItem.name ?? "")
                let annotation = MKPointAnnotation()
                annotation.coordinate = mapItem.placemark.coordinate
                annotation.title = mapItem.name
                self.mapView.addAnnotation(annotation)
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
