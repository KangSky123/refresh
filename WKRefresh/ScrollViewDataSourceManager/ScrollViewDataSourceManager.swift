//
//  ScrollViewDataSourceManager.swift
//  happyCampus
//
//  Created by 文慷黄 on 2017/10/31.
//  Copyright © 2017年 文慷黄. All rights reserved.
//
import UIKit
import Foundation

class ScrollViewDataSourceManager<DataSourceType>: NSObject, ScrollViewDataSourceManagerProtocol {
    var pageSize: Int
    

    // MARK: - typealias
    // 重定义数据源类型
    typealias T = DataSourceType

    // MARK: - properties
    // 储存 需要添加刷新功能的 scrollView
    var scrollView: UIScrollView
    // 数据源 数组
    var sourceArr = [T]()

    // MARK: - life cycle
    required init(_ scrollView: UIScrollView) {
        self.scrollView = scrollView
        self.pageSize = 10
    }

}
