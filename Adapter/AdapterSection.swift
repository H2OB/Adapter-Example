//
//  AdapterSection.swift
//  TableViewHelper
//
//  Created by 杨涛 on 2022/1/8.
//

import Foundation
import UIKit
import DifferenceKit

// MARK: -- 分区基类
class AdapterSection:Differentiable {
    
    var diffID:Int = 0
    
    /// 分区头高度
    var headerHeight:CGFloat = CGFloat.leastNonzeroMagnitude
    
    /// 分区头视图
    var headerView:UIView?
    
    /// 分区脚高度
    var footerHeight:CGFloat = CGFloat.leastNonzeroMagnitude
    
    /// 分区脚视图
    var footerView:UIView?
    
    
    var differenceIdentifier: Int {
        return diffID
    }
    
    init(_ diffID:Int = 0) {
        self.diffID = diffID
    }
    
    func isContentEqual(to source: AdapterSection) -> Bool {
        self.diffID == source.diffID
    }
    
}
