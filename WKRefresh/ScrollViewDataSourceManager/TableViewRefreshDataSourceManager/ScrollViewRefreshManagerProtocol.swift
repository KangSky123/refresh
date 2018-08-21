//
//  ScrollViewRefreshManagerProtocol.swift
//  happyCampus
//
//  Created by 文慷黄 on 2017/10/31.
//  Copyright © 2017年 文慷黄. All rights reserved.
//

import Foundation
import MJRefresh

protocol ScrollViewRefreshManagerProtocol: ScrollViewDataSourceManagerProtocol {
    // MARK: - properties
    weak var delegate: ScrollViewRefreshManagerDelegate? { get set }

    // 是否需要 上拉加载
    var needPullRefresh: Bool { get set }
    var needDownRefresh: Bool { get set }

    // MARK: - 刷新方法
    // 开始刷新
    func beginHeaderRefreshing()

    // 结束刷新
    func beginFooterRefreshing()
}

// MARK: - other methods
extension ScrollViewRefreshManagerProtocol {
    // MARK: - configure
    func configure() {
        self.refreshSetting()
        self.pullRefreshSetting()
    }

    // 开始刷新
    func beginHeaderRefreshing() {
        scrollView.mj_header.beginRefreshing()
    }

    // 结束刷新
    func beginFooterRefreshing() {
        scrollView.mj_footer.beginRefreshing()
    }

    // 获取到 是否需要 上拉加载 的设置
    func didGetNeedPullRefresh() {
        if needPullRefresh == false {
            scrollView.mj_footer = nil
        } else {
            pullRefreshSetting()
        }
    }

    // 获取到 是否需要 下拉加载 的设置
    func didGetNeedDownRefresh() {
        if needDownRefresh == false {
            scrollView.mj_header = nil
        } else {
            refreshSetting()
        }
    }

    // 获取没有数据的提示 imageView
    func getNoDataImageView() -> UIImageView {
        let imageView = UIImageView(image: nil)
        let screenWidth = UIScreen.main.bounds.size.width
        let screenHeight = UIScreen.main.bounds.size.height
        let imageViewWidth = screenWidth * 2 / 5
        let imageViewHeight = imageViewWidth * 244 / 364
        imageView.frame = CGRect(x: (screenWidth - imageViewWidth) / 2, y: (screenHeight - imageViewHeight) / 2 - 100, width: imageViewWidth, height: imageViewHeight)
        imageView.tag = Int.max / 4 + 1
        return imageView
    }
}

// MARK: - private methods
extension ScrollViewRefreshManagerProtocol {
    // 下拉刷新设置
    fileprivate func refreshSetting() {
        let header = MJRefreshNormalHeader(refreshingBlock: { [unowned self] in
            self.delegate?.scrollViewRefresh(self.scrollView, skip: 1, success: { [weak self] newData, total in
                // 需要先判断 是否该 tableView 实例需要的数据源
                if let data = newData as? [T] {
                    self?.sourceArr = data
                    self?.reloadData()
                }
                self?.scrollView.mj_footer.resetNoMoreData()
                self?.scrollView.mj_header.endRefreshing()
                // 判断 是否没有更多数据
                if total == 0 {
                    if let imageView = self?.getNoDataImageView() {
//                        self?.scrollView.viewWithTag(Int.max / 4 + 1)?.removeFromSuperview()

//                        self?.scrollView.addSubview(imageView)
                    }
                } else if total < pageSize {   //数据已经是全部加载  //let count = self?.sourceArr.count, count >= total
                    self?.scrollView.mj_footer.endRefreshingWithNoMoreData()
                    self?.scrollView.viewWithTag(Int.max / 4 + 1)?.removeFromSuperview()
                } else {
                    self?.scrollView.viewWithTag(Int.max / 4 + 1)?.removeFromSuperview()
                }

                }, fail: { [weak self] in
                    self?.scrollView.mj_header.endRefreshing()
            })
        })
        header?.lastUpdatedTimeLabel.isHidden = true

        scrollView.mj_header = header
    }

    // 上拉加载设置
    fileprivate func pullRefreshSetting() {
        scrollView.mj_footer = MJRefreshAutoNormalFooter(refreshingBlock: { [unowned self] in
            let page = NSInteger(self.sourceArr.count / pageSize)
            print(page)
            self.delegate?.scrollViewRefresh(self.scrollView, skip: page + 1, success: { [weak self] (newData, total) in
                // 需要先判断 是否该 tableView 实例需要的数据源
                if let data = newData as? [T] {
                    self?.sourceArr += data
                    self?.reloadData()
                }
                // 判断 是否没有更多数据
                if total < pageSize {   //let count = self?.sourceArr.count, count >= total
                    self?.scrollView.mj_footer.endRefreshingWithNoMoreData()
                } else {
                    self?.scrollView.mj_footer.resetNoMoreData()
                    self?.scrollView.mj_footer.endRefreshing()
                }

                }, fail: { [weak self] in
                    self?.scrollView.mj_footer.endRefreshing()
            })
        })
        scrollView.mj_footer.isAutomaticallyHidden = true
    }

    // scrollView 刷新数据
    fileprivate func reloadData() {
        if let tableView = self.scrollView as? UITableView {
            tableView.reloadData()
        } else if let collectionView = self.scrollView as? UICollectionView {
            collectionView.reloadData()
        }
    }

    
}
