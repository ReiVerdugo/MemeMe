//
//  SentMemesCollection.swift
//  MemeMe
//
//  Created by Reinaldo Verdugo on 26/10/16.
//  Copyright © 2016 Reinaldo Verdugo. All rights reserved.
//

import UIKit

class SentMemesCollection: UIViewController {
    
    @IBOutlet weak var collectionView: UICollectionView!
    @IBOutlet weak var collectionFlowLayout: UICollectionViewFlowLayout!
    
    var memes: [Meme] {
        return (UIApplication.shared.delegate as! AppDelegate).memes
    }
    var collectionDelegate = CollectionViewDelegate()
    var collectionDataSource = CollectionViewDataSource()
    
    override func viewDidLoad() {
        super.viewDidLoad()
//        let space: CGFloat = 3.0
//        let dimension = (view.frame.size.width - (2 * space)) / 3.0
//        
//        collectionFlowLayout.minimumInteritemSpacing = space
//        collectionFlowLayout.itemSize = CGSize(width: dimension, height: dimension)
    }
    
    func setTable () {
        let configureCell: CollectionViewCellConfigureBlock = {cell,meme in
            let cell = cell as! CollectionCell
            let meme = meme as! Meme
            cell.memeImage.image = meme.memedImage
        }
        
        collectionDataSource = CollectionViewDataSource(anItems: memes as Array<AnyObject>, cellIdentifier: "memeCollectionCell", aconfigureCellBlocks: configureCell)
        collectionDelegate.didSelectBlock = {indexPath in self.didSelectMethod(indexPath as IndexPath)}
        collectionView.dataSource = collectionDataSource
        collectionView.delegate = collectionDelegate
    }
    
    func didSelectMethod(_ indexPath : IndexPath) {
        
    }


}
