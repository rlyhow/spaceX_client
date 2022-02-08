//
//  Rocket.swift
//  SpaceX
//
//  Created by Mikita Shalima on 8.02.22.
//

import Foundation
import UIKit

// MARK: - Rocket
struct Rocket: Codable {
    let name: String
    let firstFlight: String
    let costPerLaunch: Int
    let successRatePct: Int
    let flickrImages: [String]

    var rocketImage: UIImage?

    enum CodingKeys: String, CodingKey {
        case name
        case firstFlight = "first_flight"
        case costPerLaunch = "cost_per_launch"
        case successRatePct = "success_rate_pct"
        case flickrImages = "flickr_images"
    }
}
