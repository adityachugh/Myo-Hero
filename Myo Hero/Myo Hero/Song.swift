//
//  Song.swift
//  Myo Hero
//
//  Created by Aditya Chugh on 11/28/15.
//  Copyright © 2015 Aditya Chugh. All rights reserved.
//

import Foundation

class Song {
    
    var notes: [Note] = []
    var title: String!
    var artist: String!
    var totalNotes: Int {
        get {
            return notes.count
        }
    }
    
    init(title: String, artist: String) {
        self.title = title
        self.artist = artist
    }
    
    subscript(index: Int) -> Note {
        return notes[index]
    }
    
    func addNote(note: Note) {
        notes.append(note)
    }
}