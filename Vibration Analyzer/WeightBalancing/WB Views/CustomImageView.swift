//
//  CustomImageVIew.swift
//  Vibration Analyzer
//
//  Created by LeeMinwoo on 11/17/23.
//

import SwiftUI

struct CustomImageView: View {
    
    let systemName: String
    @Binding var modify: Int?
    let addValue: Int
    
    @State private var isPressed = false
    @State private var timer: Timer?
    
    let generator = UIImpactFeedbackGenerator(style: .light)
    
    var body: some View {
        Image(systemName: systemName)
            .foregroundStyle(Color.blue)
            .font(.title)
            .scaleEffect(isPressed ? 1.2 : 1.0)
            .opacity(isPressed ? 0.7 : 1.0)
            .animation(.easeInOut(duration: 0.2), value: isPressed)
            .gesture(
                DragGesture(minimumDistance: 0)
                    .onChanged { _ in startCounting() }
                    .onEnded { _ in stopCounting() }
            )
            .onTapGesture {
                updateValue()
                feedback()
            }
    }
    
    private func startCounting() {
        guard timer == nil else { return }
        isPressed = true
        updateValue()
        feedback()
        
        timer = Timer.scheduledTimer(withTimeInterval: 0.1, repeats: true) { _ in
            updateValue()
            feedback()
        }
    }
    
    private func stopCounting() {
        timer?.invalidate()
        timer = nil
        isPressed = false
    }
    
    private func updateValue() {
        if modify == nil {
            modify = addValue
        } else {
            modify! += addValue
        }
    }
    
    private func feedback() {
        generator.impactOccurred()
    }
}
