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
private extension UITableView {
    
    private struct AssociatedKeys {
        static var AdapterKey = "AdapterKey"
    }
    
    private var adapter:Adapter {
        
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
}

extension UITableView {
    
    /// 数据
    public var dataArray: [DiffSection] {
        
        set {
            adapter.dataArray = newValue
        }
        
        get {
            
            return adapter.dataArray
        }
    }
    
    public var dataInput: [DiffSection] {
        
        set {
            adapter.dataInput = newValue
        }
        
        get {
            
            return adapter.dataInput
        }
        
    }
    
    ///  点击row事件
    public var didSelectRow:SelectCallback? {
        
        set {
            adapter.didSelectRow = newValue
        }
        
        get {
            
            return adapter.didSelectRow
        }
    }
    
    ///  rown内部事件
    public var insideAction:InsideCallback? {
        
        set {
            adapter.insideAction = newValue
        }
        
        get {
            
            return adapter.insideAction
        }
    }
    
    /// 预加载
    public var prefetchCallback:Prefetchback? {
        
        set {
            adapter.prefetchCallback = newValue
        }
        
        get {
            
            return adapter.prefetchCallback
        }
    }
    
    /// 取消预加载
    public var cancelPrefetchCallback:Prefetchback? {
        
        set {
            adapter.cancelPrefetchCallback = newValue
        }
        
        get {
            
            return adapter.cancelPrefetchCallback
        }
    }
    
}

