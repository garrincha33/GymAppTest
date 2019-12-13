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
        title = "test"
        mapView.delegate = self
        view.addSubview(mapView)
        mapView.fillSuperview()
        setupRegionForMap()
        performLocalSearch()
        setupLocationsCarousel()
        setupNavBar()
        //MARK:- step 11 set yor delegate to self, currently unset (or nil) in your locationscontroller
        locationsController.mainController = self
    }
    
    //MARK:- step 2 setup a black nav bar with lable, needs refactoring
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
        stackView.anchor(top: view.topAnchor, leading: view.leadingAnchor, bottom: nil, trailing: view.trailingAnchor)
        stackView.heightAnchor.constraint(equalToConstant: 100).isActive = true
        
        
        view.addSubview(lableStackView)
        lableStackView.anchor(top: view.topAnchor, leading: view.leadingAnchor, bottom: nil, trailing: view.trailingAnchor, padding: .init(top: 35, left: 150, bottom: 15, right: 15))
    }
    
    
    let locationsController = LocationsCarouselController(scrollDirection: .horizontal)
    
    fileprivate func setupLocationsCarousel() {
        
        let locationsView = locationsController.view!
        //        let locationsView = UIView(backgroundColor: .red)
        view.addSubview(locationsView)
        locationsView.anchor(top: nil, leading: view.leadingAnchor, bottom: view.safeAreaLayoutGuide.bottomAnchor, trailing: view.trailingAnchor, padding: .init(top: 0, left: 16, bottom: 10, right: 16), size: .init(width: 0, height: 150))
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
            //MARK:- step 6 remove old annotations and items
            self.mapView.removeAnnotations(self.mapView.annotations)
            self.locationsController.items.removeAll()
            
            resp?.mapItems.forEach({ (mapItem) in
                print(mapItem.name ?? "")
                let annotation = MKPointAnnotation()
                annotation.coordinate = mapItem.placemark.coordinate
                annotation.title = mapItem.name
                self.mapView.addAnnotation(annotation)
                
                //MARK:- step 7 tell foreach loop which map items to display
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
