//
//  AdapterRow.swift
//  TableViewHelper
//
//  Created by 杨涛 on 2022/1/8.
//

import Foundation
import UIKit
import DifferenceKit

// MARK: -- 行基类
open class AdapterRow {
    
    /// difference算法的唯一标识
    public var differenceId:Int = 0
    
    /// 原始数据
    open var orginal: Any?
    
    /// 复用唯一标识
    open var identifier : String
    
    /// 行高
    open var cellHeight : CGFloat = 0
    
    /// 是否选中
    public var isSelected : Bool = false
    
    /// 是否允许交互
    public var isUserInteractionEnabled : Bool = true
    
    /// 点击回调
    public var didSelected:SelectCallback?
    
    /// 内部回调
    public var insideAction:InsideCallback?
    
    /// 所在tableView
    public weak var tableView:UITableView!
    
    
    /// 初始化
    /// - Parameters:
    ///   - orginal: 原始数据
    ///   - identifier: 复用唯一标识
    ///   - cellHeight: 行高 默认44.0
    required public init(differenceId:Int = 0,
                         identifier:String,
                         orginal:Any? = nil,
                         cellHeight:CGFloat = 44.0
    ) {
        
        self.orginal = orginal
        self.identifier = identifier
        self.cellHeight = cellHeight
        self.differenceId = differenceId
    }
    
    /// 预加载中
    open func prefetching() {
        
    }
    
    /// 取消预加载
    open func cancelPrefetching () {
        
    }
    
}

extension AdapterRow:Differentiable {
    
    public var differenceIdentifier: Int {
        return differenceId
    }
    
    public func isContentEqual(to source: AdapterRow) -> Bool {
        self.differenceId == source.differenceId
    }
    
}
