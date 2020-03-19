//
//  DirectionsController.swift
//  GymateTest
//
//  Created by Richard Price on 20/02/2020.
//  Copyright © 2020 twisted echo. All rights reserved.
//

import UIKit
import MapKit
import SwiftUI

class DirectionsController: UIViewController, MKMapViewDelegate {
    
    let mapView = MKMapView()
    let navBar = UIView(backgroundColor: #colorLiteral(red: 0.1219913736, green: 0.5641101003, blue: 0.9661875367, alpha: 1))
    
    override func viewDidLoad() {
        super.viewDidLoad()
        //step 4 - set the mapview delegate to self and add into your class above
        mapView.delegate = self
        view.addSubview(mapView)
        setupRegionForMap()
        setupNavbarUI()
        mapView.TEanchor(top: navBar.bottomAnchor, leading: view.leadingAnchor, bottom: view.bottomAnchor, trailing: view.trailingAnchor)
        mapView.showsUserLocation = true
        setupStartEndDummyAnnotations()
        //step1 create function
        requestForDirections()
    }
    
    fileprivate func requestForDirections() {
        //step 2 implement a request a make a call
        let request = MKDirections.Request()
        let startingPlaceMark = MKPlacemark(coordinate: .init(latitude: 51.535536, longitude: -3.142308))
        let endingPlaceMark = MKPlacemark(coordinate: .init(latitude: 51.483850, longitude: -3.176807))
        request.source = .init(placemark: startingPlaceMark)
        request.destination = .init(placemark: endingPlaceMark)
        let directions = MKDirections(request: request)
        directions.calculate { (resp, err) in
            if let err = err {
                print("failed to get routing err", err)
                return
            }

            //step 3 - success get polyline, ready for rendering
            print("found routing directions")
            guard let route = resp?.routes.first else {return}
            self.mapView.addOverlay(route.polyline)
            
        }
        
    }
    
    //step 5 - render the polyline to the map with "renderer for overlay"
    func mapView(_ mapView: MKMapView, rendererFor overlay: MKOverlay) -> MKOverlayRenderer {
        //create a poly line renderer
        let polylineRenderer = MKPolylineRenderer(overlay: overlay)
        polylineRenderer.strokeColor = .red
        polylineRenderer.lineWidth = 5
        return polylineRenderer
    }
    

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
    
    fileprivate func setupNavbarUI() {
        
        navBar.TEsetupShadow(opacity: 1, radius: 5)
        view.addSubview(navBar)
        navBar.TEanchor(top: view.topAnchor, leading: view.leadingAnchor, bottom: view.safeAreaLayoutGuide.topAnchor, trailing: view.trailingAnchor, padding: .init(top: 0, left: 0, bottom: -100, right: 0))
    }
    fileprivate func setupRegionForMap() {
        let centerCoord = CLLocationCoordinate2D(latitude: 51.535536, longitude: -3.142308)
        let span = MKCoordinateSpan(latitudeDelta: 0.1, longitudeDelta: 0.1)
        let region = MKCoordinateRegion(center: centerCoord, span: span)
        mapView.setRegion(region, animated: true)
    }
}

struct DirectionsPreview: PreviewProvider {
    static var previews: some View {
        ContainerView().edgesIgnoringSafeArea(.all)
    }
    
    struct ContainerView: UIViewControllerRepresentable {
        
        func makeUIViewController(context: UIViewControllerRepresentableContext<DirectionsPreview.ContainerView>) -> UIViewController {
            DirectionsController()
        }
        
        func updateUIViewController(_ uiViewController: DirectionsPreview.ContainerView.UIViewControllerType, context: UIViewControllerRepresentableContext<DirectionsPreview.ContainerView>) {
            
        }
    }
}

