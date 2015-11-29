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
            textLabel.text = ""
            switch note.action! {
            case .FingersSpread:
//                textLabel.text = "Fingers Spread"
                view.backgroundColor = UIColor.turquoiseColor()
            case .Fist:
//                textLabel.text = "Fist"
                view.backgroundColor = UIColor.peterRiverColor()
            case .WaveIn:
//                textLabel.text = "Wave In"
                view.backgroundColor = UIColor.amethystColor()
            case .WaveOut:
//                textLabel.text = "Wave Out"
                view.backgroundColor = UIColor.alizarinColor()
            default:
                textLabel.text = ""
                view.backgroundColor = UIColor.turquoiseColor()
            }
        }
    }
    
    override func awakeFromNib() {
        
    }
    
    func setup() {
        view.layer.cornerRadius = 75/2
        view.layer.masksToBounds = true
        textLabel.hidden = true
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
