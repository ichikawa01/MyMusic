//
//  StatusView.swift
//  MyMusic
//
//  Created by 市川涼 on 2025/05/08.
//
import SwiftUI

struct StatusView: View {
    let userId: String
    let onBack: () -> Void
    let onEditName: () -> Void
    
    var body: some View {
        ZStack {
            // 背景
            Image(.dojoGame)
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

            VStack(spacing: 24) {
                Text("道場の記録")
                    .font(.largeTitle)
                    .bold()
                    .foregroundStyle(Color.black)
                    .padding()
                
                Button("名前を変更する") {
                    onEditName()
                }
                .font(.title)
                .foregroundColor(.white)
                .bold()
                .padding()
                .frame(width: 260, height: 60)
                .background(Color.startBtn)
                .clipShape(RoundedRectangle(cornerRadius: 12))

                Button("ランキングを見る") {
                    // 今後実装
                }
                .font(.title)
                .foregroundColor(.white)
                .bold()
                .padding()
                .frame(width: 260, height: 60)
                .background(Color.startBtn)
                .clipShape(RoundedRectangle(cornerRadius: 12))

                Button("記録を見る") {
                    // 今後実装
                }
                .font(.title)
                .foregroundColor(.white)
                .bold()
                .padding()
                .frame(width: 260, height: 60)
                .background(Color.startBtn)
                .clipShape(RoundedRectangle(cornerRadius: 12))

            }
            .padding()
        }
    }
}

#Preview {
    StatusView(userId: "", onBack: {}, onEditName: {})
}
