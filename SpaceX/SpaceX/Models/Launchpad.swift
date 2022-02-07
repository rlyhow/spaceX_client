//
//  Launchpad.swift
//  SpaceX
//
//  Created by Mikita Shalima on 7.02.22.
//

import Foundation
import UIKit

struct Launchpad: Codable {
    let name, fullName, locality, region: String
    let timezone: String
    let latitude, longitude: Double
    let launchAttempts, launchSuccesses: Int
    let rockets, launches: [String]
    let status, id: String
    let details: String

    enum CodingKeys: String, CodingKey {
        case name
        case fullName = "full_name"
        case locality, region, timezone, latitude, longitude
        case launchAttempts = "launch_attempts"
        case launchSuccesses = "launch_successes"
        case rockets, launches, status, id, details
    }
}

