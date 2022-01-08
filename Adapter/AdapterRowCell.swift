//
//  AdapterRowCell.swift
//  TableViewHelper
//
//  Created by 杨涛 on 2022/1/8.
//

import Foundation
import UIKit

// MARK: -- Cell基类
class AdapterRowCell : UITableViewCell {
    
    /// 行模型 子类需重写
    var node: AdapterRow!
    
    required override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        setUp()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)

    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        setUp()
    }
    
    
    /// 设置
    func setUp() {
        
    }
    
    /// 将要出现
    func willDisplay(){
        
    }
    
    /// 已经消失
    func didEndDisplaying(){
        
    }
    
}
