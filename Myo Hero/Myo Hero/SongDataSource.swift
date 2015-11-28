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
        var songs = [Song]()
        
        let darudeSandstorm = Song(title: "Sandstorm", artist: "Darude")
        darudeSandstorm.addNote(Note(time: Time(minutes: 0, seconds: 5, miliseconds: 0), action: Action.WaveIn))
        darudeSandstorm.addNote(Note(time: Time(minutes: 0, seconds: 10, miliseconds: 0), action: Action.WaveOut))
        darudeSandstorm.addNote(Note(time: Time(minutes: 0, seconds: 15, miliseconds: 0), action: Action.Fist))
        
        songs.append(darudeSandstorm)
        
        return songs
    }
}