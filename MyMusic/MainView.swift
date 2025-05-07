//
//  MainView.swift
//  MyMusic
//
//  Created by 市川涼 on 2025/05/06.
//

import SwiftUI

enum AppScreen {
    case start
    case modeSelect
    case categorySelect
    case game
    case result
}

struct MainView: View {
    @State private var currentScreen: AppScreen = .start
    @State private var showFade = false

    @State private var selectedMode: QuizMode = .timeLimit
    @State private var selectedCategory: QuizCategory = .level_1
    @State private var score: Int = 0

    var body: some View {
        ZStack {
            switch currentScreen {
                
            case .start:
                StartView {
                    transition(to: .modeSelect)
                }
                
            case .modeSelect:
                ModeSelectView (
                    onNext: { mode in
                        selectedMode = mode
                        transition(to: .categorySelect)
                    },
                    onBack: {
                        transition(to: .start)
                    }
                )
                
            case .categorySelect:
                CategorySelectView (
                    onNext: { category in
                        selectedCategory = category
                        transition(to: .game)
                    },
                    onBack: {
                        transition(to: .modeSelect)
                    }
                )
                
            case .game:
                GameView (
                    mode: selectedMode,
                    category: selectedCategory,
                    onFinish: { result in
                        score = result
                        transition(to: .result)
                    },
                    onBack: {
                        transition(to: .start)
                    }
                )
                
            case .result:
                ResultView(score: score, mode: selectedMode) {
                    transition(to: .start)
                }
            }

            if showFade {
                Color.black
                    .ignoresSafeArea()
                    .transition(.opacity)
            }
        }
        .animation(.easeInOut(duration: 0.5), value: showFade)
    }

    func transition(to next: AppScreen) {
        withAnimation {
            showFade = true
        }
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.6) {
            withAnimation {
                currentScreen = next
                showFade = false
            }
        }
    }
}


#Preview {
    MainView()
}
