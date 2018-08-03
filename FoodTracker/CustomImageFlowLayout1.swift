//
//  CustomImageFlowLayout1.swift
//  FoodTracker
//
//  Created by PARKHASIK on 2017. 11. 21..
//  Copyright © 2017년 Apple Inc. All rights reserved.
//

import UIKit

class CustomImageFlowLayout1: UICollectionViewFlowLayout {
    override init() {
        super .init()
        setupLayout()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder:aDecoder)
        setupLayout()
    }
    
    override var itemSize: CGSize{
        set{}
        get{
            let numberOfColumns: CGFloat = 3
            
            let itemWidth = (self.collectionView!.frame.width - (numberOfColumns-1)) / numberOfColumns
            return CGSize(width: itemWidth, height: itemWidth)
        }
    }
    
    func setupLayout(){
        minimumInteritemSpacing = 1
        minimumLineSpacing = 1
        scrollDirection = .vertical
    }
}
