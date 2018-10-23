//
//  ViewControllerHistory.swift
//  simple-calc
//
//  Created by Nathan Han on 10/22/18.
//  Copyright © 2018 Nathan Han. All rights reserved.
//

import UIKit

class ViewControllerHistory: UIViewController {
    
    public var historyList: [String] = []
    @IBOutlet weak var viewHistory: UIView!

    override func viewDidLoad() {
        super.viewDidLoad()
        
        dump(historyList)
        
         var padding: CGFloat = 100
        
        for equation in historyList.reversed() {
            let label = UILabel(frame: CGRect(x: 16, y: 0, width: UIScreen.main.bounds.width, height: padding))
            label.text = equation
            label.font = label.font.withSize(30)
            padding += 100
            
            viewHistory.addSubview(label)
        }

    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "home" {
            let destVC  = segue.destination as! ViewController
            destVC.historyList += self.historyList
        }
    }
    
}
