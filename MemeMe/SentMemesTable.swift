//
//  SentMemesTable.swift
//  MemeMe
//
//  Created by Reinaldo Verdugo on 26/10/16.
//  Copyright © 2016 Reinaldo Verdugo. All rights reserved.
//

import UIKit

class SentMemesTable: UIViewController {

    
    @IBOutlet weak var tableView: UITableView!
    var memes: [Meme] {
        return (UIApplication.shared.delegate as! AppDelegate).memes
    }
    var tableDelegate = TableViewDelegate()
    var tableDataSource = TableViewDataSource()
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewWillAppear(true)
        setTable()
        tableView.reloadData()
    }
    
    func setTable () {
        let configureCell: TableViewCellConfigureBlock = {cell,meme in
            let cell = cell as! TableCell
            let meme = meme as! Meme
            cell.memeImage.image = meme.memedImage
            cell.memeText.text = meme.text
        }
        tableDataSource = TableViewDataSource(anItems: memes as Array<AnyObject>, cellIdentifier: "memeTableCell", aconfigureCellBlocks: configureCell)
        tableDelegate.didSelectBlock = {indexPath in self.didSelectMethod(indexPath as IndexPath)}
        tableView.dataSource = tableDataSource
        tableView.delegate = tableDelegate
    }
    
    func didSelectMethod(_ indexPath : IndexPath) {
        
    }

}
