//
//  RankingView.swift
//  MyMusic
//
//  Created by 市川涼 on 2025/05/08.
//

import SwiftUI

struct RankingView: View {
    @State private var selectedMode: QuizModeRank = .level_1
    @State private var selectedPeriod: RankingPeriod = .daily
    @State private var rankings: [RankingEntry] = []
    @State private var isLoading = false
    
    let onBack: () -> Void

    var body: some View {
        
        ZStack{
            
            //背景
            Image(.dojoGame)
                .resizable()
                .ignoresSafeArea()
                .opacity(0.5)
            
            VStack {
                
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
                
                // モード選択
                Picker("モード", selection: $selectedMode) {
                    Text("初級").tag(QuizModeRank.level_1)
                    Text("中級").tag(QuizModeRank.level_2)
                    Text("上級").tag(QuizModeRank.level_3)
                }
                .pickerStyle(SegmentedPickerStyle())
                .padding()
                
                // 期間選択
                Picker("期間", selection: $selectedPeriod) {
                    Text("今日").tag(RankingPeriod.daily)
                    Text("今週").tag(RankingPeriod.weekly)
                    Text("今月").tag(RankingPeriod.monthly)
                    Text("累計").tag(RankingPeriod.total)
                }
                .pickerStyle(SegmentedPickerStyle())
                .padding(.horizontal)
                
                // ランキング一覧
                if isLoading {
                    Color.white.opacity(0.6)
                        .ignoresSafeArea()
                    ProgressView()
                        .padding()
                } else if rankings.isEmpty {
                    Text("ランキングが見つかりません")
                        .foregroundColor(.gray)
                        .padding()
                } else {
                    List(rankings.indices, id: \.self) { index in
                        let entry = rankings[index]
                        HStack {
                            
                            if index == 0 {
                                Image(.medal1)
                                    .resizable()
                                    .frame(width: 35, height: 35)
                                    .padding(.trailing, 6)
                                
                            } else if index == 1 {
                                Image(.medal2)
                                    .resizable()
                                    .frame(width: 35, height: 35)
                                    .padding(.trailing, 6)

                            } else if index == 2 {
                                Image(.medal3)
                                    .resizable()
                                    .frame(width: 35, height: 35)
                                    .padding(.trailing, 6)

                            } else {
                                Text("\(index + 1)")
                                    .bold()
                                    .frame(width: 24, alignment: .trailing)
                                    .padding(.trailing, 17)
                            }
                            
                            Text(entry.userName)
                            Spacer()
                            Text("\(entry.score)")
                                .bold()
                            
                        }
                    }
                    .scrollContentBackground(.hidden) // ← これで背景を消す！

                }
            }
            .navigationTitle("ランキング")
            .onAppear {
                loadRankings()
            }
            .onChange(of: selectedMode) { loadRankings() }
            .onChange(of: selectedPeriod) { loadRankings() }
        }
        
        
    }
        

    func loadRankings() {
        isLoading = true
        RankingManager.shared.fetchTopRankings(mode: selectedMode, period: selectedPeriod) { result in
            rankings = result
            isLoading = false
        }
    }
    
    
}

#Preview {
    RankingView(
        onBack: {}
    )
}
