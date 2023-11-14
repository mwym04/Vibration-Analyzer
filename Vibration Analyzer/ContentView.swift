//
//  ContentView.swift
//  Vibration Analyzer
//
//  Created by LeeMinwoo on 11/13/23.
//

import SwiftUI
import SwiftData

struct ContentView: View {
    @Environment(\.modelContext) private var modelContext
    @Query private var vibData: [VibData]
    @State private var showingAlert = false
    @State private var name = ""
    
    var body: some View {
        NavigationStack{
            List {
                ForEach(vibData) { vibData in
                    NavigationLink {
                        DataInputView(vibData: vibData)
                    } label: {
                        Text("\(vibData.dataName)    \(vibData.dataDate.formatted())")
                    }
                }
                .onDelete(perform: deleteItems)
            }
            .navigationTitle("웨이트밸런싱")
            .toolbar {
                ToolbarItem {
                    EditButton()
                }
                ToolbarItem {
                    Button(action: {
                        showingAlert.toggle()
                    }, label: {
                        Label("데이터 생성", systemImage: "plus")
                    })
                    .alert("데이터 추가", isPresented: $showingAlert) {
                        TextField("설비명을 입력하시오.", text: $name)
                            .autocorrectionDisabled()
                        Button("확인") { addItem(dataName: name) }
                        Button("취소", role: .cancel) { }
                    }
                }
            }
        }
    }

    private func addItem(dataName: String) {
        withAnimation {
            let newItem = VibData(dataName: dataName)
            modelContext.insert(newItem)
        }
    }

    private func deleteItems(offsets: IndexSet) {
        withAnimation {
            for index in offsets {
                modelContext.delete(vibData[index])
            }
        }
    }
}

#Preview {
    ContentView()
        .modelContainer(for: VibData.self, inMemory: true)
}
