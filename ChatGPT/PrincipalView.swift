//
//  PrincipalView.swift
//  ChatGPT
//
//  Created by Pedro Toledo on 7/8/23.
//

import SwiftUI
import OpenAISwift

struct PrincipalView: View {
    @State private var chatText: String = ""
    @EnvironmentObject private var model: Model
    
    var openAI = OpenAISwift(config: OpenAISwift.Config.makeDefaultOpenAI(apiKey: "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"))
    
    private var isFormValid: Bool {
        !chatText.isEmptyOrWhiteSpace
    }
    private func performSearch(){
        openAI.sendCompletion(with: chatText, maxTokens: 250) {result in
            switch result{
            case.success(let success):
                let answer = success.choices?.first?.text.trimmingCharacters(in: .whitespacesAndNewlines) ?? ""
                let query = Query(question: chatText, answer: answer)
                DispatchQueue.main.async {
                    model.queries.append(query)
                }
                do {
                    try model.saveQuery(query)
                }catch{
                    print(error.localizedDescription)
                }
                print("success")
            case.failure(let failure):
                print(failure)
                print("error en func perform Search")
            }
        }
    }
    
    var body: some View {
        VStack{
            ScrollView {
                
                ScrollViewReader { proxy in
                    ForEach(model.queries, id: \.self){query in
                        VStack(alignment: .leading){
                            Text(query.question)
                            Text(query.answer)
                        }
                        .frame(maxWidth: .infinity, alignment: .leading)
                        .padding([.bottom], 10)
                        .id(query.id)
                        .listRowSeparator(.hidden)
                    }
                    .listStyle(.plain)
                    .onChange(of: model.queries){ query in
                        if !model.queries.isEmpty {
                            let lastQuery = model.queries[model.queries.endIndex-1]
                            withAnimation{
                                proxy.scrollTo(lastQuery.id)
                            }
                        }
                    }
                }
            }
            .padding()
            
            Spacer()
            HStack{
                TextField("Search...", text: $chatText)
                    .font(.title)
                Spacer()
                Button(action: {
                    performSearch()
                },
                       label: {
                    Image(systemName: "magnifyingglass.circle.fill")
                        .font(.title)
                })
                .disabled(!isFormValid)
            }
        }
        .padding()
        .onChange(of: model.query) {query in
            model.queries.append(query)
        }
    }
    
}

struct PrincipalView_Previews: PreviewProvider {
    static var previews: some View {
        PrincipalView()
            .environmentObject(Model())
    }
}
