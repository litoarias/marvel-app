//
//	Result.swift
//	Model file generated using JSONExport: https://github.com/Ahmed-Ali/JSONExport

import Foundation

struct ComicResult: Codable {
	let characters: ComicCharacter?
	let collectedIssues: [String]?
	let collections: [String]?
	let creators: ComicCharacter?
	let dates: [ComicDate]?
	let descriptionField: String?
	let diamondCode: String?
	let digitalId: Int?
	let ean: String?
	let events: Event?
	let format: String?
	let id: Int?
	let images: [String]?
	let isbn: String?
	let issn: String?
	let issueNumber: Int?
	let modified: String?
	let pageCount: Int?
	let prices: [Price]?
	let resourceURI: String?
	let series: Sery?
	let stories: ComicCharacter?
	let textObjects: [String]?
	let thumbnail: Thumbnail?
	let title: String?
	let upc: String?
	let urls: [ComicUrl]?
	let variantDescription: String?
	let variants: [String]?
}
