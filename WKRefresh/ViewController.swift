//
//  ViewController.swift
//  WKRefresh
//
//  Created by 文慷黄 on 2018/8/21.
//  Copyright © 2018年 文慷黄. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    var orderManager: ScrollViewRefreshManager<Model>!
    var orderArr: [Model] {
        if orderManager == nil {
            return [Model]()
        } else {
            return orderManager.sourceArr
        }
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        orderManager = ScrollViewRefreshManager.init(tableView, delegate: self)
        orderManager.beginHeaderRefreshing()
        
        self.view.addSubview(tableView)
        //注册UITableView，cellID为重复使用cell的Identifier
        self.tableView.register(UITableViewCell.self, forCellReuseIdentifier: "cellID")
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    lazy var tableView: UITableView = {
        let tableView = UITableView()
        tableView.frame = CGRect(x: 0, y: 0, width: ScreenWidth, height: ScreenHeight)
        tableView.delegate = self
        tableView.dataSource = self
        return tableView
    }()
}

extension ViewController: UITableViewDelegate,UITableViewDataSource {
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 50
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = (tableView.dequeueReusableCell(withIdentifier: "cellID", for: indexPath)) as UITableViewCell
        let model = orderArr[indexPath.row]
        cell.textLabel?.text = model.orderCode
        return cell
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return orderArr.count
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        
    }
}


extension ViewController: ScrollViewRefreshManagerDelegate {
    func scrollViewRefresh(_ scrollView: UIScrollView, skip: Int, success: @escaping ([Any], Int) -> Void, fail: @escaping () -> Void) {
        //skip 是页码 即请求第几页的数据
            
        //延时1秒执行
        let time: TimeInterval = 2.0
        DispatchQueue.main.asyncAfter(deadline: DispatchTime.now() + time) {
            //code
            print("1 秒后输出")
            let model = Model()
            model.goodsCount = 1
            model.orderCode = "123123"

            var modelArr = [Model]()
            modelArr.append(model)
            modelArr.append(model)
            modelArr.append(model)
            modelArr.append(model)
            modelArr.append(model)
            modelArr.append(model)
            modelArr.append(model)
            modelArr.append(model)
            modelArr.append(model)
            if skip <= 2 {
                modelArr.append(model)
            }
            success(modelArr,modelArr.count) //    modelArr是增加的数据,modelArr.count增加数据的条数,用于判断是否需要继续加载,默认为10 少于10条时,上啦不能继续加载
        }

        
    }
}

//extension LiveFollowManVC: ScrollViewRefreshManagerDelegate {
//    func scrollViewRefresh(_ scrollView: UIScrollView, skip: Int, success: @escaping ([Any], Int) -> Void, fail: @escaping () -> Void) {
//            var params = Dictionary<String,Any>()
//            params.updateValue(1, forKey: "orderStatusIndex")
//            params.updateValue(pageSize, forKey: "pageSize")
//            params.updateValue(skip, forKey: "pageNum")
//            request_post(url: labourerOrderAPI, params: params, cache: false, successClosure: { (model) in
//                guard model.status == false else {
//                    return
//                }
//                var modelArr = [SimpleShopOrderVO]()
//                let jsonArr = model.jsondata!["simpleShopOrderVOList"]
//                for json in (jsonArr.arrayValue){
//                    let model = SimpleShopOrderVO(jsonData: json)
//                    print(model)
//                    modelArr.append(model)
//                }
//                success(modelArr,modelArr.count)
//            }) { (error) in
//
//            }
//
//        }
//    }
//}

