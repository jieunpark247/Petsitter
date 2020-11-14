//
//  CameraCollectionViewCell.swift
//  FoodTracker
//
//  Created by PARKHASIK on 2017. 11. 22..
//  Copyright © 2017년 Apple Inc. All rights reserved.
//

import UIKit

class CameraCollectionViewCell: UICollectionViewCell {
    
    @IBOutlet weak var imageView: UIImageView!
        
        override func prepareForReuse() {
            super.prepareForReuse()
            self.imageView.image=nil
        }
    }


