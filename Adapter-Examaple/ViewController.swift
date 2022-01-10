//
//  ViewController.swift
//  TableViewHelper
//
//  Created by 杨涛 on 2021/11/2.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var tableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setUpView()
        
        refresh()
    
    }
    
    func setUpView() {
        
        tableView.register(UINib(nibName: "CustomCell", bundle:nil), forCellReuseIdentifier: "CustomCell")
        
        tableView.didSelectRow = { row in
           
            row.cellHeight += row.cellHeight
            row.tableView.beginUpdates()
            row.tableView.endUpdates()
           
        }
        
    
    }
    
    @IBAction func refreshAction(_ sender: Any) {
        
        refresh()
    }
    
    func refresh(){
        
        // diff算法唯一标识Set
        var diffIds = Set<Int>()
        
        // 分区
        let section = AdapterSection(0)
        
        // 分区里的行数据
        var array = [AdapterRow]()
        
        for _ in 0..<15 {
            
            // 随机生成算法唯一标识
            var diffId = Int.random(in: 0...50)
            
            // 防重复
            while diffIds.contains(diffId) {
                
                diffId = Int(arc4random() % 50)
            }
            
            let row = AdapterRow(differenceId: diffId, identifier: "CustomCell", orginal: "\(diffId)")
            
            array.append(row)
            
            diffIds.insert(diffId)
        }
      
        tableView.dataInput = [DiffSection(model: section, elements: array)]
        
    }
    
    
    deinit {
        
        print("deinit")
    }
    
}

