////
////  Book.swift
////  BookCarender
////
////  Created by 野村俊太 on 2023/01/05.
////
//
//import Foundation
//
//struct Book: Codable {
//    var id: String
//    var volumeInfo: VolumeInfo
//}
//
//struct VolumeInfo: Codable {
//    var title: String
//    var authors: [String]?
//    var publisher: String?
//    var description: String?
//    var imageLinks: ImageLinks?
//}
//
//struct ImageLinks: Codable {
//    var thumbnail: String
//}
//
//class BooksData: ObservableObject {
//    @Published var books = [Book]()
//    
//    func loadData() {
//        guard let url = URL(string: "https://www.googleapis.com/books/v1/volumes?q=Swift") else {
//            print("Invalid URL")
//            return
//        }
//        
//        let task = URLSession.shared.dataTask(with: url) { data, _, error in
//            if let error = error {
//                print("Error Occurred:\(error.localizedDescription)")
//            } else if let data = data {
//                do {
//                    let decodedData = try JSONDecoder().decode(Books.self, from: data)
//                    DispatchQueue.main.async {
//                        self.books = decodedData.items
//                    }
//                } catch(let error) {
//                    print("Error In Parsing:\(error.localizedDescription)")
//                }
//            }
//        }
//        task.resume()
//    }
//}
//
//struct Books: Codable {
//    var items: [Book]
//}
//
