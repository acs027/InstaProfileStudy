//
//  ProfileViewModel.swift
//  InstaProfilePage
//
//  Created by ali cihan on 9.09.2024.
//

import Foundation
import Alamofire
import Combine

class ProfileViewModel {
    @Published var posts = [Post]()
    @Published var reels = [Post]()
    @Published var savedPosts = [Post]()
    @Published var stories = [Post]()
    
    let networkManager = NetworkManager()
    
    enum content: String {
        case posts
        case reels
        case stories
        case savedPosts
    }

    func fetch(_ data: content) {
        networkManager.fetch(data.rawValue) { [weak self] result in
            switch result {
            case .success(let items):
                if data == content.posts {
                    self?.posts += items
                } else if data == content.reels {
                    self?.reels += items
                } else if data == content.savedPosts {
                    self?.savedPosts += items
                }
                if data == content.posts {
                    self?.stories += items[0...2]
                }
                
            case .failure(let error):
                print("\(data.rawValue) couldn't fetch.")
            }
        }
    }
}
