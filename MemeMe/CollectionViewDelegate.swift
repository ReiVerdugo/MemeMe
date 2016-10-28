//
//  CollectionViewDelegate.swift
//  AirbnbApp
//
//  Created by devstn5 on 2016-09-19.
//  Copyright © 2016 NextDots. All rights reserved.
//

import UIKit


typealias DidSelectCellBlock = (_ indexPath : IndexPath) -> Void

class CollectionViewDelegate: NSObject, UICollectionViewDelegate {
    
    var didSelectBlock : DidSelectCellBlock = {_ in }
    var width : CGFloat = 0.33
    var height : CGFloat = 0.3
    
    // Sets the layout of the collectionview items. Uses widht and height as parameters. Their values corresponds to device's orientation
    func collectionView(_ collectionView : UICollectionView, layout: UICollectionViewLayout, sizeForItemAt: IndexPath) -> CGSize {
        return CGSize(width: collectionView.bounds.size.width * width, height: collectionView.bounds.size.height * height)
    }
    
    // Uses the given closure to set the method when selecting an index path
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        self.didSelectBlock(indexPath)
    }
    
}
