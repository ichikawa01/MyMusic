//
//  ModeSelectView.swift
//  MyMusic
//
//  Created by 市川涼 on 2025/05/06.
//

import SwiftUI

struct ModeSelectView: View {
    @Environment(\.dismiss) private var dismiss
    
    let onNext: (QuizMode) -> Void
    let onBack: () -> Void

    
    var body: some View {
        ZStack{

            //背景
            Image(.dojo)
                .resizable()
                .ignoresSafeArea()
            
            VStack{
                HStack{
                    // 戻るボタン（左上）
                    Button(action: {
                        onBack()
                    }) {
                        Image(.backIconWhite)
                            .resizable()
                            .frame(width: 45, height: 45)
                            .padding(.leading, 20)
                    }
                    Spacer()
                }
                Spacer()
            }
            
            
            VStack(spacing: 20) {
                
                Spacer().frame(height: 320)
                
                ForEach(QuizMode.allCases, id: \.self) { mode in
                    Button(mode.description) {
                        onNext(mode)
                    }
                    .padding()
                    .font(.title3)
                    .bold()
                    .frame(width: 160, height: 60)
                    .background(Color.startBtn)
                    .foregroundColor(.white)
                    .cornerRadius(12)
                }
            }
            .padding()
        }
        
    }
}
