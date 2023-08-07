//
//  Extentions.swift
//  ChatGPT
//
//  Created by Pedro Toledo on 7/8/23.
//

import Foundation

extension String{
    
    var isEmptyOrWhiteSpace: Bool {
        self.trimmingCharacters(in: .whitespacesAndNewlines).isEmpty
    }
}
