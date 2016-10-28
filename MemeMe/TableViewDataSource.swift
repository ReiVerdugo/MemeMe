//
//  ArrayDataSource.swift
//  Akiztamed
//
//  Created by devstn6 on 2016-07-12.
//  Copyright © 2016 Solsteace. All rights reserved.
//

import UIKit

typealias TableViewCellConfigureBlock = (_ cell: AnyObject, _ item: AnyObject) -> Void
typealias EditingStyleBlock = (_ indexPath : IndexPath) -> Void

class TableViewDataSource: NSObject,UITableViewDataSource {
    
    var items = [AnyObject]()
    var cellIdentifier = ""
    var configureCellBlock: TableViewCellConfigureBlock = {_,_ in }

    override init() {
        super.init()
    }
    
    
    init(anItems:Array<AnyObject>, cellIdentifier:String, aconfigureCellBlocks: @escaping (TableViewCellConfigureBlock)){
        
        self.items = anItems
        self.cellIdentifier = cellIdentifier
        self.configureCellBlock = aconfigureCellBlocks
    }
    
    func itemAtIndexPath(_ indexPath: IndexPath) -> AnyObject{
        
        return items[(indexPath as NSIndexPath).row]
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return items.count
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: cellIdentifier, for: indexPath)
        let item = self.itemAtIndexPath(indexPath)
        self.configureCellBlock(cell, item)
        return cell
    }
    
}
