//
//  League.swift
//  football table
//
//  Created by Flynn Milton on 09/10/2021.
//
// Football data provided by the Football-Data.org API

import Foundation

enum SortType: String, CaseIterable, Identifiable {
    case won, lost, draw, position, name
    
    var id: String { self.rawValue }
}

struct League: Equatable {
    var teams: [Team]
    
    mutating func sort(by sortType: SortType) {
        var predicate: (Team, Team) -> Bool {
            switch sortType {
            case .won:
                return { $0.won > $1.won }
            case .lost:
                return { $0.lost > $1.lost }
            case .draw:
                return { $0.draw > $1.draw }
            case .position:
                return { $0.position < $1.position }
            case .name:
                return { $0.name < $1.name }
            }
        }
        
        teams.sort(by: predicate)
    }
}

extension League: Decodable {
    
    private enum CodingKeys: String, CodingKey {
        case standings
    }
    
    private enum StandingsCodingKeys: String, CodingKey {
        case table
    }
    
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        var standings = try container.nestedUnkeyedContainer(forKey: .standings)
        let total = try standings.nestedContainer(keyedBy: StandingsCodingKeys.self)
        teams = try total.decode([Team].self, forKey: .table)
    }
    
    init?(from data: Data) {
        do {
            let decoder = JSONDecoder()
            self = try decoder.decode(League.self, from: data)
        } catch let error {
            print("Failed to decode: ", error.localizedDescription)
            return nil
        }
        sort(by: .position)
    }
}
