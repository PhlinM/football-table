//
//  DecodeDataTests.swift
//  football tableTests
//
//  Created by Flynn Milton on 10/10/2021.
//

import XCTest
@testable import football_table

class DecodeDataTests: XCTestCase {
    
    var team: Team!
    var league: League!

    override func setUpWithError() throws {
        try super.setUpWithError()
        team = Team(id: 0, name: "example", won: 0,
                    draw: 0, lost: 0, position: 0)
        league = League(teams: [team])
    }

    override func tearDownWithError() throws {
        team = nil
        league = nil
        try super.tearDownWithError()
    }

    func testTeamDecodesFromJSONFormat() throws {
        // given
        let exampleTeamStr = """
            {
                "position": 0,
                "team": {
                    "id": 0,
                    "name": "example",
                    "crestUrl": "example.picture"
                },
                "playedGames": 0,
                "form": null,
                "won": 0,
                "draw": 0,
                "lost": 0,
                "points": 0,
                "goalsFor": 0,
                "goalsAgainst": 0,
                "goalDifference": 0
            }
        """
        let exampleTeamData = Data(exampleTeamStr.utf8)
        
        // when
        let exampleTeam = try JSONDecoder().decode(Team.self, from: exampleTeamData)
        
        // then
        XCTAssertEqual(team, exampleTeam, "Team decoding protocol not working")
    }
    
    func testLeagueDecodesFromJSONFormat() throws {
        // given
        let exampleLeagueStr = """
        {
            "filters": {},
            "competition": {
                "id": 2021,
                "area": {
                    "id": 2072,
                    "name": "England"
                },
                "name": "Premier League",
                "code": "PL",
                "plan": "TIER_ONE",
                "lastUpdated": "2021-04-17T02:20:14Z"
            },
            "season": {
                "id": 733,
                "startDate": "2021-08-13",
                "endDate": "2022-05-23",
                "currentMatchday": 8,
                "winner": null
            },
            "standings": [{
                "stage": "REGULAR_SEASON",
                "type": "TOTAL",
                "group": null,
                "table": [{
                    "position": 0,
                    "team": {
                        "id": 0,
                        "name": "example",
                        "crestUrl": "example.picture"
                    },
                    "playedGames": 0,
                    "form": null,
                    "won": 0,
                    "draw": 0,
                    "lost": 0,
                    "points": 0,
                    "goalsFor": 0,
                    "goalsAgainst": 0,
                    "goalDifference": 0
                }]
            }]
        }
        """
        let exampleLeagueData = Data(exampleLeagueStr.utf8)
        
        // when
        let exampleLeague = try JSONDecoder().decode(League.self, from: exampleLeagueData)
        
        // then
        XCTAssertEqual(league, exampleLeague, "League decoding protocol not working")
    }
    
    func testLeagueCustomInitWorksWithGoodData() throws {
        // given
        let exampleLeagueStr = """
        {
            "filters": {},
            "competition": {
                "id": 2021,
                "area": {
                    "id": 2072,
                    "name": "England"
                },
                "name": "Premier League",
                "code": "PL",
                "plan": "TIER_ONE",
                "lastUpdated": "2021-04-17T02:20:14Z"
            },
            "season": {
                "id": 733,
                "startDate": "2021-08-13",
                "endDate": "2022-05-23",
                "currentMatchday": 8,
                "winner": null
            },
            "standings": [{
                "stage": "REGULAR_SEASON",
                "type": "TOTAL",
                "group": null,
                "table": [{
                    "position": 0,
                    "team": {
                        "id": 0,
                        "name": "example",
                        "crestUrl": "example.picture"
                    },
                    "playedGames": 0,
                    "form": null,
                    "won": 0,
                    "draw": 0,
                    "lost": 0,
                    "points": 0,
                    "goalsFor": 0,
                    "goalsAgainst": 0,
                    "goalDifference": 0
                }]
            }]
        }
        """
        let exampleLeagueData = Data(exampleLeagueStr.utf8)
        
        // when
        let exampleLeague = League(from: exampleLeagueData)!
        
        // then
        XCTAssertEqual(league, exampleLeague, "League decoding protocol not working")
    }
    
    func testLeagueCustomInitFailsWithBadData() throws {
        // given
        let exampleLeagueStr = "Bad formatted data"
        let exampleLeagueData = Data(exampleLeagueStr.utf8)
        
        // when
        let exampleLeague = League(from: exampleLeagueData)
        
        // then
        XCTAssertNil(exampleLeague, "Init fails with badly formatted data")
    }

}
