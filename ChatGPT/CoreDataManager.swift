//
//  CoreDataManager.swift
//  ChatGPT
//
//  Created by Pedro Toledo on 7/8/23.
//

import Foundation
import CoreData

class CoreDataManager {
    let persistentContainer: NSPersistentContainer
    static let shared = CoreDataManager()
    
    private init(){
        persistentContainer = NSPersistentContainer(name: "HistoryModel")
        persistentContainer.loadPersistentStores(completionHandler: {description, error in
            if let error = error{
                fatalError("CoreData Store failed \(error.localizedDescription)")
            }
        })
    }
}
