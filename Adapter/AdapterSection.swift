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
open class AdapterSection {
    
    /// difference算法的唯一标识
    open var differenceId: Int = 0
    
    /// 分区头高度
    open var headerHeight: CGFloat = CGFloat.leastNonzeroMagnitude
    
    /// 分区头视图
    open var headerView: UIView?
    
    /// 分区脚高度
    open var footerHeight: CGFloat = CGFloat.leastNonzeroMagnitude
    
    /// 分区脚视图
    open var footerView: UIView?
    
    public init(_ differenceId: Int = 0) {
        self.differenceId = differenceId
    }
}

extension AdapterSection: Differentiable {
    
    public var differenceIdentifier: Int {
        return differenceId
    }
    
    public func isContentEqual(to source: AdapterSection) -> Bool {
        self.differenceId == source.differenceId
    }
}
