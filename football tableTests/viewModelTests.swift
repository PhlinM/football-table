//
//  viewModelTests.swift
//  football tableTests
//
//  Created by Flynn Milton on 10/10/2021.
//

import XCTest
@testable import football_table

import Network

class NetworkMonitor {
    static let shared = NetworkMonitor()
    var isReachable: Bool { status == .satisfied }

    private let monitor = NWPathMonitor()
    private var status = NWPath.Status.requiresConnection

    private init() {
        startMonitoring()
    }

    func startMonitoring() {
        monitor.pathUpdateHandler = { [weak self] path in
            self?.status = path.status
        }
        let queue = DispatchQueue(label: "NetworkMonitor")
        monitor.start(queue: queue)
    }

    func stopMonitoring() {
        monitor.cancel()
    }
}

class viewModelTests: XCTestCase {
    
    var sut: ViewModel!
    let networkMonitor = NetworkMonitor.shared
    
    override func setUpWithError() throws {
        try super.setUpWithError()
        sut = ViewModel()
    }

    override func tearDownWithError() throws {
        sut = nil
        try super.tearDownWithError()
    }
    
    func testSortByPositionWhenNil() throws {
        // Given
        sut.setLeauge(league: nil)
        
        // When
        sut.sort(by: .position)
        
        // Then
        XCTAssertNil(sut.league, "")
    }

    func testSortByPosition() throws {
        // Given
        let teamIDOrderedByPosition = [61,64,65,66,62,397,402,73,563,58,57,76,338,354,346,341,340,328,67,68]
        sut.setLeauge(league: .example)

        // When
        sut.sort(by: .position)

        // Then
        let temp = sut.league!.teams.map({ $0.id })
        XCTAssertEqual(temp, teamIDOrderedByPosition, "Sorting teams by position is wrong")
    }

    func testSortByWins() throws {
        // Given
        let teamIDOrderedByWins = [61,64,65,66,62,397,73,402,563,58,57,76,338,346,354,341,340,328,67,68]
        sut.setLeauge(league: .example)

        // When
        sut.sort(by: .won)

        // Then
        let temp = sut.league!.teams.map({ $0.id })
        print(temp)
        XCTAssertEqual(temp, teamIDOrderedByWins, "Sorting teams by wins is wrong")
    }

    func testSortByLost() throws {
        // Given
        let teamIDOrderedByLost = [68,76,346,328,67,73,58,57,338,341,340,563,354,61,65,66,62,397,402,64]
        sut.setLeauge(league: .example)

        // When
        sut.sort(by: .lost)

        // Then
        let temp = sut.league!.teams.map({ $0.id })
        print(temp)
        XCTAssertEqual(temp, teamIDOrderedByLost, "Sorting teams by loses is wrong")
    }

    func testSortByName() throws {
        // Given
        let teamIDOrderedByName = [57,58,402,397,328,61,354,62,341,338,64,65,66,67,68,340,73,346,563,76]
        sut.setLeauge(league: .example)

        // When
        sut.sort(by: .name)

        // Then
        let temp = sut.league!.teams.map({ $0.id })
        print(temp)
        XCTAssertEqual(temp, teamIDOrderedByName, "Sorting teams by names is wrong")
    }
    
    func testGetLeague() throws {
        try XCTSkipUnless(
            networkMonitor.isReachable,
            "Network connectivity needed for this test."
        )
        
        // When
        sut.getLeague()
        
        // Then
        XCTAssertTrue(sut.isFetching, "Completion handeler was never executed")
    }
}
