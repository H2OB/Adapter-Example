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
 class AdapterRow: Differentiable {
    
    var diffID:Int = 0
    
    /// 原始数据
    var orginal : Any?
    
    /// 复用唯一标识
    var identifier : String
    
    /// 行高
    var cellHeight : CGFloat = 0
    
    /// 是否选中
    var isSelected : Bool = false
    
    /// 是否允许交互
    var isUserInteractionEnabled : Bool = true
    
    /// 点击回调
    var didSelected:SelectCallback?
    
    /// 内部回调
    var insideAction:InsideCallback?
    
    /// 所在tableView
    weak var tableView:UITableView!

    var differenceIdentifier: Int {
        return diffID
    }
    
    
    /// 初始化
    /// - Parameters:
    ///   - orginal: 原始数据
    ///   - identifier: 复用唯一标识
    ///   - cellHeight: 行高 默认44.0
    required init(diffID:Int = 0, orginal:Any?,identifier:String,_ cellHeight:CGFloat = 44.0) {
        self.diffID = diffID
        self.orginal = orginal
        self.identifier = identifier
        self.cellHeight = cellHeight
    }
    
    func isContentEqual(to source: AdapterRow) -> Bool {
        
        return self.diffID == source.diffID
    }
    
    /// 预加载中
    func prefetching() {
        
    }
    
    /// 取消预加载
    func cancelPrefetching () {
        
    }
    
}

