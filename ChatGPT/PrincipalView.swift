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
    
    var openAI = OpenAISwift(config: OpenAISwift.Config.makeDefaultOpenAI(apiKey: "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"))
    
    private var isFormValid: Bool {
        !chatText.isEmptyOrWhiteSpace
    }
    private func performSearch(){
        openAI.sendCompletion(with: chatText, maxTokens: 250) {
            switch result{
            case.success(<#T##Success#>)
            }
        }
    }
    
    var body: some View {
        VStack{
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
