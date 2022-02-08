//
//  Launch.swift
//  SpaceX
//
//  Created by Mikita Shalima on 8.02.22.
//

import Foundation
import UIKit

// MARK: - Launch
struct Launch: Codable {
    let links: Links
    
    let staticFireDateUTC: String?
    let success: Bool?
    let details: String?
    let launchpad: String
    let rocket: String
    let autoUpdate: Bool
    let flightNumber: Int
    let name: String
    let dateUTC: String
    let upcoming: Bool
    let id: String
    
    var patchImage: UIImage?

    enum CodingKeys: String, CodingKey {
        case links
        case staticFireDateUTC = "static_fire_date_utc"
        case details, success, rocket, launchpad
        case autoUpdate = "auto_update"
        case flightNumber = "flight_number"
        case name, upcoming, id
        case dateUTC = "date_utc"
    }
}

// MARK: - Links
struct Links: Codable {
    let patch: Patch
    let reddit: Reddit
    let flickr: Flickr
    let presskit: String?
    let webcast: String?
    let youtubeID: String?
    let article, wikipedia: String?

    enum CodingKeys: String, CodingKey {
        case patch, reddit, flickr, presskit, webcast
        case youtubeID = "youtube_id"
        case article, wikipedia
    }
}

// MARK: - Flickr
struct Flickr: Codable {
    let original: [String]?
}

// MARK: - Patch
struct Patch: Codable {
    let small, large: String?
}

// MARK: - Reddit
struct Reddit: Codable {
    let campaign, launch, media: String?
    let recovery: String?
}
