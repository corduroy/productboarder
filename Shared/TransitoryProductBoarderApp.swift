//
//  TransitoryProductBoarderApp.swift
//  Shared
//
//  Created by Joshua McKinnon on 21/12/2021.
//

import SwiftUI

@main
struct TransitoryProductBoarderApp: App {
	var network = Network()

    var body: some Scene {
        WindowGroup {
            ContentView()
				.environmentObject(network)

        }
    }
}
