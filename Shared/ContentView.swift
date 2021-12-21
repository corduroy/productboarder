//
//  ContentView.swift
//  Shared
//
//  Created by Joshua McKinnon on 21/12/2021.
//

import SwiftUI

struct ContentView: View {
	@EnvironmentObject var network: Network
    var body: some View {
		NavigationView {
			List {
				let filteredFeatures = network.features.filter{$0.status.name == "1 - Idea"}

				ForEach(filteredFeatures) { feature in
					HStack {
						Text(feature.status.name)
							.textCase(.uppercase)
						Text(feature.name)
					}
				}
			}
			.navigationTitle("Features")
			.listStyle(.plain)
		}
		.refreshable {
			do {
				network.featureStatuses = try await network.getFeatureStatuses()
			} catch {
				print("Error Getting Feature Statuses", error)
			}
			do {
				network.features = try await network.getFeatures()
			} catch {
				print("Error Getting Features", error)
			}
		}
		.task {
			do {
				network.featureStatuses = try await network.getFeatureStatuses()
			} catch {
				print("Error Getting Feature Statuses", error)
			}
			do {
				network.features = try await network.getFeatures()
			} catch {
				print("Error Getting Features", error)
			}
		}

    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
