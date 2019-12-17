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

    override var item: MKMapItem! {
        didSet {
            lable.text = item.name
            addressLable.text = item.address()
        }
    }
    let lable = UILabel(text: "location", font: .boldSystemFont(ofSize: 16))
    let addressLable = UILabel(text: "address", numberOfLines: 0)
    
    override func setupViews() {
        backgroundColor = .white
        setupShadow(opacity: 3, radius: 5, offset: .zero, color: .orange)
        layer.cornerRadius = 10
        clipsToBounds = false
        stack(lable, addressLable).withMargins(.allSides(16))
        
    }
}

class LocationsCarouselController: LBTAListController<LocationCell, MKMapItem > {

    weak var mainController: MainViewController?

    override func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        print(self.items[indexPath.item].name ?? "") // this is our reference for which name to display

        let annotations = mainController?.mapView.annotations
        annotations?.forEach({ (annotation) in
            if annotation.title == self.items[indexPath.item].name {
                mainController?.mapView.selectAnnotation(annotation, animated: true)
            }
        })

        collectionView.scrollToItem(at: indexPath, at: .centeredHorizontally, animated: true)
        
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        
        collectionView.clipsToBounds = false
        collectionView.backgroundColor = .clear
        let placeMark = MKPlacemark(coordinate: .init(latitude: 10, longitude: 55))
        let dummyCell = MKMapItem.init(placemark: placeMark)
        dummyCell.name = "dummy location"
        self.items = [dummyCell]
    }
}

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

