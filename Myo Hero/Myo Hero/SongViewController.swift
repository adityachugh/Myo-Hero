//
//  SongViewController.swift
//  Myo Hero
//
//  Created by Aditya Chugh on 11/28/15.
//  Copyright © 2015 Aditya Chugh. All rights reserved.
//

import UIKit
import AVFoundation

class SongViewController: UIViewController, AVAudioPlayerDelegate {
    
    @IBOutlet weak var actionLabel: UILabel!
    @IBOutlet weak var hitLabel: UILabel!
    @IBOutlet weak var totalLabel: UILabel!
    
    @IBOutlet weak var waveOutView: UIView!
    @IBOutlet weak var fistView: UIView!
    @IBOutlet weak var fingerSpreadView: UIView!
    @IBOutlet weak var waveInView: UIView!
    
    var audioPlayer: AVAudioPlayer!
    
    var animationTriggered = false
    var actionTriggered = false
    var song: Song!
    var currentNote: Note! {
        didSet {
            totalLabel.text = "Total: \(currentIndex)"
        }
    }
    var currentIndex: Int! {
        didSet {
            totalLabel.text = "Total: \(currentIndex)"
        }
    }
    
    var timer: NSTimer!
    var currentTime: Time!
    
    var finished = false
    let timeWindow = Time(minutes: 0, seconds: 0, miliseconds: 75)
    let fallDelay = Time(minutes: 0, seconds: 2, miliseconds: 0)
    
    var action = Action.Unknown
    
    var myo = TLMHub.sharedHub().myoDevices()[0]
    
    var notesHit = 0 {
        didSet {
            hitLabel.text = "Hit: \(notesHit)"
        }
    }
    
    
    @IBAction func closeTapped(sender: AnyObject) {
        dismissViewControllerAnimated(true, completion: nil)
    }
    
    override func viewWillDisappear(animated: Bool) {
        audioPlayer.stop()
    }
    
    func setupAudioPlayer() {
        var error: NSError?
        let path = NSBundle.mainBundle().pathForResource("DarudeSandstorm", ofType: "mp3")
        let url = NSURL(fileURLWithPath: path!)
        do {
            audioPlayer = try AVAudioPlayer(contentsOfURL: url)
        } catch let error1 as NSError {
            error = error1
            audioPlayer = nil
        }
        audioPlayer.prepareToPlay()
    }
    
    override func viewDidLoad() {
        setupSong()
        setupAudioPlayer()
        currentTime = Time(minutes: 0, seconds: 0, miliseconds: 0)
        currentIndex = 0
        currentNote = song[currentIndex]
//        startTimer()
        
        NSNotificationCenter.defaultCenter().addObserver(self, selector: "poseChanged", name: TLMMyoDidReceivePoseChangedNotification, object: nil)
    }
    
    override func viewWillAppear(animated: Bool) {
        startTimer()
        audioPlayer.play()
    }
    
    func audioPlayerDidFinishPlaying(player: AVAudioPlayer, successfully flag: Bool) {
        
    }
    
    func startTimer() {
        print("Start")
        print(NSDate())
        timer = NSTimer.scheduledTimerWithTimeInterval(0.01, target: self, selector: "updateTimer", userInfo: nil, repeats: true)
    }
    
    func setupSong() {
        let darudeSandstorm = Song(title: "Sandstorm", artist: "Darude")
        
        darudeSandstorm.addNote(Note(time: Time(minutes: 0, seconds: 16, miliseconds: 0), action: Action.WaveIn))
        darudeSandstorm.addNote(Note(time: Time(minutes: 0, seconds: 20, miliseconds: 0), action: Action.WaveOut))
        darudeSandstorm.addNote(Note(time: Time(minutes: 0, seconds: 25, miliseconds: 0), action: Action.WaveIn))
        darudeSandstorm.addNote(Note(time: Time(minutes: 0, seconds: 30, miliseconds: 0), action: Action.Fist))
        darudeSandstorm.addNote(Note(time: Time(minutes: 0, seconds: 33, miliseconds: 0), action: Action.FingersSpread))
        darudeSandstorm.addNote(Note(time: Time(minutes: 0, seconds: 36, miliseconds: 0), action: Action.WaveIn))
        darudeSandstorm.addNote(Note(time: Time(minutes: 0, seconds: 40, miliseconds: 0), action: Action.WaveOut))
        darudeSandstorm.addNote(Note(time: Time(minutes: 0, seconds: 43, miliseconds: 0), action: Action.WaveIn))
        darudeSandstorm.addNote(Note(time: Time(minutes: 0, seconds: 46, miliseconds: 0), action: Action.WaveOut))
        darudeSandstorm.addNote(Note(time: Time(minutes: 0, seconds: 49, miliseconds: 0), action: Action.WaveIn))
        darudeSandstorm.addNote(Note(time: Time(minutes: 0, seconds: 52, miliseconds: 0), action: Action.WaveOut))
        darudeSandstorm.addNote(Note(time: Time(minutes: 0, seconds: 55, miliseconds: 0), action: Action.WaveIn))
        darudeSandstorm.addNote(Note(time: Time(minutes: 0, seconds: 58, miliseconds: 0), action: Action.WaveOut))
        darudeSandstorm.addNote(Note(time: Time(minutes: 1, seconds: 1, miliseconds: 0), action: Action.Fist))
        darudeSandstorm.addNote(Note(time: Time(minutes: 1, seconds: 4, miliseconds: 0), action: Action.FingersSpread))
        darudeSandstorm.addNote(Note(time: Time(minutes: 1, seconds: 7, miliseconds: 0), action: Action.WaveIn))
        darudeSandstorm.addNote(Note(time: Time(minutes: 1, seconds: 10, miliseconds: 0), action: Action.WaveOut))
        darudeSandstorm.addNote(Note(time: Time(minutes: 1, seconds: 13, miliseconds: 0), action: Action.Fist))
        darudeSandstorm.addNote(Note(time: Time(minutes: 1, seconds: 16, miliseconds: 0), action: Action.FingersSpread))
        darudeSandstorm.addNote(Note(time: Time(minutes: 1, seconds: 19, miliseconds: 0), action: Action.Fist))
        darudeSandstorm.addNote(Note(time: Time(minutes: 1, seconds: 22, miliseconds: 0), action: Action.FingersSpread))
        darudeSandstorm.addNote(Note(time: Time(minutes: 1, seconds: 25, miliseconds: 0), action: Action.Fist))
        
        
        song = darudeSandstorm
    }
    
