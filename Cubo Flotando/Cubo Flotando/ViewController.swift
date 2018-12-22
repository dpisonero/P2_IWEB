//
//  ViewController.swift
//  Cubo Flotando
//
//  Created by g822 DIT UPM on 28/9/18.
//  Copyright © 2018 g822 DIT UPM. All rights reserved.
//

import UIKit

class ViewController: UIViewController, ParametricFunctionViewDataSource {
    @IBOutlet weak var ztView: ParametricFunctionView!
    @IBOutlet weak var vtView: ParametricFunctionView!
    @IBOutlet weak var atView: ParametricFunctionView!
    @IBOutlet weak var vzView: ParametricFunctionView!
    
    @IBOutlet weak var ztLabel: UILabel!
    @IBOutlet weak var vtLabel: UILabel!
    @IBOutlet weak var atLabel: UILabel!
    
    @IBOutlet weak var lLabel: UILabel!
    @IBOutlet weak var timeLabel: UILabel!
    
    @IBOutlet weak var LSlider: UISlider!
    @IBOutlet weak var TSlider: UISlider!
 
    let model = HarmonicModel()
    
    var poiTime: Double = 0.0 {
        didSet {
            ztView.setNeedsDisplay()
            vtView.setNeedsDisplay()
            atView.setNeedsDisplay()
            vzView.setNeedsDisplay()
        }
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        
        ztView.dataSource = self
        vtView.dataSource = self
        atView.dataSource = self
        vzView.dataSource = self
        
        LSlider.sendActions(for: .valueChanged)
        TSlider.sendActions(for: .valueChanged)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func updateL(_ sender: UISlider) {
        model.l = Double(sender.value)
        lLabel.text = String(round(model.l*100)/100) + "m"
        update()
    }
    
    @IBAction func updateT(_ sender: UISlider) {
        poiTime = Double(sender.value)
        timeLabel.text = String(round(poiTime*100)/100) + "seg"
        update()
    }
    
    @IBAction func pinch(_ sender: UIPinchGestureRecognizer) {
        model.l *= Double(sender.scale)
        sender.scale = 1
        if model.l>1{
            model.l = 1 
        }
        lLabel.text = String(round(model.l*100)/100) + "m"
        update()
    }
    
    @IBAction func tap(_ sender: UITapGestureRecognizer) {
        poiTime = 2.0
        model.l = 0.5
        LSlider.value = 0.5
        TSlider.value = 2
        lLabel.text = String(round(model.l*100)/100) + "m"
        timeLabel.text = String(round(poiTime*100)/100) + "seg"
        update()
    }
    
    private func update() {
        
        let z = model.zAt(time: poiTime)
        let v = model.vAt(time: poiTime)
        let a = model.zAt(time: poiTime)
        /*
        let formatter = NumberFormatter()
        formatter.numberStyle = .decimal
        formatter.maximumFractionDigits = 2
        */
        
        ztLabel.text = String(round(z*100)/100) + "m"
        vtLabel.text = String(round(v*100)/100) + "m/seg"
        atLabel.text = String(round(a*100)/100) + "m/seg2"

        ztView.setNeedsDisplay()
        vtView.setNeedsDisplay()
        atView.setNeedsDisplay()
        vzView.setNeedsDisplay()
 
    }
    
    // MARK: - FunctionViewDataSource
    
    func startIndexFor(_ functionView: ParametricFunctionView) -> Double {
        return 0.0
    }
    
    func endIndexFor(_ functionView: ParametricFunctionView) -> Double {
        return 5.0
    }
    
    
    func functionView(_ functionView: ParametricFunctionView, pointAt index: Double) -> FunctionPoint {
        
        switch functionView {
        case ztView:
            let time = index
            let z = model.zAt(time: time)
            return FunctionPoint(x: time, y: z)
            
        case vtView:
            let time = index
            let v = model.vAt(time: time)
            return FunctionPoint(x: time, y: v)
            
        case atView:
            let time = index
            let a = model.aAt(time: time)
            return FunctionPoint(x: time, y: a)
            
        case vzView:
            let time = index
            let z = model.zAt(time: time)
            let v = model.vAt(time: time)
            return FunctionPoint(x: z, y: v)
            
        default:
            return FunctionPoint(x: 0, y: 0)
        }
    }
    
    func pointsOfInterestFor(_ functionView: ParametricFunctionView) -> [FunctionPoint] {
        switch functionView {
        case ztView:
            let z = model.zAt(time: poiTime)
            return [FunctionPoint(x: poiTime, y: z)]
            
        case vtView:
            let v = model.vAt(time: poiTime)
            return [FunctionPoint(x: poiTime, y: v)]
            
        case atView:
            let a = model.aAt(time: poiTime)
            return [FunctionPoint(x: poiTime, y: a)]
            
        case vzView:
            let z = model.zAt(time: poiTime)
            let v = model.vAt(time: poiTime)
            return [FunctionPoint(x: z, y: v)]
            
        default:
            return []
        }
    }

}

