//
//  SongViewController.swift
//  Myo Hero
//
//  Created by Aditya Chugh on 11/28/15.
//  Copyright © 2015 Aditya Chugh. All rights reserved.
//

import UIKit

class SongViewController: UIViewController {
    
    var song: Song!
    var currentNote: Note!
    let timer: NSTimer!
    
    override func viewDidLoad() {
        timer = NSTimer(timeInterval: 0.01, target: self, selector: "updateTimer", userInfo: nil, repeats: true)
        song = SongDataSource.getSongs()[0]
        currentNote = song[0]
    }
    
    func updateTimer() {
        
    }
    
    func setupSong() {
        
    }
    
}
