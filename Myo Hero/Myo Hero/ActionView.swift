//
//  ActionView.swift
//  Myo Hero
//
//  Created by Aditya Chugh on 11/28/15.
//  Copyright © 2015 Aditya Chugh. All rights reserved.
//

import UIKit

class ActionView: UIView {
    
    @IBOutlet var view: UIView!
    @IBOutlet weak var textLabel: UILabel!
    var note: Note! {
        didSet {
            switch note.action! {
            case .FingersSpread:
                textLabel.text = "Fingers Spread"
            case .Fist:
                textLabel.text = "Fist"
            case .WaveIn:
                textLabel.text = "Wave In"
            case .WaveOut:
                textLabel.text = "Wave Out"
            default:
                textLabel.text = ""
            }
        }
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    NSBundle.mainBundle().loadNibNamed("ActionView", owner: self, options: nil)
        self.addSubview(view)
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        NSBundle.mainBundle().loadNibNamed("ActionView", owner: self, options: nil)
        self.bounds = self.view.bounds
        self.addSubview(view)
    }
    
}
