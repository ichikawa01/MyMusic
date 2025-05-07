//
//  ResultView.swift
//  MyMusic
//
//  Created by 市川涼 on 2025/05/06.
//


import SwiftUI

struct ResultView: View {
    
//    @Binding var path: NavigationPath
    let score: Int
    let mode: QuizMode
    
    let onNext: () -> Void


    var body: some View {
        
        ZStack{
            Image(.background)
                .resizable()
                .scaledToFill()
                .ignoresSafeArea()
            
            VStack(spacing: 20) {
                Text("結果発表")
                    .font(.largeTitle)
                    .foregroundColor(.black)
                    .padding()
                
                Text("スコア: \(score) 問正解！")
                    .font(.title)
                    .foregroundStyle(Color.black)

                Spacer().frame(height: 1)
                
                Button("退場") {
                    onNext()
                }
                .padding()
                .bold()
                .font(.title2)
                .frame(width: 120, height: 60)
                .background(Color.startBtn)
                .foregroundColor(.white)
                .cornerRadius(12)
                
            }
        }
        .navigationBarBackButtonHidden(true)

    }
}

#Preview {
    ResultView(
        score: 10,
        mode: .timeLimit,
        onNext: {}
    )
}
