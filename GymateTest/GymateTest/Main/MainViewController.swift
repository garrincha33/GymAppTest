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

class MainViewController: UIViewController {

    //MARK:- step 4 move map view to gloabal
    let mapView = MKMapView()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.addSubview(mapView)
        mapView.fillSuperview()
        //MARK:- step 5 setup region for map
        setupRegionForMap()
        
    }
    
    //MARK:- step 4 setup region for map
    fileprivate func setupRegionForMap() {
        let centerCoord = CLLocationCoordinate2D(latitude: 51.538368, longitude: -3.205172)
        let span = MKCoordinateSpan(latitudeDelta: 0.1, longitudeDelta: 0.1)
        let region = MKCoordinateRegion(center: centerCoord, span: span)
        mapView.setRegion(region, animated: true)

    }
    
}

//MARK:- step 1 import swift UI and create MainPreview with provider

import SwiftUI

struct MainPreview: PreviewProvider {

    static var previews: some View {
        //MARK:- step 3 add ignore safe area
        ContainerView().edgesIgnoringSafeArea(.all)
    }
    
    //MARK:- step 2 create another struct Container view, once you have that use make ui view controller
    
    struct ContainerView: UIViewControllerRepresentable {
        func makeUIViewController(context: UIViewControllerRepresentableContext<MainPreview.ContainerView>) -> MainViewController {
            return MainViewController()
        }
        
        func updateUIViewController(_ uiViewController: MainViewController, context: UIViewControllerRepresentableContext<MainPreview.ContainerView>) {
            
            
        }
        
        typealias UIViewControllerType = MainViewController
    }
}
