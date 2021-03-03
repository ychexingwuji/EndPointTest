//
//  ViewController.swift
//  EndPointTest
//
//  Created by YangWei on 2021/2/24.
//  Copyright © 2021 YangWei. All rights reserved.
//

import UIKit
import Alamofire

class ViewController: UIViewController {
    
    var textView: UITextView!
    var timer: Timer!
    var storeManager: StoreManager!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        initUI()
        loadData()
        
        beiginFetchData()
    }
    
    func initUI() {
        // textView
        let sideSpace = CGFloat(20.0)
        let contentWidth = UIScreen.main.bounds.size.width - 2 * sideSpace
        let contentHeight = UIScreen.main.bounds.size.height - 2 * sideSpace
        textView = UITextView(frame: CGRect(x: sideSpace, y: sideSpace, width: contentWidth , height: contentHeight))
        
        self.view.addSubview(textView)
        
        let item = UIBarButtonItem(title: "History",
                                  style: UIBarButtonItem.Style.plain,
                                  target: self,
                                  action: #selector(showHistory))
        self.navigationItem.rightBarButtonItem = item
    }
    
    func loadData() {
        storeManager = StoreManager()
        
        if let latestFileName = storeManager.fetchLastFileName() {
            let data = Data.init(cachefileName: latestFileName)
            let jsonStr = String(data: data!, encoding: .utf8)! as String
            self.textView.text = jsonStr
        }
    }
    
    @objc func showHistory() {
        self.navigationController?.pushViewController(HistoryViewController.init(), animated: true)
    }
    
    func beiginFetchData() {
        timer = Timer.scheduledTimer(timeInterval: 5,
                                     target: self,
                                     selector: #selector(reqData),
                                     userInfo: nil,
                                     repeats: true)
    }
    
    @objc func reqData() {
        Alamofire.AF.request("https://api.github.com/").responseJSON { (response) in
            switch response.result {
            case .success(let json):
                
                if JSONSerialization.isValidJSONObject(json) {
                    let data = try!JSONSerialization.data(withJSONObject: json, options: .prettyPrinted)
                    self.storeManager.saveData(data);
                    let jsonStr = String(data: data, encoding: .utf8)! as String
                    self.textView.text = jsonStr
                }
                
                print(json)
                break
            case .failure(let error):
                print("error:\(error)")
                break
            }
        }
    }
}

