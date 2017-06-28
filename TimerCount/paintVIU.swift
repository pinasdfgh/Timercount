//
//  paintVIU.swift
//  TimerCount
//
//  Created by pinasd chen on 2017/6/28.
//  Copyright © 2017年 pinasd chen. All rights reserved.
//

import UIKit

class paintVIU: UIView {
    
    private var data:[CGPoint] = []
    private var context:CGContext?
    private let pi:CGFloat = CGFloat(M_PI)
    private var isInit = false
    private var Disx:CGFloat = 0
    private var viewSize:CGRect?
    private var Sq:Double = 0
    private var avg:Double = 0
    private var med:Int = 0
    private var Sqdata:[CGPoint] = []
    
    func drawDataDiff(_ laps:[Int]) -> [Int]{
        var dataChange:[Int] = []
        for i in 1..<laps.count{
            dataChange.append(laps[i] - laps[i - 1])
        }
        
        return dataChange
        
    }
    
    func drawDataIn(_ laps:[Int]){
        
        var sum:Double
        var Sqsum:Double = 0
        var lapsD = laps
        
        if laps.count > 1{
            lapsD = drawDataDiff(laps)
        }
        Sqdata = []
        data = []
        Sq = 0
        
        if laps.count > 1{
            if laps.count <= 30{
                Disx = viewSize!.width/30
            }else{
                Disx = viewSize!.width/CGFloat(laps.count)
            }
            sum = Double(lapsD[0])
            var x:CGFloat = Disx
            let h = viewSize!.height - 10
            let temp = lapsD.max()
            let max = CGFloat(temp!)
            let tempS = lapsD.sorted()
            for (index,row) in tempS.enumerated(){
                var y:CGFloat = CGFloat(row)/max
                y *= h
                data.append(CGPoint(x:x,y:y))
                x += Disx
                if index > 0{
                    Sqsum = pow(Double(tempS[index] - tempS[index-1]),2)
                    sum += Double(row)
                }
            }
            
            Sq = 1/Double(lapsD.count) * sqrt(Sqsum)
            avg = sum/Double(lapsD.count)
            if lapsD.count % 2 == 0{
                
                med = (tempS[(lapsD.count - 1) / 2] + tempS[(lapsD.count - 1) / 2 + 1])/2
            }else{
                
                med = tempS[(lapsD.count - 1) / 2]
            }
            x = viewSize!.width / 2 - CGFloat(3 * Sq)
            var muty:[CGFloat] = [0,0.2,0.5,0.9,0.5,0.2,0]
            for i in 0...6{
                var y:CGFloat = 0
                y = h * muty[i]
                Sqdata.append(CGPoint(x:x,y:y))
                x += CGFloat(Sq)
            }
//            print(Sqdata)
            print(Sq)
//            print(avg)
//            print(med)
        }
      
        setNeedsDisplay()
    }
    
    private func initState(_ sclace: CGRect){
        context = UIGraphicsGetCurrentContext()
        //轉換座標軸
        context?.concatenate(.init(a: 1, b: 0, c: 0, d: -1, tx: 0, ty: sclace.height))
    }
    
    override func draw(_ rect: CGRect) {
        
        viewSize = rect
        if !isInit {initState(rect)}
//        drawNormal()
        drawSq()
  
    }
    
    private func drawSq(){
        if Sqdata.count > 0{
            context?.move(to: Sqdata[0])
            for point in Sqdata{
                context?.addLine(to: point)
            }
            context?.setLineWidth(2)
            context?.setStrokeColor(red: 0, green: 1, blue: 0, alpha: 1)
            context?.drawPath(using: CGPathDrawingMode.stroke)
            
            for point in Sqdata{
                drawPoint(point)
                context?.drawPath(using: CGPathDrawingMode.fillStroke)
            }
        }
    }
    
    private func drawNormal(){
        
            if data.count > 0{
            context?.move(to: data[0])
            for point in data{
                context?.addLine(to: point)
            }
            context?.setLineWidth(2)
            context?.setStrokeColor(red: 0, green: 1, blue: 0, alpha: 1)
            context?.drawPath(using: CGPathDrawingMode.stroke)
            
            for point in data{
                drawPoint(point)
                context?.drawPath(using: CGPathDrawingMode.fillStroke)
            }
        }
    }

   
    private func drawPoint(_ point:CGPoint){
        context?.setStrokeColor(red: 1, green: 0, blue: 0, alpha: 1)
        context?.setFillColor(red: 1, green: 0, blue: 0, alpha: 1)
        context?.addArc(center: point, radius: 2, startAngle: 0, endAngle: 2*pi, clockwise: true)
    }

}
