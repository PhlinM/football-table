//
//  ContentView.swift
//  football table
//
//  Created by Flynn Milton on 06/10/2021.
//
// Football data provided by the Football-Data.org API

import SwiftUI

struct ContentView: View {
    @StateObject var viewModel = ViewModel()
    
    var body: some View {
        NavigationView {
            VStack {
                Text("Matches from the last 30 days")
                    .font(.title2)
                
                Text("Football data provided by the Football-Data.org API")
                    .font(.subheadline)
                    .foregroundColor(.secondary)
                
                Spacer()
                
                if let league = viewModel.league {
                    LeagueTableView(league: league)
                } else {
                    Text("No data")
                }
                
                Spacer()
            }
            .navigationBarHidden(true)
            .toolbar {
                ToolbarItemGroup(placement: .bottomBar) {
                    fetchButton
                    sortMenu
                }
            }
        }
        .navigationViewStyle(.stack)
    }
    
    @ViewBuilder
    var fetchButton: some View {
        if viewModel.isFetching {
            ProgressView()
                .accessibilityIdentifier("Progress View")
        } else {
            Button("Fetch data") {
                viewModel.getLeague()
            }
            .accessibilityIdentifier("Fetch Data Button")
        }
    }
    
    var sortMenu: some View {
        Menu {
            ForEach(SortType.allCases) { sortType in
                Button(sortType.rawValue) {
                    viewModel.sort(by: sortType)
                }
                .accessibilityIdentifier("Sort \(sortType.rawValue) button")
            }
        } label: {
            Label("Sort", systemImage: "arrow.up.arrow.down")
                .labelStyle(.iconOnly)
        }
        .accessibilityIdentifier("Sort Menu")
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
