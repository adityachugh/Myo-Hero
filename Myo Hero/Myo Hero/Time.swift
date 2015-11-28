//
//  Time.swift
//  Myo Hero
//
//  Created by Aditya Chugh on 11/28/15.
//  Copyright © 2015 Aditya Chugh. All rights reserved.
//

import Foundation

class Time {
    
    init(minutes: Int, seconds: Int, miliseconds: Int) {
        duration = (minutes*6000) + (seconds*100) + miliseconds
    }
    
    init(duration: Int) {
        self.duration = duration
    }
    func increment() {
        ++duration
    }
    
    var duration = 0
}