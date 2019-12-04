//
//  MainViewController.swift
//  GymateTest
//
//  Created by Richard Price on 03/12/2019.
//  Copyright © 2019 twisted echo. All rights reserved.
//

//MARK:- Step 1 import pin icon

import UIKit
import MapKit
import LBTATools

//MARK:- step 4 extension of mapview for manual drawing of pins
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
        
        //MARK:- step 5 manually draw pins with a delegate
        mapView.delegate = self
        
        view.addSubview(mapView)
        mapView.fillSuperview()
        setupRegionForMap()
        //MARK:- Step 2 setupAnnotations
        setupAnnotationsForMap()
        
    }
    //MARK:- Step 2 setupAnnotations
    fileprivate func setupAnnotationsForMap() {
        let annotations = MKPointAnnotation()
        annotations.coordinate = CLLocationCoordinate2D(latitude: 51.535536, longitude: -3.142308)
        annotations.title = "Home"
        annotations.subtitle = "sweet home"
        mapView.addAnnotation(annotations)
        
        //MARK:- Step 3 show more than 1 pin on the map
        let spireHospital = MKPointAnnotation()
        spireHospital.coordinate = .init(latitude: 51.531330, longitude: -3.141665)
        spireHospital.title = "Spire Hospital"
        mapView.addAnnotation(spireHospital)
        //show all
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
