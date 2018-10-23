//
//  ViewController.swift
//  simple-calc
//
//  Created by Nathan Han on 10/17/18.
//  Copyright © 2018 Nathan Han. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    @IBOutlet weak var labelResult: UILabel!
    
    var started: Bool = false
    var lhs: String = ""
    var opr: String = ""
    var rhs: String = ""
    var current: Int = 0
    var allCurNums: [String] = []
    var history: String = ""
    var historyList: [String] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }

    @IBAction func btnNumPressed(_ sender: Any) {
        let btn = sender as! UIButton
        let num = btn.tag
        if opr == "" {
            lhs += String(num)
            history += "\(num)"
            labelResult.text = lhs
        } else {
            rhs += String(num)
            history += "\(num)"
            labelResult.text = rhs
        }
        NSLog("lhs: \(lhs) rhs: \(rhs)")
    }
    
    @IBAction func btnOpr(_ sender: UIButton) {
        NSLog(sender.titleLabel!.text!)
        opr = sender.titleLabel!.text!
        history += " \(opr) "
    }
    
    @IBAction func btnEquals(_ sender: UIButton) {
        let ans = compute()
        NSLog("\(ans)")
        labelResult.text = String(ans)
        historyList.append(history)
        reset()
    }
    
    public func compute() -> Int{
        let intLhs = Int(lhs)
        let intRhs = Int(rhs)
        history += " = "
        switch opr {
            case "+":
                labelResult.text = String(intLhs! + intRhs!)
                history += String(intLhs! + intRhs!)
                return intLhs! + intRhs!
            case "-":
                labelResult.text = String(intLhs! - intRhs!)
                history += String(intLhs! - intRhs!)
                return intLhs! - intRhs!
            case "✕":
                labelResult.text = String(intLhs! * intRhs!)
                history += String(intLhs! * intRhs!)
                return intLhs! * intRhs!
            case "÷":
                labelResult.text = String(intLhs! / intRhs!)
                history += String(intLhs! / intRhs!)
                return intLhs! / intRhs!
            case "%":
                let x = intLhs! / intRhs!
                labelResult.text = String(intLhs! - (intRhs! * x))
                history += "\(String(intLhs! - (intRhs! * x)))"
                return intLhs! - (intRhs! * x)
            case "avg":
                allCurNums.append(rhs)
                let avgNum = avg(nums: allCurNums)
                labelResult.text = String(avgNum)
                history += String(avgNum)
                return avgNum
            case "count":
                allCurNums.append(rhs)
                labelResult.text = String(allCurNums.count)
                history += String(allCurNums.count)
                return allCurNums.count
            default:
                labelResult.text = "Error"
                return 0
        }
    }
    
    @IBAction func btnFact(_ sender: UIButton) {
        NSLog(sender.titleLabel!.text!)
        if Int(lhs)! < 1 {
            labelResult.text = "0"
            NSLog("0")
            historyList.append("error")
        } else {
            let factNum = fact(num: Int(lhs)!)
            labelResult.text = String(factNum)
            NSLog("fact(\(lhs)) = \(factNum)")
            historyList.append("fact(\(lhs)) = \(factNum)")
        }
        reset()
    }
    
    public func fact(num: Int) -> Int {
        if(num == 1){
            return 1
        }else{
            return num * fact(num : num - 1)
        }
    }
    
    @IBAction func btnAvg(_ sender: UIButton) {
        opr = "avg"
        history += " \(opr) "
        if lhs != "" {
            allCurNums.append(lhs)
            lhs = ""
        } else {
            allCurNums.append(rhs)
            rhs = ""
        }
        NSLog("\(allCurNums)")
    }
    
    public func avg(nums: [String]) -> Int {
        var sum = 0
        let total = nums.count
        for i in 0..<total {
            sum = sum + Int(nums[i])!
        }
        return sum / total
    }
    
    @IBAction func btnCount(_ sender: UIButton) {
        opr = "count"
        history += " \(opr) "
        if lhs != "" {
            allCurNums.append(lhs)
            lhs = ""
        } else {
            allCurNums.append(rhs)
            rhs = ""
        }
        NSLog("\(allCurNums)")
    }
    
    public func reset() {
        opr = ""
        lhs = ""
        rhs = ""
        allCurNums = []
        history = ""
    }
    
    
    @IBOutlet var txtOutput: UIView!

    @IBAction func btnHistory(_ sender: Any) {
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "history" {
            let history = segue.destination as! ViewControllerHistory
            history.historyList = self.historyList
        }
    }
    
}

