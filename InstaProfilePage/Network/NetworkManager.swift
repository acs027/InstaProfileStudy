//
//  NetworkManager.swift
//  InstaProfilePage
//
//  Created by ali cihan on 15.09.2024.
//

import Foundation
import Alamofire

class NetworkManager {
    private var page = 2
    private var url = "https://api.artic.edu/api/v1/artworks"
    
    func fetch(_ data: String, completion: @escaping (Result<[Post], Error>) -> Void) {
        let url = url + "?page=\(page)&limit=12"
        AF.request(url).validate().responseDecodable(of: ApiResponse.self) { response in
            switch response.result {
            case .success(let apiResponse):
                let baseURL = apiResponse.config.iiifURL
                
                var items = [Post]()
                
                let group = DispatchGroup()
                
                for artwork in apiResponse.data {
                    
                    guard let imageSubString = artwork.imageId else { continue }
                    let imgURL = "\(baseURL)/\(imageSubString)/full/843,/0/default.jpg"
                    
                    guard let title = artwork.title else { continue }
                    guard let artistTitle = artwork.artistTitle else { continue }
                    
                    group.enter()
                    self.fetchImageData(from: imgURL) { data in
                        defer { group.leave() }
                        if let data {
                            let post = Post(title: title, description: artistTitle, imgData: data)
                            items.append(post)
                        }
                    }
                }
                
                group.notify(queue: .main) {
                    self.page += 1
                    completion(.success(items))
                }
                
            case .failure(let error):
                completion(.failure(error))
                print("Error fetching data: \(error)")
            }
        }
    }
    
    private func fetchImageData(from url: String, completion: @escaping (Data?) -> Void) {
        AF.request(url).responseData { response in
            switch response.result {
            case .success(let data):
                completion(data)
            case .failure(let error):
                print("Error fetching image data: \(error.localizedDescription)")
                completion(nil)
            }
        }
    }
}
