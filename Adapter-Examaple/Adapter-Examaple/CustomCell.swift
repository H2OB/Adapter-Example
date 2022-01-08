//
//  CustomCell.swift
//  TableViewHelper
//
//  Created by 杨涛 on 2021/11/27.
//

import UIKit

class CustomCell: AdapterRowCell {
    
    
    @IBOutlet weak var titleLabel: UILabel!
    override var node: AdapterRow! {
        didSet {
            if let index = node.orginal as? String {
                titleLabel.text = index
            }
        }
    }

   
    @IBAction func deleteBtnAction(_ sender: Any) {
        
        if let index =  node.tableView.indexPath(for: self) {
            node.tableView.dataInput[index.section].elements.remove(at: index.row)
        }
        
    }
    
}
