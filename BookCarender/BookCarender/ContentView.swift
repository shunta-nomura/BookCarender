//
//  ContentView.swift
//  BookCarender
//
//  Created by 野村俊太 on 2022/08/02.
//

import SwiftUI

struct ContentView: View {
    @State private var name = ""
    @State private var message = ""
    @State private var editting = false
    
    var body: some View {
        VStack {
            
            TextField("名前を入力して下さい", text: $name,
                      
                      onEditingChanged: { begin in
                /// 入力開始処理
                if begin {
                    self.editting = true    // 編集フラグをオン
                    self.message = ""       // メッセージをクリア
                    
                    /// 入力終了処理
                } else {
                    self.editting = false   // 編集フラグをオフ
                }
            },
                      /// リターンキーが押された時の処理
                      onCommit: {
                self.message = "こんにちは、\(self.name)さん"   // メッセージセット
                self.name = ""  // 入力域をクリア
                
            })
                .textFieldStyle(RoundedBorderTextFieldStyle()) // 入力域を枠で囲む
                .padding()      // 余白を追加
            // 編集フラグがONの時に枠に影を付ける
                .shadow(color: editting ? .blue : .clear, radius: 3)
            
            Text(message)
        }
    }
}

func getNobel() {
    
}


struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
