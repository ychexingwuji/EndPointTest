//
//  HistoryDetailController.swift
//  EndPointTest
//
//  Created by YangWei on 2021/3/3.
//  Copyright © 2021 YangWei. All rights reserved.
//

import UIKit

class HistoryDetailController: UIViewController {

    var textView: UITextView!
    var fileName: String!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.navigationItem.title = "Detail"
        
        initUI()
        loadData()
    }
    
    func initUI() {
        // textView
        let sideSpace = CGFloat(20.0)
        let contentWidth = UIScreen.main.bounds.size.width - 2 * sideSpace
        let contentHeight = UIScreen.main.bounds.size.height - 2 * sideSpace
        textView = UITextView(frame: CGRect(x: sideSpace, y: sideSpace, width: contentWidth , height: contentHeight))
        
        self.view.addSubview(textView)
    }
    
    func loadData() {
        let data = Data.init(cachefileName: fileName)
        let jsonStr = String(data: data!, encoding: .utf8)! as String
        self.textView.text = jsonStr
    }

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
