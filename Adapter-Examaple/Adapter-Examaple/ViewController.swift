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
        
        var dataInput = [DiffSection]()
        
        var IDs = Set<Int>()
        let section = AdapterSection(0)
        var array = [AdapterRow]()
        
        for _ in 0..<15 {
            
            var id = Int(arc4random() % 50)
            
            while IDs.contains(id) {
                id = Int(arc4random() % 50)
            }
            
            array.append(AdapterRow(diffID:id,orginal: "\(id)", identifier: "CustomCell",50))
            
            IDs.insert(id)
        }
      
        dataInput.append(DiffSection(model: section, elements: array))
        
        tableView.dataInput = dataInput
        
    }
    
    
    deinit {
        
        print("deinit")
    }
    
}

