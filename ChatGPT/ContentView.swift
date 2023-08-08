//
//  ContentView.swift
//  ChatGPT
//
//  Created by Pedro Toledo on 7/8/23.
//

import SwiftUI

struct ContentView: View {
    @State private var isPresented: Bool = false
    var body: some View {
        NavigationStack{
            PrincipalView()
                .sheet(isPresented: $isPresented, content: {NavigationStack{
                    HistoryView()
                        .navigationTitle("History")
                }
                })
                .toolbar{
                    ToolbarItem(placement: .navigationBarTrailing){
                        Button(action: {
                            isPresented = true
                        }, label: {
                            Text("Show History")
                        })
                    }
                }
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
            .environment(\.managedObjectContext, CoreDataManager.shared.persistentContainer.viewContext)
            .environmentObject(Model())
    }
}
