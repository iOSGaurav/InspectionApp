//
//  InspectionModel.swift
//  InspectionsApp
//
//  Created by Gaurav Parmar on 25/07/24.
//

// MARK: - InspectionModel
struct InspectionResponse: Codable, Equatable {
    var inspection: Inspection
    static func == (lhs: InspectionResponse, rhs: InspectionResponse) -> Bool {
        lhs.inspection == rhs.inspection
    }
}

// MARK: - Inspection
struct Inspection: Codable, Equatable {
    let area: Area
    let id: Int
    let inspectionType: InspectionType
    var survey: Survey
    
    static func == (lhs: Inspection, rhs: Inspection) -> Bool {
        lhs.id == rhs.id
    }
}

// MARK: - Area
struct Area: Codable {
    let id: Int
    let name: String
}

// MARK: - InspectionType
struct InspectionType: Codable {
    let access: String
    let id: Int
    let name: String
}

// MARK: - Survey
struct Survey: Codable {
    var categories: [Category]
}

// MARK: - Category
struct Category: Codable {
    let id: Int
    let name: String
    var questions: [Question]
}

// MARK: - Question
struct Question: Codable, Identifiable {
    let answerChoices: [AnswerChoice]
    let id: Int
    let name: String
    var selectedAnswerChoiceID: Int?
    
    enum CodingKeys: String, CodingKey {
        case answerChoices, id, name
        case selectedAnswerChoiceID = "selectedAnswerChoiceId"
    }
}

// MARK: - AnswerChoice
struct AnswerChoice: Codable, Identifiable {
    let id: Int
    let name: String
    let score: Double
}
