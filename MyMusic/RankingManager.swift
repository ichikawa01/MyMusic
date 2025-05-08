//
//  RankingManager.swift
//  MyMusic
//
//  Created by 市川涼 on 2025/05/08.
//

import Foundation
import FirebaseFirestore

enum QuizModeRank: String {
    case level_1
    case level_2
    case level_3
}

enum RankingPeriod: String, CaseIterable {
    case daily, weekly, monthly, total
    
    var displayName: String {
            switch self {
            case .daily: return "今日"
            case .weekly: return "今週"
            case .monthly: return "今月"
            case .total: return "累計"
            }
        }
}

class RankingManager {
    static let shared = RankingManager()
    private let db = Firestore.firestore()

    func submitScore(userId: String, userName: String, score: Int, mode: QuizModeRank) {
        let now = Date()
        let periods: [RankingPeriod] = [.daily, .weekly, .monthly, .total]

        for period in periods {
            let collectionName = "\(mode.rawValue)_\(period.rawValue)"
            let ref = db.collection("rankings").document(collectionName).collection("entries").document(userId)

            let data: [String: Any] = [
                "userId": userId,
                "userName": userName,
                "score": score,
                "timestamp": Timestamp(date: now)
            ]

            ref.setData(data, merge: true)
        }
    }

    func fetchTopRankings(mode: QuizModeRank, period: RankingPeriod, completion: @escaping ([RankingEntry]) -> Void) {
        let collectionName = "\(mode.rawValue)_\(period.rawValue)"
        db.collection("rankings")
            .document(collectionName)
            .collection("entries")
            .order(by: "score", descending: true)
            .limit(to: 100)
            .getDocuments { snapshot, error in
                guard let docs = snapshot?.documents else {
                    completion([])
                    return
                }

                let entries = docs.compactMap { doc -> RankingEntry? in
                    let data = doc.data()
                    guard let name = data["userName"] as? String,
                          let score = data["score"] as? Int else { return nil }
                    return RankingEntry(userName: name, score: score)
                }

                completion(entries)
            }
    }
}
