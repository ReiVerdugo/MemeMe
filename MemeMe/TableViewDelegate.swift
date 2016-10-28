//
//  TableViewDelegate.swift
//  AMS.Seven
//
//  Created by devstn5 on 2016-10-06.
//  Copyright © 2016 Solsteace. All rights reserved.
//

import UIKit

class TableViewDelegate: NSObject, UITableViewDelegate {

    var didSelectBlock : DidSelectCellBlock = {_ in }
    var headerView : UIView?
    var headerIdentifier = ""
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        self.didSelectBlock(indexPath)
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        if headerIdentifier != "" {
            let headerCell = tableView.dequeueReusableCell(withIdentifier: headerIdentifier)
            return headerCell
        } else {
            return nil
        }
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        if headerIdentifier != "" {
            return 50
        } else {
            return 0
        }
    }
    
    
}
