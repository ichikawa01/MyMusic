//
//  NameEditView.swift
//  MyMusic
//
//  Created by 市川涼 on 2025/05/08.
//

import SwiftUI
import FirebaseFirestore

struct NameEditView: View {
    let userId: String
    let onClose: () -> Void
    @State private var name = ""
    @State private var loading = true
    @FocusState private var isInputFocused: Bool
    
    let onBack: () -> Void
    
    var skipLoad: Bool = false // ← プレビュー用フラグ


    var body: some View {
        
        ZStack{
            
            //背景
            Image(.dojoGame)
                .resizable()
                .ignoresSafeArea()
            
            VStack{
                HStack{
                    // 戻るボタン（左上）
                    Button(action: {
                        isInputFocused = false
                        onClose()
                    }) {
                        Image(.backIconWhite)
                            .resizable()
                            .frame(width: 45, height: 45)
                            .padding(.leading, 40)
                    }
                    Spacer()
                }
                Spacer()
            }
            
            VStack (spacing: 20){
                if loading {
                    ProgressView()
                } else {
                    Text("新しい名前を入力")
                        .font(.largeTitle)
                        .bold()
                        .foregroundStyle(Color.black)
            
                    ZStack{
                        Image(.makimono)
                            .resizable()
                            .ignoresSafeArea()
                            .frame(width: 400, height: 120)
                        
                        TextField("", text: $name)
                            .focused($isInputFocused)
                            .textFieldStyle(PlainTextFieldStyle())
                            .frame(width: 240)
                            .padding(.horizontal, 80)
                            .multilineTextAlignment(.center)
                            .foregroundColor(.black)
                            .font(.system(size: 24))
                            .onAppear {
                                DispatchQueue.main.asyncAfter(deadline: .now()) {
                                    isInputFocused = true
                                }
                            }
                            .onChange(of: name) {
                                if name.count > 10 {
                                    name = String(name.prefix(10)) // 10文字に切り詰める
                                }
                            }
                        
                    }
                    HStack{
                        Button("キャンセル") {
                            isInputFocused = false
                            onClose()
                        }
                            .font(.title2)
                            .foregroundColor(.white)
                            .bold()
                            .padding()
                            .frame(width: 140, height: 60)
                            .background(Color.gray)
                            .clipShape(RoundedRectangle(cornerRadius: 12))
                        
                        Button("保存") {
                            isInputFocused = false
                            save()
                            onClose()
                        }
                        .disabled(name.trimmingCharacters(in: .whitespaces).isEmpty)
                        .font(.title)
                        .foregroundColor(.white)
                        .bold()
                        .padding()
                        .frame(width: 140, height: 60)
                        .background(Color.startBtn)
                        .clipShape(RoundedRectangle(cornerRadius: 12))
                        
                    }
                }
            }
            .padding()
            .onAppear {
                if !skipLoad{
                    load()
                } else {
                    loading = false
                    name = "あいうえおかきくけこ"
                }
            }
            
        }
        
    }

    func load() {
        let db = Firestore.firestore()
        db.collection("users").document(userId).getDocument { doc, _ in
            if let name = doc?.data()?["userName"] as? String {
                self.name = name
            }
            loading = false
        }
    }

    func save() {
        let db = Firestore.firestore()
        db.collection("users").document(userId).setData(["userName": name], merge: true)
    }
}

#Preview {
    NameEditView(
        userId: "",
        onClose: {},
        onBack: {},
        skipLoad: true // ← プレビューではロードしない

    )
}
