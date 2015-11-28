//
//  SongDataSource.swift
//  Myo Hero
//
//  Created by Aditya Chugh on 11/28/15.
//  Copyright © 2015 Aditya Chugh. All rights reserved.
//

import Foundation

class SongDataSource {
    
    class func getSongs() -> [Song] {
        var songs: [Song] = []
        
        let darudeSandstorm = Song(title: "Sandstorm", artist: "Darude")
        darudeSandstorm.addNote(Note(time: 100, action: Action.WaveIn))
        darudeSandstorm.addNote(Note(time: 1000, action: Action.WaveOut))
        darudeSandstorm.addNote(Note(time: 2000, action: Action.Fist))
        
        songs.append(darudeSandstorm)
        
        return songs
    }
}