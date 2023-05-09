import SwiftUI

@available(iOS 16.0, *)
struct SwiftUiView: View {
    
    // 入力されたキーワード
    @State public var bookKeyword = ""
    // 画面遷移フラグ
    @State public var showingBookDetailViewFlg = false
    var body: some View {
        /// ナビゲーションの定義
        NavigationStack {
            VStack {
                Text("本のタイトルを入力して下さい")
                /// テキスト入力フィールド
                TextField("", text: $bookKeyword)
                    .textFieldStyle(RoundedBorderTextFieldStyle())  // 枠ありスタイル
                    .padding(.horizontal)                           // 左右に余白
                // 改行された後のタップ処理
                    .onSubmit {
                        self.showingBookDetailViewFlg = true
                    }
            }
            // ナビゲーションタイトルの定義
            .navigationTitle("Top View")
            // 画面遷移フラグがtrueになった時の遷移先を指定
            .navigationDestination(isPresented: $showingBookDetailViewFlg) {
//                BookDetailView()
                BookDetailView(bookKeyword: bookKeyword)
            }
        }
    }
}
