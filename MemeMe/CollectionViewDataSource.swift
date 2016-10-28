//
//  CollectionViewDataSource.swift
//  Akiztamed
//
//  Created by devstn5 on 2016-07-26.
//  Copyright © 2016 Solsteace. All rights reserved.
//

import UIKit

typealias CollectionViewCellConfigureBlock = (_ cell: AnyObject, _ item: AnyObject) -> Void

class CollectionViewDataSource: NSObject, UICollectionViewDataSource, UICollectionViewDelegate {
    
    var items = [AnyObject]()
    var cellIdentifier = ""
    var configureCellBlock: CollectionViewCellConfigureBlock = {_,_ in }
    
    override init() {
        super.init()
    }
    
    // Initializes datasource with cell's configuration
    init(anItems:Array<AnyObject>, cellIdentifier:String, aconfigureCellBlocks: @escaping (CollectionViewCellConfigureBlock)){
        
        self.items = anItems
        self.cellIdentifier = cellIdentifier
        self.configureCellBlock = aconfigureCellBlocks
    }
    
    // Sets the item at a given index path
    func itemAtIndexPath(_ indexPath: IndexPath) -> AnyObject{
        return items[indexPath.row]
    }
    
    // Sets the number of items in section

    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return items.count
    }
    
    // Uses the closure to configure the cells
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: cellIdentifier, for: indexPath)
        let item = self.itemAtIndexPath(indexPath)
        self.configureCellBlock(cell, item)
        return cell
    }
}
