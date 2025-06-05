//
//  ContentView.swift
//  Vibration Analyzer
//
//  Created by LeeMinwoo on 11/13/23.
//

import SwiftUI
import SwiftData

struct ContentView: View {
    
    var body: some View {
        TabView {
            WBMainView()
                .tabItem {
                    Image(systemName: "microbe.circle")
                    Text("웨이트 밸런싱")
                }
            VectorSynthesis()
                .tabItem {
                    Image(systemName: "plus.diamond")
                    Text("벡터합성")
                }
        }
    }
    
    
    
}

#Preview {
    ContentView()
        .modelContainer(for: VibData.self, inMemory: true)
}
