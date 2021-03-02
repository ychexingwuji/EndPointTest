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
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        initUI()
        
        reqData()
    }
    
    func initUI() {
        // textView
        let sideSpace = CGFloat(20.0)
        let contentWidth = UIScreen.main.bounds.size.width - 2 * sideSpace
        let contentHeight = UIScreen.main.bounds.size.height - 2 * sideSpace
        textView = UITextView(frame: CGRect(x: sideSpace, y: sideSpace, width: contentWidth , height: contentHeight))
        
        self.view.addSubview(textView)
    }
    
    func reqData() {
        Alamofire.AF.request("https://api.github.com/").responseJSON { (response) in
            switch response.result {
            case .success(let json):
                
                if JSONSerialization.isValidJSONObject(json) {
                    let data = try!JSONSerialization.data(withJSONObject: json, options: .prettyPrinted)
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

