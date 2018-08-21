//
//  ScrollViewDataSourceManagerProtocol.swift
//  happyCampus
//
//  Created by 文慷黄 on 2017/10/31.
//  Copyright © 2017年 文慷黄. All rights reserved.
//
import UIKit
import Foundation

protocol ScrollViewDataSourceManagerProtocol: class, NSObjectProtocol {
    // 管理的数据类型
    associatedtype T

    // MARK: - properties
    // 储存 需要添加刷新功能的 scrollView
    var scrollView: UIScrollView { get set }
    // 数据源 数组
    var sourceArr: [T] { get set }
    // 数据源 数组的 count
    var count: Int { get }
    
    var isEmpty: Bool { get }
    
    var pageSize : Int { get set }
    
    // MARK: - subscript
    // 下标
    subscript(index: Int) -> T { get }

    // MARK: - life cycle
    init(_ scrollView: UIScrollView)

}

extension ScrollViewDataSourceManagerProtocol {
    // MARK: - properties
    // 数据源 数组的 count
    var count: Int {
        return sourceArr.count
    }

    var isEmpty: Bool {
        return sourceArr.isEmpty
    }
    
    // MARK: - subscript
    // 下标
    subscript(index: Int) -> T {
        return sourceArr[index]
    }
}
