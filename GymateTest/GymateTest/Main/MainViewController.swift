//
//  MainViewController.swift
//  GymateTest
//
//  Created by Richard Price on 03/12/2019.
//  Copyright © 2019 twisted echo. All rights reserved.
//



import UIKit
import MapKit
//MARK:- step 3 import LBTA tools from https://github.com/bhlvoong/LBTATools
import LBTATools

//MARK:- step 2 create the main controller and import mapkit
class MainViewController: UIViewController {
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let mapView = MKMapView()
        view.addSubview(mapView)
        
        //MARK:- Step 4 fill super view to pin map
        mapView.fillSuperview()

        view.backgroundColor = .blue
        
    }
}
