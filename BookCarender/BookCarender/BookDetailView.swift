import SwiftUI
import SwiftyJSON
import SDWebImageSwiftUI
import WebKit

struct BookDetailView: View {
    let bookKeyword: String
    @ObservedObject var booksData = getData()
    
    var body: some View {
        NavigationView {
            Home()
                .navigationBarTitle("Books")
        }
    }
}

struct Home : View {
    
    @ObservedObject var Books = getData()
    @State var show = false
    @State var url = ""
    
    var body : some View {
        List(Books.data){i in
            
            HStack{
                WebImage(url: URL(string: i.imurl)).resizable().frame(width: 120,height: 170).cornerRadius(10)
                
                VStack(alignment: .leading, spacing: 10) {
                    Text(i.title).fontWeight(.bold)
                    Text(i.authors)
                    Text(i.desc).font(.caption).lineLimit(4)
                        .multilineTextAlignment(.leading)
                }
            }
            .onTapGesture {
                self.url = i.url
                self.show.toggle()
                print(self.url)
            }.sheet(isPresented: self.$show) {
                WebView(url: i.url)
            }
        }
    }
}

struct WebView : UIViewRepresentable {
    
    var url : String
    
    func makeUIView(context: UIViewRepresentableContext<WebView>) -> WKWebView {
        
        let view = WKWebView()
        view.load(URLRequest(url: URL(string: url)!))
        return view
    }
    
    func updateUIView(_ uiView: WKWebView, context: UIViewRepresentableContext<WebView>) {

    }
}
