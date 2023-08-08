//
//  Query.swift
//  ChatGPT
//
//  Created by Pedro Toledo on 7/8/23.
//

import Foundation

struct Query: Identifiable, Hashable{
    
    let id = UUID()
    let question: String
    let answer: String
}
