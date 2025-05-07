//
//  Rank.swift
//  MyMusic
//
//  Created by 市川涼 on 2025/05/06.
//

import Foundation

enum Rank: String {
    case minarai = "見習い"
    case shugyochu = "修行中"
    case shodan = "初段"
    case nidan = "二段"
    case sandan = "三段"
    case yondan = "四段"
    case godan = "五段"
    case shihanDai = "師範代"
    case menkyoKaiden = "免許皆伝"
    case kami = "神"

    static func getRank(for totalCorrect: Int) -> Rank {
        switch totalCorrect {
        case 0..<30: return .minarai
        case 30..<100: return .shugyochu
        case 100..<500: return .shodan
        case 500..<1000: return .nidan
        case 1000..<1500: return .sandan
        case 1500..<2000: return .yondan
        case 2000..<3000: return .godan
        case 3000..<5000: return .shihanDai
        case 5000..<10000: return .menkyoKaiden
        default: return .kami
        }
    }
}

