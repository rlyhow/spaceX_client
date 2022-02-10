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
    // Overview
    let rocketDescription: String
    let firstFlight: String
    let costPerLaunch: Int
    let successRatePct: Int
    let mass: Mass
    let height, diameter: Diameter
    
    // Images
    let flickrImages: [String]
    
    // Engines
    let engines: Engines

    // FirstStage
    let firstStage: FirstStage

    // SecondStage
    let secondStage: SecondStage

    //LandingLegs
    let landingLegs: LandingLegs
    
    var rocketImage: UIImage?

    enum CodingKeys: String, CodingKey {
        case height, diameter, mass
        case firstStage = "first_stage"
        case secondStage = "second_stage"
        case engines
        case landingLegs = "landing_legs"
        case flickrImages = "flickr_images"
        case name
        case costPerLaunch = "cost_per_launch"
        case successRatePct = "success_rate_pct"
        case firstFlight = "first_flight"
        case rocketDescription = "description"
    }
}

// MARK: - Diameter
struct Diameter: Codable {
    let meters: Double
}
// MARK: - Mass
struct Mass: Codable {
    let kg: Int
}


// MARK: - Engines
struct Engines: Codable {
    let type: String
    let number: Int
    let version: String
    let layout: String?
    let propellant1: String
    let propellant2: String
    let thrustToWeight: Double

    enum CodingKeys: String, CodingKey {
        case number
        case type
        case version
        case layout
        case propellant1 = "propellant_1"
        case propellant2 = "propellant_2"
        case thrustToWeight = "thrust_to_weight"
    }
}

// MARK: - Thrust
struct Thrust: Codable {
    let kN: Int
}

// MARK: - FirstStage
struct FirstStage: Codable {
    let reusable: Bool
    let engines: Int
    let thrustSeaLevel: Thrust
    let thrustVacuum: Thrust
    let burnTimeSEC: Int?

    enum CodingKeys: String, CodingKey {
        case thrustSeaLevel = "thrust_sea_level"
        case thrustVacuum = "thrust_vacuum"
        case reusable
        case engines
        case burnTimeSEC = "burn_time_sec"
    }
}

// MARK: - SecondStage
struct SecondStage: Codable {
    let thrust: Thrust
    let reusable: Bool
    let engines: Int
    let burnTimeSEC: Int?

    enum CodingKeys: String, CodingKey {
        case thrust, reusable, engines
        case burnTimeSEC = "burn_time_sec"
    }
}

// MARK: - LandingLegs
struct LandingLegs: Codable {
    let number: Int
    let material: String?
}
