//
//  RankingEntry.swift
//  MyMusic
//
//  Created by 市川涼 on 2025/05/08.
//

import Foundation

struct RankingEntry: Identifiable {
    let id = UUID()
    let userName: String
    let score: Int
}
