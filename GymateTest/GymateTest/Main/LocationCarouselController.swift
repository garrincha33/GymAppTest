//
//  LocationCarouselController.swift
//  GymateTest
//
//  Created by Richard Price on 08/12/2019.
//  Copyright © 2019 twisted echo. All rights reserved.
//

import UIKit
import LBTATools

//MARK: step 2 use LBTA generics to create a horizontal scrolling collection view, first create a location cell
class LocationCell: LBTAListCell<String> {
    override func setupViews() {
        backgroundColor = .yellow
        //MARK: step 9 setup shadow and corner round
        setupShadow(opacity: 3, radius: 5, offset: .zero, color: .black)
        layer.cornerRadius = 10
        clipsToBounds = false
    }
}
//MARK: step 3 create annother class for the crousel using the cell
class LocationsCarouselController: LBTAListController<LocationCell, String>, UICollectionViewDelegateFlowLayout {
    
    //MARK: step 6 implement delegate flow layout for size of cell with peeking cell
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return .init(width: view.frame.width - 64, height: view.frame.height)
    }
    
    //MARK:- step 7 create an inset
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        return .init(top: 0, left: 16, bottom: 0, right: 16)
    }
    //MARK:- make gap bigger on cells with line spacing
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 24
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        //MARK:- step 8 cmake clear bg
        //MARK: step 9 setup shadow and corner round
        collectionView.clipsToBounds = false
        collectionView.backgroundColor = .clear
        self.items = ["1", "2", "3"]
    }
}


