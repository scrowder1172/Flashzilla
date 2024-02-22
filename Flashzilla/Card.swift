//
//  Card.swift
//  Flashzilla
//
//  Created by SCOTT CROWDER on 2/22/24.
//

import Foundation

struct Card {
    var prompt: String
    var answer: String
    
    static let example: Card = Card(prompt: "Who played the 13th Doctor in Doctor Who?", answer: "Jodie Whittaker")
}
