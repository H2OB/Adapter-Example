//
//  AdapterRowCell.swift
//  TableViewHelper
//
//  Created by 杨涛 on 2022/1/8.
//

import Foundation
import UIKit

// MARK: -- Cell基类
open class AdapterRowCell : UITableViewCell {
    
    /// 行模型 子类需重写
    open var node: AdapterRow!
    
    required public override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        setUp()
    }
    
    required public init?(coder: NSCoder) {
        super.init(coder: coder)
        
    }
    
    open override func awakeFromNib() {
        super.awakeFromNib()
        
        setUp()
    }
    
    
    /// 设置
    open func setUp() {
        
    }
    
    /// 将要出现
    open func willDisplay(){
        
    }
    
    /// 已经消失
    open func didEndDisplaying(){
        
    }
    
}
