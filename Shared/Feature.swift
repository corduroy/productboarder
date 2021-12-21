//
//  Feature.swift
//  TransitoryProductBoarder
//
//  Created by Joshua McKinnon on 21/12/2021.
//

import Foundation

struct FeaturesContainer: Decodable {
	var features:	[Feature]
	enum CodingKeys: String, CodingKey {
		case features = "data"
	}
}

struct StatusesContainer: Decodable {
	var statuses:	[FeatureStatus]
	enum CodingKeys: String, CodingKey {
		case statuses = "data"
	}
}


struct Feature: Identifiable,Decodable {
	var id:		UUID
	var name:	String
	var longDesc:	String
	var type:		String
	var status:		FeatureStatus
//	var parentId:	UUID
//	var timeframe:	Timeframe
	
	enum CodingKeys: String, CodingKey {
		case id
		case name
		case longDesc = "description"
		case type
		case status
//		case parentId = "parent"
//		case timeframe
	}
}

struct FeatureStatus: Identifiable,Decodable {
	var id:		UUID
	var name:	String
}

struct Timeframe: Decodable {
	var startDate: 	Date
	var endDate: 	Date
}
