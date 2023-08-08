//
//  HistoryView.swift
//  ChatGPT
//
//  Created by Pedro Toledo on 8/8/23.
//

import SwiftUI

struct HistoryView: View {
    @EnvironmentObject private var model: Model
    @Environment(\.dismiss) private var dismiss
    @FetchRequest(sortDescriptors: [NSSortDescriptor(key: "dateCreated", ascending: true)])
    private var historyItemsResults: FetchedResults<HistoryItem>
    
    var body: some View {
        List(historyItemsResults){historyItem in
            Text(historyItem.question ?? "")
                .contentShape(Rectangle())
                .onTapGesture {
                    model.query = Query(question: historyItem.question ?? "", answer: historyItem.answer ?? "")
                    dismiss()
                }
        }
    }
}

struct HistoryView_Previews: PreviewProvider {
    static var previews: some View {
        HistoryView()
            
    }
}
