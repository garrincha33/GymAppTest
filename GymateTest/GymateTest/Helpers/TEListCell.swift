//
//  TEListCell.swift
//  GymateTest
//
//  Created by Richard Price on 06/03/2020.
//  Copyright © 2020 twisted echo. All rights reserved.
//

import UIKit

class TEListCell<T>: UICollectionViewCell {
    
    /// item automatically pulls from TEListHeaderController
    open var item: T!
    
    /// parentController is set to the ListHeaderController that is rendering this cell
    open weak var parentController: UIViewController?
    
    /// in most cases you will use a seperator in a view
    public let TEseparatorView = UIView(backgroundColor: UIColor(white: 0.6, alpha: 0.5))
    
    /// seperator setup with left padding
    open func addSeparatorView(leftPadding: CGFloat = 0) {
        addSubview(TEseparatorView)
        TEseparatorView.TEanchor(top: nil, leading: leadingAnchor, bottom: bottomAnchor, trailing: trailingAnchor, padding: .init(top: 0, left: leftPadding, bottom: 0, right: 0), size: .init(width: 0, height: 0.5))
    }
    /// seperator anchored to leading anchor
    open func addSeparatorView(leadingAnchor: NSLayoutXAxisAnchor) {
        addSubview(TEseparatorView)
        TEseparatorView.TEanchor(top: nil, leading: leadingAnchor, bottom: bottomAnchor, trailing: trailingAnchor, size: .init(width: 0, height: 0.5))
    }
    
    override public init(frame: CGRect) {
        super.init(frame: frame)
        setupViews()
    }
    
    /// In your custom ListCell classes,  override setupViews() to provide custom behavior.  We do this to avoid overriding init methods.
    open func setupViews() {}
    
    required public init?(coder aDecoder: NSCoder) {
        fatalError()
    }
}


