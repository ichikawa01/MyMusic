//
//  CategorySelectView.swift
//  MyMusic
//
//  Created by 市川涼 on 2025/05/06.
//

import SwiftUI

struct CategorySelectView: View {
//    @Binding var path: NavigationPath
    @Environment(\.dismiss) private var dismiss
    
    let onNext: (QuizCategory) -> Void
    let onBack: () -> Void
    let onStatus: () -> Void

    var body: some View {
        ZStack{
            //背景
            Image(.dojo)
                .resizable()
//                .scaledToFill()
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
                    // onStatus()
                    Button(action: {
                        onStatus()
                    }) {
                        Image(.menu)
                            .resizable()
                            .frame(width: 45, height: 45)
                            .padding(.trailing, 25)
                    }
                }
                Spacer()
            }
            
            VStack(spacing: 20) {
                
                Spacer().frame(height: 320)
                
                ForEach(QuizCategory.allCases, id: \.self) { category in
                    Button(category.title) {
                        onNext(category)
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
            .padding()
        }

        
    }
}

