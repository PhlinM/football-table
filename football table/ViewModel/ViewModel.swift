//
//  ViewModel.swift
//  football table
//
//  Created by Flynn Milton on 07/10/2021.
//

import Foundation
import SwiftUI

class ViewModel: ObservableObject {
    
    // MARK: Published varibles
    @Published private(set) var league: League?
    @Published private(set) var isFetching = false
    
    // MARK: Private varible
    private let apiToken = "7cfa6f09cc7a4ff0bf3950072d578984"
    
    // MARK: - Intents
    func sort(by sortType: SortType) {
        league?.sort(by: sortType)
    }
    
    func getLeague() {
        isFetching = true
        getData() { league in
            DispatchQueue.main.async {
                self.league = league
                self.isFetching = false
            }
        }
    }
    
    // MARK: Football API connection
    private func getData(completionHandeler: @escaping (League?) -> Void) {
        
        guard let url = URL(string: "https://api.football-data.org/v2/competitions/PL/standings")
        else { return }
        
        var request = URLRequest(url: url)
        request.setValue(apiToken, forHTTPHeaderField: "X-Auth-Token")
        
        URLSession(configuration: .default)
            .dataTask(with: request) { data, reponse, error in
            
            if let error = error {
                print("Error: \(error.localizedDescription)")
                completionHandeler(nil)
                return
            }
            
            guard let statusCode = (reponse as? HTTPURLResponse)?.statusCode
            else {
                print("Error")
                completionHandeler(nil)
                return
            }
            
            guard statusCode == 200 else {
                print("Status code: \(statusCode)")
                completionHandeler(nil)
                return
            }
            
            if let data = data {
                completionHandeler(League(from: data))
            }
        }.resume()
    }
}
