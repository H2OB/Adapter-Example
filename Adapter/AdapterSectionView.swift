//
//  AdapterSectionView.swift
//  TableViewHelper
//
//  Created by 杨涛 on 2022/1/8.
//

import Foundation
import UIKit

// MARK: -- 分区视图基类
open class AdapterSectionView: UITableViewHeaderFooterView {
    
    /// 数据 子类需重写
    open var data:Any?
    
    required public override init(reuseIdentifier: String?) {
        super.init(reuseIdentifier: reuseIdentifier)
        
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
