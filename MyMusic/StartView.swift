//
//  StartView.swift
//  MyMusic
//
//  Created by 市川涼 on 2025/05/06.
//

// StartView.swift
import SwiftUI

struct StartView: View {
    
    @State private var selectedCategory: QuizCategory = .level_1
    @State private var selectedMode: QuizMode = .timeLimit
    
    let onNext: () -> Void
    
    @AppStorage("totalCorrect") var totalCorrect: Int = 0

    
    var body: some View {
        ZStack {
            
            // 背景
            Image(.dojo)
                .resizable()
                .ignoresSafeArea()

            VStack(spacing: 20) {
                
                Spacer().frame(height: 180)
                
                let rank = Rank.getRank(for: totalCorrect)
                let nextThreshold = Rank.nextThreshold(for: totalCorrect)
                let remaining = nextThreshold.map { $0 - totalCorrect }

                Text("現在の称号：\(rank.rawValue)：\(totalCorrect)")
                    .font(.title2)
                    .bold()
                    .foregroundColor(.gray)
                    .background(Color.black)
                    .frame(width: 400, height: 0)

                if let remaining = remaining {
                    Text("次の称号まで残り \(remaining) 文字")
                        .font(.subheadline)
                        .bold()
                        .foregroundColor(.gray)
                        .background(Color.black)
                        .padding(.bottom, 60)
                } else {
                    Text("最高称号に到達！")
                        .font(.subheadline)
                        .foregroundColor(.yellow)
                        .padding(.bottom, 50)
                }

                
                Button(action: {
                    onNext()
                }) {
                    Text("挑戦")
                        .font(.largeTitle)
                        .foregroundColor(.white)
                        .bold()
                        .padding()
                        .frame(width: 200, height: 60)
                        .background(Color.startBtn)
                        .clipShape(RoundedRectangle(cornerRadius: 12))
                }
                
            }
        }
    }
}

#Preview {
    StartView(
        onNext: {},
        totalCorrect: 1)
}

