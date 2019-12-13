//
//  LocationCarouselController.swift
//  GymateTest
//
//  Created by Richard Price on 08/12/2019.
//  Copyright © 2019 twisted echo. All rights reserved.
//

import UIKit
import LBTATools
import MapKit

class LocationCell: LBTAListCell<MKMapItem> {
    
    //MARK: Step 5 set your didset for when your item cell is passed in
    override var item: MKMapItem! {
        didSet {
            lable.text = item.name
            addressLable.text = item.address()
        }
    }
    
    //MARK: Step 3 create a lable and stack it
    let lable = UILabel(text: "location", font: .boldSystemFont(ofSize: 16))
    let addressLable = UILabel(text: "address", numberOfLines: 0)
    
    override func setupViews() {
        backgroundColor = .white
        setupShadow(opacity: 3, radius: 5, offset: .zero, color: .orange)
        layer.cornerRadius = 10
        clipsToBounds = false
        //MARK: Step 3 create a lable and stack it
        stack(lable, addressLable).withMargins(.allSides(16))
        
    }
}

class LocationsCarouselController: LBTAListController<LocationCell, MKMapItem > {
    
    //MARK:- step 9 create a reference to the mainController with a weak to prevent retain syscles
    weak var mainController: MainViewController?
    
    //MARK: step 8 add abilty to click on items and cetner to annoation
    override func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        print(self.items[indexPath.item].name ?? "") // this is our reference for which name to display
        //MARK:- step 10 centering on annotations
        let annotations = mainController?.mapView.annotations
        annotations?.forEach({ (annotation) in
            if annotation.title == self.items[indexPath.item].name {
                mainController?.mapView.selectAnnotation(annotation, animated: true)
            }
        })
        
        //MARK:- step 12 adjust where the carousel displays after clicking on an annotation
        collectionView.scrollToItem(at: indexPath, at: .centeredHorizontally, animated: true)
        
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        collectionView.clipsToBounds = false
        collectionView.backgroundColor = .clear
        //MARK: Step 4 create a dummy item cahnge cell types to a mkmpaitem
        let placeMark = MKPlacemark(coordinate: .init(latitude: 10, longitude: 55))
        let dummyCell = MKMapItem.init(placemark: placeMark)
        dummyCell.name = "dummy location"
        self.items = [dummyCell]
    }
}

//MARK:- step 1 create an extension for cleaner code
extension LocationsCarouselController: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return .init(width: view.frame.width - 64, height: view.frame.height)
    }

    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        return .init(top: 0, left: 16, bottom: 0, right: 16)
    }

    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 24
    }
}

