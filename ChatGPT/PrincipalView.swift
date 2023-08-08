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
    @State private var answers: [String] = []
    
    var openAI = OpenAISwift(config: OpenAISwift.Config.makeDefaultOpenAI(apiKey: "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"))
    
    private var isFormValid: Bool {
        !chatText.isEmptyOrWhiteSpace
    }
    private func performSearch(){
        openAI.sendCompletion(with: chatText, maxTokens: 250) {result in
            switch result{
            case.success(let success):
                let answer = success.choices?.first?.text.trimmingCharacters(in: .whitespacesAndNewlines) ?? ""
                answers.append(answer)
                print("success")
            case.failure(let failure):
                print(failure)
                print("error en func perform Search")
            }
        }
    }
    
    var body: some View {
        VStack{
            List(answers, id: \.self){answer in
                Text(answer)
                
            }
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
    }
    
}

struct PrincipalView_Previews: PreviewProvider {
    static var previews: some View {
        PrincipalView()
    }
}
