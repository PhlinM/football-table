//
//  LeagueExample.swift
//  football table
//
//  Created by Flynn Milton on 09/10/2021.
//

import Foundation

extension League {
    static var example: League {
        let file = Bundle.main.url(forResource: "Example", withExtension: "json")!
        let data = try! Data(contentsOf: file)
        return League(from: data)!
    }
}
