//
//  BookController.swift
//  BookCarender
//
//  Created by 野村俊太 on 2023/06/12.
//

import SwiftyJSON
import SDWebImageSwiftUI

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
