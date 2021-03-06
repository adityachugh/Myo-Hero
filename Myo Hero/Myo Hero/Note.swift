//
//  Note.swift
//  Myo Hero
//
//  Created by Aditya Chugh on 11/28/15.
//  Copyright © 2015 Aditya Chugh. All rights reserved.
//

import Foundation

class Note {
    
    init(time: Time, action: Action) {
        self.time = time
        self.action = action
    }
    
    let time: Time!
    let action: Action!
}