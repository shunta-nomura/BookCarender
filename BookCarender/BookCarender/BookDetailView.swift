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

class getData : ObservableObject{
    
    @Published var data = [Book]()

    init() {
        let url = "https://www.googleapis.com/books/v1/volumes?q=%E3%82%BD%E3%83%BC%E3%83%89%E3%82%A2%E3%83%BC%E3%83%88%E3%82%AA%E3%83%B3%E3%83%A9%E3%82%A4%E3%83%B3"
        
        let session = URLSession(configuration: .default)
        
        session.dataTask(with: URL(string: url)!) { (data, _, err) in
            if err != nil{
                
                print((err?.localizedDescription)!)
                return
            }
            
            let json = try! JSON(data: data!)
            
            let items = json["items"].array!
            
            for i in items {
                let id = i["id"].stringValue
                let title = i["volumeInfo"]["title"].stringValue
                let description = i["volumeInfo"]["description"].stringValue
                let imurl = i["volumeInfo"]["imageLinks"]["thumbnail"].stringValue
                let url1 = i["volumeInfo"]["previewLink"].stringValue
                var author = ""
                if let authors = i["volumeInfo"]["authors"].array{
                    for j in authors{
                        author += "\(j.stringValue)"
                    }
                }
                DispatchQueue.main.async {
                    self.data.append(Book(id: id, title: title, authors: author, desc: description, imurl:imurl, url: url1))
                }
            }
        }.resume()
    }
}

struct Book : Identifiable {
    
    var id : String
    var title : String
    var authors : String = ""
    var desc : String
    var imurl : String
    var url : String
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
