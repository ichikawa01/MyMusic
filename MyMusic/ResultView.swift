//
//  ResultView.swift
//  MyMusic
//
//  Created by 市川涼 on 2025/05/06.
//


import SwiftUI

struct ResultView: View {
    
    let score: Int
    let characterCount: Int
    let mode: QuizMode
    
    let onNext: () -> Void
    let onRanking: () -> Void


    var body: some View {
        
        ZStack{
            Image(.result)
                .resizable()
//                .scaledToFill()
                .ignoresSafeArea()
            
            VStack(spacing: 20) {
                
                Spacer().frame(height: 70)
                
                ZStack{
                    
                    Image(.makimono)
                        .resizable()
                        .frame(height: 140)
                        .ignoresSafeArea()
                    
                    VStack{
                        Text(" \(score) 問クリア！")
                            .font(.largeTitle)
                            .foregroundStyle(Color.black)
                        
                        Text("合計 \(characterCount) 文字")
                            .font(.title2)
                            .foregroundStyle(Color.black)
                    }

                }

                Spacer().frame(height: 60)
                
                VStack (spacing: 20) {
                    Button("退場") {
                        onNext()
                    }
                    .padding()
                    .font(.title)
                    .bold()
                    .frame(width: 160, height: 60)
                    .foregroundColor(.white)
                    .background(Color.startBtn)
                    .cornerRadius(12)
                                        
                    Button("ランキングへ") {
                        onRanking()
                    }
                    .padding()
                    .font(.title3)
                    .bold()
                    .frame(width: 160, height: 60)
                    .foregroundColor(.white)
                    .background(Color.startBtn)
                    .cornerRadius(12)
                    
                }
                
                
            }
        }
        .navigationBarBackButtonHidden(true)

    }
}

#Preview {
    ResultView(
        score: 12,
        characterCount: 56,
        mode: .timeLimit,
        onNext: {},
        onRanking: {}
    )
}
