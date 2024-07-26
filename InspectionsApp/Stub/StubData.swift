//
//  StubData.swift
//  InspectionsApp
//
//  Created by Gaurav Parmar on 25/07/24.
//

let stubData = InspectionResponse(
    inspection: Inspection(
        area: Area(id: 4, name: "Barton Ward"),
        id: 46,
        inspectionType: InspectionType(access: "none", id: 5, name: "Patient Survey"),
        survey: Survey(
            categories: [
                Category(
                    id: 0,
                    name: "Staff Presence",
                    questions: question1
                ),
                Category(
                    id: 1,
                    name: "Drugs",
                    questions: question2
                ),
                Category(
                    id: 2,
                    name: "Staff Presence",
                    questions: question3
                ),
                Category(
                    id: 3,
                    name: "Patient Happiness",
                    questions: question4
                )
            ]
        )
    )
)
let question1 = [
    Question(
        answerChoices: answer1,
        id: 5,
        name: "How many staff members are present in the ward?",
        selectedAnswerChoiceID: nil
    )
]
let question2 = [
    Question(
        answerChoices: answer2,
        id: 8,
        name: "How many hospital beds are occupied at the time of the inspection?",
        selectedAnswerChoiceID: nil
    ),
    Question(
        answerChoices: answer1,
        id: 5,
        name: "How many staff members are present in the ward?",
        selectedAnswerChoiceID: nil
    )
]
let question3 = [
    Question(
        answerChoices: answer3,
        id: 3,
        name: "How often is the floor cleaned?",
        selectedAnswerChoiceID: 2
    )
]
let question4 = [
    Question(
        answerChoices: answer2,
        id: 8,
        name: "How many hospital beds are occupied at the time of the inspection?",
        selectedAnswerChoiceID: nil
    ),
    Question(
        answerChoices: answer3,
        id: 4,
        name: "How often is the floor cleaned?",
        selectedAnswerChoiceID: nil
    ),
    Question(
        answerChoices: answer4,
        id: 2,
        name: "Are the drawers locked?",
        selectedAnswerChoiceID: 2
    )
]
let answer1 = [
    AnswerChoice(id: 1, name: "1-2", score: 0.5),
    AnswerChoice(id: 2, name: "3-6", score: 0.5),
    AnswerChoice(id: 3, name: "6+", score: 0.5)
]

let answer2 = [
    AnswerChoice(id: 1, name: "100%", score: 0.0),
    AnswerChoice(id: 2, name: "75%", score: 0.5),
    AnswerChoice(id: 3, name: "50%", score: 1.0),
    AnswerChoice(id: 4, name: "25%", score: 0.5),
    AnswerChoice(id: 5, name: "0%", score: 0.0)
]
let answer3 = [
    AnswerChoice(id: 1, name: "Everyday", score: 1.0),
    AnswerChoice(id: 2, name: "Every two days", score: 0.5),
    AnswerChoice(id: 3, name: "Every week", score: 0.0)
]
let answer4 = [
    AnswerChoice(id: 1, name: "Yes", score: 1.0),
    AnswerChoice(id: 2, name: "No", score: 0.0)
]
