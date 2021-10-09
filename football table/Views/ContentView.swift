//
//  ContentView.swift
//  football table
//
//  Created by Flynn Milton on 06/10/2021.
//

import SwiftUI

struct ContentView: View {
    @StateObject var viewModel = ViewModel()
    
    var body: some View {
        NavigationView {
            Group {
                if let league = viewModel.league {
                    LeagueTableView(league: league)
                } else {
                    Text("No data")
                }
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
        Button {
            viewModel.getLeague()
        } label: {
            if viewModel.isFetching {
                ProgressView()
            } else {
                Text("Fetch data")
            }
        }
        .padding(.bottom)
    }
    
    var sortMenu: some View {
        Menu {
            ForEach(SortType.allCases) { sortType in
                Button(sortType.rawValue) {
                    viewModel.sort(by: sortType)
                }
            }
        } label: {
            Label("Sort", systemImage: "arrow.up.arrow.down")
                .labelStyle(.iconOnly)
        }
        
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
