//
//  LeagueTableView.swift
//  football table
//
//  Created by Flynn Milton on 09/10/2021.
//

import SwiftUI

struct LeagueTableView: View {
    var league: League
    
    var body: some View {
        List(league.teams) {
            TeamView(team: $0)
        }
    }
}

struct TeamView: View {
    let team: Team
    
    var body: some View {
        VStack {
            HStack {
                Text(team.name)
                Spacer()
            }
            
            HStack {
                Text("\(team.won) won")
                Text("\(team.draw) draw")
                Text("\(team.lost) lost")
                Spacer()
            }
        }
    }
}

struct LeagueTableView_Previews: PreviewProvider {
    static var previews: some View {
        TeamView(team: League.example.teams[0])
            .previewLayout(.sizeThatFits)
        LeagueTableView(league: League.example)
    }
}
