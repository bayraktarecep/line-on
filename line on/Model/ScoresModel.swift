//
//  ScoresModel.swift
//  line on
//
//  Created by Recep Bayraktar on 28.08.2021.
//

import Foundation

// MARK: - ScoresModel
struct ScoresModel: Codable {
    let name, format, date: String
    let matches: [Match]
    let displayRound: Bool
}

// MARK: - Match
struct Match: Codable {
    let id: Int
    let dateTimeutc, matchTime, status: String
    let ftsA, ftsB, htsA, htsB: Int
    let teamA, teamB: Team
    let extras: Extras

    enum CodingKeys: String, CodingKey {
        case id
        case dateTimeutc = "date_time_utc"
        case matchTime = "match_time"
        case status
        case ftsA = "fts_A"
        case ftsB = "fts_B"
        case htsA = "hts_A"
        case htsB = "hts_B"
        case teamA = "team_A"
        case teamB = "team_B"
        case extras
    }
}

// MARK: - Extras
struct Extras: Codable {
    let iddaaCode: Int
    let iddaaLive: Bool
    let teamBRedcards, teamARedcards: Int?

    enum CodingKeys: String, CodingKey {
        case iddaaCode = "iddaa_code"
        case iddaaLive = "iddaa_live"
        case teamBRedcards = "team_B_redcards"
        case teamARedcards = "team_A_redcards"
    }
}

// MARK: - Team
struct Team: Codable {
    let id: Int
    let uuid, name, tlaName, displayName: String

    enum CodingKeys: String, CodingKey {
        case id, uuid, name
        case tlaName = "tla_name"
        case displayName = "display_name"
    }
}