    func updateTimer() {
        currentTime.increment()
        if currentTime.duration % 100 == 0 {
            print("\(currentTime.duration/100) seconds")
        }
        
        //        if currentTime.duration > (currentNote.time.duration-fallDelay.duration)-30 && currentTime.duration < (currentNote.time.duration-fallDelay.duration)+30 && !animationTriggered {
        if currentTime.duration == (currentNote.time.duration-fallDelay.duration) {
            animationTriggered = true
            var baseView: UIView!
            switch currentNote.action! {
            case .FingersSpread:
                baseView = fingerSpreadView
            case .Fist:
                baseView = fistView
            case .WaveIn:
                baseView = waveInView
            case .WaveOut:
                baseView = waveOutView
            default:
                baseView = UIView()
            }
            let actionView = ActionView(frame: CGRect(x: 0, y: 0, width: 75, height: 75))
            actionView.note = currentNote
            actionView.center = baseView.center
            actionView.frame.origin = CGPoint(x: (baseView.frame.size.width/2)-(actionView.frame.size.width/2), y: -150)
            baseView.addSubview(actionView)
            UIView.animateWithDuration(Double((fallDelay.duration/100)+(fallDelay.duration/(400))), animations: {
                () -> Void in
                actionView.frame.origin = CGPoint(x: actionView.frame.origin.x, y: (baseView.frame.height-75)+((150+baseView.frame.height-75)/4))
                }, completion: {
                    (completed) -> Void in
                    actionView.removeFromSuperview()
            })
        }
        
        if currentTime.duration > (currentNote.time.duration-timeWindow.duration) && currentTime.duration < (currentNote.time.duration+timeWindow.duration) && !actionTriggered {
            var text = ""
            switch currentNote.action! {
            case .WaveIn:
                text = "Wave In"
            case .WaveOut:
                text = "Wave Out"
            case .Fist:
                text = "Fist"
            case .FingersSpread:
                text = "Fingers Spread"
            default:
                text = ""
            }
            actionLabel.text = text
        } else if (currentTime.duration > currentNote.time.duration) {
            if !actionTriggered && currentNote.action == action {
                ++notesHit
            } else {
                actionLabel.text = ""
                print("Miss")
            }
            incrementNote()
        } else {
            actionLabel.text = ""
        }
    }
    
    func incrementNote() {
        animationTriggered = false
        actionTriggered = false
        currentIndex = currentIndex+1
        if currentIndex < song.notes.count {
            currentNote = song[currentIndex]
        } else {
            finished = true
            timer.invalidate()
        }
    }
    
    func poseChanged() {
        var action = Action.Fist
        switch myo.pose!.type {
        case .Fist:
            action = Action.Fist
        case .WaveIn:
            action = Action.WaveIn
        case .WaveOut:
            action = Action.WaveOut
        case .FingersSpread:
            action = Action.FingersSpread
        default:
            action = Action.Unknown
        }
        self.action = action
        if currentTime.duration > (currentNote.time.duration-timeWindow.duration) && currentTime.duration < (currentNote.time.duration+timeWindow.duration) && !finished {
            if action == currentNote.action {
                actionTriggered = true
                print("Hit!")
                ++notesHit
                incrementNote()
            } else {
                print("Miss")
                incrementNote()
            }
        } else {
            print("Miss")
        }
    }
    
    class func delayTime(delay:Double, closure:()->()) {
        dispatch_after(
            dispatch_time(
                DISPATCH_TIME_NOW,
                Int64(delay * Double(NSEC_PER_SEC))
            ),
            dispatch_get_main_queue(), closure)
    }
}
