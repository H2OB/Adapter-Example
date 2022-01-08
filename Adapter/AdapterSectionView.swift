//
//  AdapterSectionView.swift
//  TableViewHelper
//
//  Created by 杨涛 on 2022/1/8.
//

import Foundation
import UIKit

// MARK: -- 分区视图基类
class AdapterSectionView: UIView {
    
    /// 数据 子类需重写
    var data:Any?
    
    required override init(frame: CGRect) {
        super.init(frame: frame)
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
