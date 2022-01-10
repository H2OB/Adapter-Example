//
//  Adapter.swift
//  Adapter-Examaple
//
//  Created by 杨涛 on 2022/1/8.
//

import Foundation
import UIKit
import DifferenceKit

// MARK: -- 闭包定义
public typealias SelectCallback = (AdapterRow) -> Void
public typealias InsideCallback = (AdapterRow,Any?) -> Void
public typealias DiffSection = ArraySection<AdapterSection, AdapterRow>
public typealias Prefetchback = ([IndexPath]) -> Void

// MARK: -- 回调
 class Adapter: NSObject {
    
    private weak var tableView : UITableView!
    
    /// 最终数据
    var dataArray: [DiffSection] = [DiffSection]()
    
    /// 输入源
    var dataInput: [DiffSection] {
        get { return dataArray }
        set {
            let changeset = StagedChangeset(source: dataArray, target: newValue)
            tableView.reload(using: changeset, with: .none) { result in
                self.dataArray = result
            }
        }
    }
    
    ///  点击row事件
    var didSelectRow:SelectCallback?
    
    ///  rown内部事件
    var insideAction:InsideCallback?
    
    /// 预加载
    var prefetchCallback:Prefetchback?
    
    /// 取消预加载
    var cancelPrefetchCallback:Prefetchback?
    
}

// MARK: -- 初始化
extension Adapter {
    
    convenience init(_ tableView:UITableView) {
        self.init()
        
        tableView.estimatedRowHeight = 0;
        tableView.estimatedSectionFooterHeight = 0;
        tableView.estimatedSectionHeaderHeight = 0;
        
        if #available(iOS 13.0, *) {
            tableView.contentInsetAdjustmentBehavior = .never
        }
        
        if #available(iOS 15.0, *) {
            tableView.sectionHeaderTopPadding = 0
        }
        
        //只有plain样式才需要在底部加一个空白视图来删除多余的行
        if tableView.style == .plain {
            tableView.tableFooterView = UIView(frame: CGRect(x: 0, y: 0, width: 0, height: 1))
        }
        
        tableView.delegate = self
        tableView.dataSource = self
        
        if #available(iOS 10.0, *) {
            tableView.prefetchDataSource = self
        }
        
        self.tableView = tableView
        
    }
}

// MARK: -- 代理
extension Adapter: UITableViewDelegate {
    
    // 分区头高度
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        
        let node = dataArray[section].model
        
        return node.headerHeight
        
    }
    
    // 分区头视图
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        
        let node = dataArray[section].model
        return node.headerView
        
    }
    
    // 分区头将要显示
    func tableView(_ tableView: UITableView, willDisplayHeaderView view: UIView, forSection section: Int) {
        
        if let target = view as? AdapterSectionView {
            target.willDisplay()
        }
        
    }
    
    // 分区头已经消失
    func tableView(_ tableView: UITableView, didEndDisplayingHeaderView view: UIView, forSection section: Int) {
        
        if let target = view as? AdapterSectionView {
            target.didEndDisplaying()
        }
    }
    
    
    // 分区脚高度
    func tableView(_ tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
        
        let node = dataArray[section].model
        
        return node.footerHeight
    }
    
    // 分区脚视图
    func tableView(_ tableView: UITableView, viewForFooterInSection section: Int) -> UIView? {
        
        let node = dataArray[section].model
        
        return node.footerView
        
    }
    
    // 分区脚将要出现
    func tableView(_ tableView: UITableView, willDisplayFooterView view: UIView, forSection section: Int) {
        
        if let target = view as? AdapterSectionView {
            target.willDisplay()
        }
        
    }
    
    // 分区脚已经消失
    func tableView(_ tableView: UITableView, didEndDisplayingFooterView view: UIView, forSection section: Int) {
        
        if let target = view as? AdapterSectionView {
            target.didEndDisplaying()
        }
        
    }
    
    // cell高度
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        
        let node = dataArray[indexPath.section].elements[indexPath.row]
        node.tableView = tableView
        return node.cellHeight
    }
    
    // cell将要出现
    func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        
        
        if let target = cell as? AdapterRowCell {
            target.willDisplay()
            return
        }
    }
    
    // cell已经消失
    func tableView(_ tableView: UITableView, didEndDisplaying cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        
        
        if let target = cell as? AdapterRowCell {
            target.didEndDisplaying()
            return
        }
        
    }
    
    // cell选中事件
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        let node = dataArray[indexPath.section].elements[indexPath.row]
        node.tableView = tableView
        if let callback = node.didSelected {
            callback(node)
        } else if let callback = didSelectRow {
            callback(node)
        }
        
        tableView.deselectRow(at: indexPath, animated: true)
        
    }
    
}

//MARK: -- 数据源
extension Adapter: UITableViewDataSource {
    
    // 分区数
    func numberOfSections(in tableView: UITableView) -> Int {
        
        return dataArray.count
    }
    
    // 分区对应行数
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        let rows = dataArray[section].elements
        
        return rows.count
    }
    
    // 每行的Cell
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let node = dataArray[indexPath.section].elements[indexPath.row]
        
        let cell = tableView.dequeueReusableCell(withIdentifier: node.identifier, for: indexPath)
        
        // 是否可以交互
        cell.isUserInteractionEnabled = node.isUserInteractionEnabled
        
        if let target = cell as? AdapterRowCell {
            target.node = node
        }
        
        if node.insideAction == nil && insideAction != nil{
            node.insideAction = insideAction
        }
        
        return cell
        
    }
    
}

// MARK: -- 预加载
extension Adapter: UITableViewDataSourcePrefetching {
    
    // 预加载
    func tableView(_ tableView: UITableView, prefetchRowsAt indexPaths: [IndexPath]) {
        
        indexPaths.forEach { indexPath in
            let node = dataArray[indexPath.section].elements[indexPath.row]
            node.prefetching()
        }
        
        if let callback = prefetchCallback {
            callback(indexPaths)
        }
        
    }
    
    // 取消预加载
    func tableView(_ tableView: UITableView, cancelPrefetchingForRowsAt indexPaths: [IndexPath]) {
        
        indexPaths.forEach { indexPath in
            let node = dataArray[indexPath.section].elements[indexPath.row]
            node.cancelPrefetching()
        }
        
        if let callback = cancelPrefetchCallback {
            callback(indexPaths)
        }
        
    }
    
}
