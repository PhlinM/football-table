//
//  Team.swift
//  football table
//
//  Created by Flynn Milton on 07/10/2021.
//

import Foundation

struct Team: Identifiable {
    let id: Int
    let name: String
    var won: Int
    var draw: Int
    var lost: Int
    var position: Int
}

extension Team: Decodable {
    enum CodingKeys: String, CodingKey {
        case team, position, won, draw, lost
    }
    
    enum TeamCodingKeys: String, CodingKey {
        case id, name
    }
    
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        
        position = try container.decode(Int.self, forKey: .position)
        won = try container.decode(Int.self, forKey: .won)
        draw = try container.decode(Int.self, forKey: .draw)
        lost = try container.decode(Int.self, forKey: .lost)
        
        let team = try container.nestedContainer(keyedBy: TeamCodingKeys.self, forKey: .team)
        
        id = try team.decode(Int.self, forKey: .id)
        name = try team.decode(String.self, forKey: .name)
    }
}
