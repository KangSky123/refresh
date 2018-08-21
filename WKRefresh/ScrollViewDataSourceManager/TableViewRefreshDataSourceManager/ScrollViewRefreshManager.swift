//
//  TableViewRefreshDataSourceManager.swift
//  happyCampus
//
//  Created by 文慷黄 on 2017/10/31.
//  Copyright © 2017年 文慷黄. All rights reserved.
//
import UIKit
import Foundation

protocol ScrollViewRefreshManagerDelegate: class, NSObjectProtocol {
    // 定义 加载数据 的方法
    // 第一个参数: 被管理的 ScrollView
    // 第二个参数: 页数
    // 第三个参数: 成功下载数据的 block, block 的第一个参数为 请求回来数据, 第二个参数为 服务器的数据总数量total(需要在服务器传输)
    // 第四个参数: 下载数据失败的 block
    func scrollViewRefresh(_ scrollView: UIScrollView, skip: Int, success: @escaping ([Any], Int) -> Void, fail: @escaping () -> Void)
}

class ScrollViewRefreshManager<DataSourceType>: ScrollViewDataSourceManager<DataSourceType>, ScrollViewRefreshManagerProtocol {

    // MARK: - properties
    weak var delegate: ScrollViewRefreshManagerDelegate?

    // 设置是否需要 上拉加载
    var needPullRefresh: Bool = true {
        didSet {
            self.didGetNeedPullRefresh()
        }
    }

    // 设置是否需要 下拉刷新
    var needDownRefresh: Bool = true {
        didSet {
            self.didGetNeedDownRefresh()
        }
    }

    // MARK: - life cycle
    required init(_ scrollView: UIScrollView) {
        super.init(scrollView)
        self.configure()
    }

    convenience init(_ scrollView: UIScrollView, delegate: ScrollViewRefreshManagerDelegate?) {
        self.init(scrollView)
        self.delegate = delegate
    }

}
