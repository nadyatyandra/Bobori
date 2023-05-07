//
//  MusicPlayerModel.swift
//  Mini1
//
//  Created by Leo Harnadi on 01/05/23.
//

import Foundation

struct MusicPlayerModel {
    let musicList: [String] = ["Song 1", "Song 2", "Song 3", "Song 4", "Song 5"]
    var lastDate: Date? = nil
    var selectedSong: String = "Song 1"
}
