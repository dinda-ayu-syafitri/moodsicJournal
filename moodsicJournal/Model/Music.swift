//
//  Music.swift
//  moodsicJournal
//
//  Created by Dinda Ayu Syafitri on 24/05/24.
//

import Foundation
import MusicKit

struct SongItem: Identifiable, Hashable {
    var id: String
    let title: String
    let artist: String
    let imageURL: Artwork?
}
