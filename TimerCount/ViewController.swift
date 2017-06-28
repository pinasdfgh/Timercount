//
//  ViewController.swift
//  TimerCount
//
//  Created by pinasd chen on 2017/6/28.
//  Copyright © 2017年 pinasd chen. All rights reserved.
//

import UIKit

class ViewController: UIViewController ,UITableViewDataSource,UITableViewDelegate {
    
    
    
    
    @IBOutlet weak var paintuiv: paintVIU!
    @IBOutlet weak var hourlb: UILabel!
    @IBOutlet weak var monuelb: UILabel!
    @IBOutlet weak var slb: UILabel!
    @IBOutlet weak var sslb: UILabel!
    @IBOutlet weak var tbviu: UITableView!
    @IBOutlet weak var start: UIButton!
    @IBOutlet weak var reset: UIButton!
    private var isStart = false
    private var laps:Array<String> = []
    private var timer:Timer?
    private var count = 0
    private var lapsData:[Int] = []
    
    public func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int{
        return laps.count
    }
    
    
    public func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell{
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell")
        var numcount = laps.count
        cell?.textLabel?.text = laps[numcount - indexPath.row - 1]
        cell?.textLabel?.font = UIFont(name: "Arial", size: 30)
        cell?.textLabel?.textAlignment = .center
        return cell!
    }
    
    @IBAction func startter(_ sender: Any) {
        isStart = !isStart
        if isStart{
            //run
            start.setTitle("Stop", for: UIControlState.normal)
            reset.setTitle("Lap", for: UIControlState.normal)
            doStart()
        }else{
            start.setTitle("Start", for: UIControlState.normal)
            reset.setTitle("Reset", for: UIControlState.normal)
            doStop()
        }
    }
    
    @IBAction func dorest(_ sender: Any) {
        if isStart{
            //run
            doLap()
        }else{
            doReset()
        }
    }
    
    private func doStart(){
        timer = Timer.scheduledTimer(withTimeInterval: 0.01, repeats: true, block: {(timer) in
            self.count += 1
            self.showCount()
        })
        
    }
    private func doStop(){
        timer?.invalidate()
        timer = nil
    }
    private func doReset(){
        laps = []
        lapsData = []
        count = 0
        showCount()
        tbviu.reloadData()
        paintuiv.drawDataIn(lapsData)
    }
    private func doLap(){
        laps += ["\(hourlb.text ?? "00"):\(monuelb.text ?? "00"):\(slb.text ?? "00").\(sslb.text ?? "00")"]
        lapsData.append(count)
        paintuiv.drawDataIn(lapsData)
        tbviu.reloadData()
    }
    private func showCount(){
        let ss = count % 100
        let scount = (count/100)
        let s = scount % 60
        let mcount = scount / 60
        let m = mcount % 60
        let h = mcount / 60
        if ss < 10 {
            sslb.text = "0".appending(String(ss))
        }else{
            sslb.text = String(ss)
        }
        if s < 10 {
            slb.text = "0".appending(String(s))
        }else{
            slb.text = String(s)
        }
        if m < 10 {
            monuelb.text = "0".appending(String(m))
        }else{
            monuelb.text = String(m)
        }
        if h < 10 {
            hourlb.text = "0".appending(String(h))
        }else{
            hourlb.text = String(h)
        }
        
        
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        showCount()
        // Do any additional setup after loading the view, typically from a nib.
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
}
