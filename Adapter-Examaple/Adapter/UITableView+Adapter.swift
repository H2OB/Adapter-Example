//
//  UITableView+Extension.swift
//  TableViewHelper
//
//  Created by 杨涛 on 2022/1/8.
//

import Foundation
import UIKit


// MARK: -- 关联对象
// tips 只能用关联对象来确保唯一性
extension UITableView {
    
    private struct AssociatedKeys {
        static var AdapterKey = "AdapterKey"
    }
    
    var adapter:Adapter {
        
        //获取关联
        var value = objc_getAssociatedObject(self, &AssociatedKeys.AdapterKey) as? Adapter
        
        //不存在就初始化一个
        if value == nil {
            
            //初始化
            value = Adapter(self)
            
            //关联
            objc_setAssociatedObject(self, &AssociatedKeys.AdapterKey, value, .OBJC_ASSOCIATION_RETAIN_NONATOMIC)
            
        }
        
        return value!
        
    }
    
    /// 数据
    var dataArray: [DiffSection] {
        
        set {
            adapter.dataArray = newValue
        }
        
        get {
            
            return adapter.dataArray
        }
    }
    
    var dataInput: [DiffSection] {
        
        set {
            adapter.dataInput = newValue
        }
        
        get {
            
            return adapter.dataInput
        }
        
    }
    
    ///  点击row事件
    var didSelectRow:SelectCallback? {
        
        set {
            adapter.didSelectRow = newValue
        }
        
        get {
            
            return adapter.didSelectRow
        }
    }
    
    ///  rown内部事件
    var insideAction:InsideCallback? {
        
        set {
            adapter.insideAction = newValue
        }
        
        get {
            
            return adapter.insideAction
        }
    }
    
}

