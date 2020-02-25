//
//  DirectionsController.swift
//  GymateTest
//
//  Created by Richard Price on 20/02/2020.
//  Copyright © 2020 twisted echo. All rights reserved.
//

//MARK:- Step 1 create a new view controller for directions

import UIKit
import LBTATools
import MapKit
import SwiftUI


//MARK:- Step 2 create a class called Directions Controller with a mapview
class DirectionsController: UIViewController {
    
    let mapView = MKMapView()
    let navBar = UIView(backgroundColor: #colorLiteral(red: 0.1219913736, green: 0.5641101003, blue: 0.9661875367, alpha: 1))
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.addSubview(mapView)
        //MARK:- step 6 call function
        setupRegionForMap()
        //MARK:- step 7 setup navBarUI
        setupNavbarUI()
        mapView.anchor(top: navBar.bottomAnchor, leading: view.leadingAnchor, bottom: view.bottomAnchor, trailing: view.trailingAnchor)
        mapView.showsUserLocation = true
        setupStartEndDummyAnnotations()
    }
    //MARK:- step 8 setup some dummy annotaions
    fileprivate func setupStartEndDummyAnnotations() {
        let startAnnotations = MKPointAnnotation()
        startAnnotations.coordinate = .init(latitude: 51.535536, longitude: -3.142308)
        startAnnotations.title = "Start"
        
        let endAnnotation = MKPointAnnotation()
        endAnnotation.coordinate = .init(latitude: 51.483850, longitude: -3.176807)
        endAnnotation.title = "End"
        
        mapView.addAnnotation(startAnnotations)
        mapView.addAnnotation(endAnnotation)
        
        mapView.showAnnotations(mapView.annotations, animated: true)
    }
    
    //MARK:- step 7 setup navBarUI
    fileprivate func setupNavbarUI() {
        
        navBar.setupShadow(opacity: 1, radius: 5)
        view.addSubview(navBar)
        navBar.anchor(top: view.topAnchor, leading: view.leadingAnchor, bottom: view.safeAreaLayoutGuide.topAnchor, trailing: view.trailingAnchor, padding: .init(top: 0, left: 0, bottom: -100, right: 0))
    }
    
    //MARK:- step 5 setup region for map only works in simulator
    fileprivate func setupRegionForMap() {
        let centerCoord = CLLocationCoordinate2D(latitude: 51.535536, longitude: -3.142308)
        let span = MKCoordinateSpan(latitudeDelta: 0.1, longitudeDelta: 0.1)
        let region = MKCoordinateRegion(center: centerCoord, span: span)
        mapView.setRegion(region, animated: true)
    }
}

//MARK:- step 3 create the swiftUI preview struct Direciotns Preview
struct DirectionsPreview: PreviewProvider {
    static var previews: some View {
        ContainerView().edgesIgnoringSafeArea(.all)
    }
    //MARK:- step 4 create the Container view inside with 2 functions
    struct ContainerView: UIViewControllerRepresentable {
        
        func makeUIViewController(context: UIViewControllerRepresentableContext<DirectionsPreview.ContainerView>) -> UIViewController {
            DirectionsController()
        }
        
        func updateUIViewController(_ uiViewController: DirectionsPreview.ContainerView.UIViewControllerType, context: UIViewControllerRepresentableContext<DirectionsPreview.ContainerView>) {
            
        }
    }
}

