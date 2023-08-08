//
//  Model.swift
//  ChatGPT
//
//  Created by Pedro Toledo on 7/8/23.
//

import Foundation

class Model: ObservableObject{
    @Published var queries: [Query] = []
    
    func saveQuery(_query: Query) throws{
        let viewContext = CoreDataManager.shared.persistentContainer.viewContext
        let historyItem = HistoryItem(context: viewContext)
        historyItem.question = Query.
    }
}
