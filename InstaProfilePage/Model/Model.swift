//
//  Model.swift
//  InstaProfilePage
//
//  Created by ali cihan on 10.09.2024.
//

import Foundation

struct Post {
    var title: String
    var description: String
    var imgData: Data
}

// Model for API response
struct ApiResponse: Codable {
    let data: [Artwork]
    let config: Config
}

struct Artwork: Codable {
    let imageId: String?
    let title: String?
    let artistTitle: String?

    enum CodingKeys: String, CodingKey {
        case imageId = "image_id"
        case title
        case artistTitle = "artist_title"
    }
}

struct Config: Codable {
    let iiifURL: String

    enum CodingKeys: String, CodingKey {
        case iiifURL = "iiif_url"
    }
}

