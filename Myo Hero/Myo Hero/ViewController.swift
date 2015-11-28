//
//  ViewController.swift
//  Myo Hero
//
//  Created by Aditya Chugh on 11/27/15.
//  Copyright © 2015 Aditya Chugh. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    @IBOutlet weak var poseLabel: UILabel!
    @IBOutlet weak var correctLabel: UILabel!
    @IBOutlet weak var wrongLabel: UILabel!
    
    var currentMyo: TLMMyo?
    var isLocked = false
    
    var currentPose = TLMPoseType.Fist
    
    var correctCount = 0 {
        didSet {
            correctLabel.text = "Correct: \(correctCount)"
        }
    }
    var wrongCount = 0 {
        didSet {
            wrongLabel.text = "Wrong: \(wrongCount)"
        }
    }
    
    func changePose() {
        let randomInt = random()%4
        switch randomInt {
        case 0:
            currentPose = .Fist
        case 1:
            currentPose = .WaveIn
        case 2:
            currentPose = .WaveOut
        case 3:
            currentPose = .FingersSpread
        default:
            fatalError()
        }
        switch currentPose {
        case .WaveIn:
            poseLabel.text = "Wave In"
        case .WaveOut:
            poseLabel.text = "Wave Out"
        case .Fist:
            poseLabel.text = "Fist"
        case .FingersSpread:
            poseLabel.text = "Fingers Spread"
        default:
            poseLabel.text = "Other"
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        let barButton = UIBarButtonItem(title: "Devices", style: UIBarButtonItemStyle.Plain, target: self, action: "devicesTapped")
        
        self.navigationItem.rightBarButtonItem = barButton
        
        NSNotificationCenter.defaultCenter().addObserver(self, selector: "myoConnected", name: TLMHubDidConnectDeviceNotification, object: nil)
        
        NSNotificationCenter.defaultCenter().addObserver(self, selector: "poseChanged", name: TLMMyoDidReceivePoseChangedNotification, object: nil)
        
        NSNotificationCenter.defaultCenter().addObserver(self, selector: "lockEventChanged", name: TLMMyoDidReceiveLockEventNotification, object: nil)
        
        
    }
    
    func devicesTapped() {
        let settingsViewController = TLMSettingsViewController()
        
        self.navigationController?.pushViewController(settingsViewController, animated: true)
    }
    
    func myoConnected() {
        if let myo = TLMHub.sharedHub().myoDevices()[0] as? TLMMyo {
            currentMyo = myo
        }
    }
    
    func lockEventChanged() {
        if let myo = TLMHub.sharedHub().myoDevices()[0] as? TLMMyo {
            isLocked = myo.isLocked
            if myo.isLocked {
                myo.unlockWithType(TLMUnlockType.Hold)
            }
            print((isLocked ? "Locked" : "Not Locked"))
        }
    }
    
    func poseChanged() {
        if let myo = currentMyo {
            let pose = myo.pose.type
            if pose == .FingersSpread || pose == .WaveIn || pose == .WaveOut || pose == .Fist {
                if pose == currentPose {
                    ++correctCount
                } else {
                    ++wrongCount
                }
                changePose()
            }
            //            switch myo.pose.type {
            //            case .WaveIn:
            //                print("Wave In")
            //            case .WaveOut:
            //                print("Wave Out")
            //            case .Fist:
            //                print("Fist")
            //            case .FingersSpread:
            //                print("Fingers Spread")
            //            default:
            //                print("Other")
            //            }
        }
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
}

