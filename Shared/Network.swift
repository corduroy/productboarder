//
//  Network.swift
//  TransitoryProductBoarder
//
//  Created by Joshua McKinnon on 21/12/2021.
//

import SwiftUI

class Network: ObservableObject {
//	@Published var container: Container = Container(features: [])
	@Published var features: [Feature] = []
	@Published var featureStatuses: [FeatureStatus] = []
	
	let apiKey = Bundle.main.infoDictionary!["APIKey"] as! String
	let baseURL = "https://api.productboard.com/"
	
	func featureStatusesUrl() -> URL {
		let urlString = self.baseURL + "feature-statuses"
		return URL(string:urlString)!
	}
	
	func getFeatureStatuses() async throws -> [FeatureStatus] {
		var urlRequest = URLRequest(url:self.featureStatusesUrl())
		urlRequest.addValue("Bearer \(apiKey)", forHTTPHeaderField: "Authorization")
		urlRequest.addValue("1", forHTTPHeaderField: "X-Version")
		let (data, response) = try await URLSession.shared.data(for: urlRequest)
		guard (response as? HTTPURLResponse)?.statusCode == 200 else { fatalError("Error while fetching data") }
		let decoder = JSONDecoder.init()
		decoder.dateDecodingStrategy = .iso8601
		let topDict: StatusesContainer = try decoder.decode(StatusesContainer.self, from: data)

//		let decodedStatuses = try decoder.decode([FeatureStatus].self, from: data)
		return topDict.statuses
	}
	
	func featuresUrl() -> URL {
		let urlString = self.baseURL + "features?pageLimit=100"
		return URL(string:urlString)!
	}
	
	func getFeatures() async throws -> [Feature] {
		var urlRequest = URLRequest(url:self.featuresUrl())
		urlRequest.addValue("Bearer \(apiKey)", forHTTPHeaderField: "Authorization")
		urlRequest.addValue("1", forHTTPHeaderField: "X-Version")

		let (data, response) = try await URLSession.shared.data(for: urlRequest)
		guard (response as? HTTPURLResponse)?.statusCode == 200 else { fatalError("Error while fetching data") }
		let decoder = JSONDecoder.init()
		decoder.dateDecodingStrategy = .iso8601
		let topDict: FeaturesContainer = try decoder.decode(FeaturesContainer.self, from: data)
		return topDict.features
	}
	
}

