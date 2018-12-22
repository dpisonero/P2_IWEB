//
//  HarmonicModel.swift
//  Cubo Flotando
//
//  Created by g822 DIT UPM on 28/9/18.
//  Copyright © 2018 g822 DIT UPM. All rights reserved.
//

import Foundation

class HarmonicModel {
    
    // Gravedad
    static let g = 9.8
    
    // Lado del cubo
    var l: Double = 0.3 {
        didSet {
            updateW()
        }
    }
    
    // Inicializador
    init() {
        updateW()
    }
    
    // Velocidad angular
    private var w: Double = 0.0
    
    // Actualizar el lado
    private func updateW() {
        w = sqrt(2*HarmonicModel.g/l)
    }
    
    // Posición del cubo en t
    func zAt(time t: Double) -> Double {
        return 1/2*l*cos(w*t)
    }
    
    // Velocidad del cubo en t
    func vAt(time t: Double) -> Double {
        return -1/2*l*w*sin(w*t)
    }
    
    // Aceleración del cubo en t
    func aAt(time t: Double) -> Double {
        return -HarmonicModel.g*cos(w*t)
    }
}
