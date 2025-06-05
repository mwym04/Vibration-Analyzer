//
//  SheetView.swift
//  Vibration Analyzer
//
//  Created by LeeMinwoo on 11/16/23.
//

import SwiftUI

struct SheetView: View {
    
    let pi = Double.pi
    @ObservedObject var viewModel: WBViewModel
    @Bindable var vibData: VibData
    @State private var magnitude: CGFloat = 0
    
    var body: some View {
            VStack(spacing: 5) {
                HStack {
                    CustomImageView(systemName: "minus.circle", modify: $vibData.modifyGram, addValue: -1)
                    Spacer()
                    Text("무게")
                        .foregroundColor(.primary)
                        .fontWeight(.bold)
                    Spacer()
                    CustomImageView(systemName: "plus.circle", modify: $vibData.modifyGram, addValue: +1)
                }
                .padding(.horizontal)
                .padding(.bottom, 20)
                

                GeometryReader { geometry in
                    let circleWidth: CGFloat = geometry.size.width
                    let circleHeight: CGFloat = geometry.size.height
                    let centerX: CGFloat = circleWidth / 2
                    let centerY: CGFloat = circleHeight / 2
                    
                    HStack {
                        VStack {
                            HStack {
                                Circle()
                                    .frame(width: 10)
                                    .foregroundStyle(Color.red)
                                    .shadow(color: Color("Shadow"), radius: 2, x: 0, y: 3)
                                Text("0-SHOT")
                            }
                            
                            HStack {
                                Circle()
                                    .frame(width: 10)
                                    .foregroundStyle(Color.blue)
                                    .shadow(color: Color("Shadow"), radius: 2, x: 0, y: 3)
                                Text("1-SHOT")
                            }
                        }
                        .monospacedDigit()
                        
                        Spacer()
                        
                        
                        Text("스케일 : \(Int(magnitude))")
                    }
                    .padding(.horizontal)
                    .font(.caption2)
                    
                    ForEach(0...9, id: \.self) { index in
                        if index % 5 == 0 {
                            Circle()
                                .stroke(.primary, lineWidth: 2)
                                .frame(width: circleWidth - (circleWidth / 10) * CGFloat(index),
                                       height: circleHeight - (circleHeight / 10) * CGFloat(index))
                                .position(x: centerX, y: centerY)
                                .foregroundColor(.primary)
                        } else {
                            Circle()
                                .stroke(.primary, lineWidth: 1)
                                .frame(width: circleWidth - (circleWidth / 10) * CGFloat(index),
                                       height: circleHeight - (circleHeight / 10) * CGFloat(index))
                                .position(x: centerX, y: centerY)
                                .foregroundColor(.primary)
                        }
                    }
                    
                    
                    ForEach(0...5, id: \.self) { index in
                        Rectangle()
                            .frame(width: 1, height: circleHeight)
                            .position(x: centerX, y: centerY)
                            .rotationEffect(.degrees(Double(index) * 30))
                            .foregroundColor(.primary)
                    }
                    
                    ForEach(0...3, id: \.self) { index in
                        let angle = CGFloat(index * 90)
                        let radius: CGFloat = circleHeight / 2 + 14
                        let pi = Double.pi
                        
                        let positionX = centerX + radius * cos(angle / 180 * pi)
                        let positionY = centerY - radius * sin(angle / 180 * pi)
                        
                        Text("\(index * 90)º")
                            .position(x: positionX, y: positionY)
                            .font(.caption2)
                            .foregroundColor(.primary)
                    }
                    
                    
                    Circle()
                        .position(CGPoint(x: centerX + (circleHeight * viewModel.x1) / (2 * magnitude), y: centerY - (circleHeight * viewModel.y1) / (2 * magnitude)))
                        .frame(width: 10)
                        .foregroundStyle(Color.red)
                        .shadow(color: Color("Shadow"), radius: 2, x: 0, y: 3)
                    
                    Circle()
                        .position(CGPoint(x: centerX + (circleHeight * viewModel.x2) / (2 * magnitude), y: centerY - (circleHeight * viewModel.y2) / (2 * magnitude)))
                        .frame(width: 10)
                        .foregroundStyle(Color.blue)
                        .shadow(color: Color("Shadow"), radius: 2, x: 0, y: 3)
                    
                    Circle()
                        .position(CGPoint(
                            x: centerX + (circleHeight * (viewModel.x3 + (vibData.isAttatched ? viewModel.x2 : viewModel.x1)) / (2 * magnitude)),
                            y: centerY - (circleHeight * (viewModel.y3 + (vibData.isAttatched ? viewModel.y2 : viewModel.y1))) / (2 * magnitude)))
                        .frame(width: 10)
                        .shadow(color: Color("Shadow"), radius: 2, x: 0, y: 3)
                        .foregroundStyle(Color.green)
                    
                    ArrowShape(startPoint: CGPoint(x: centerX + (circleHeight * viewModel.x1) / (2 * magnitude), y: centerY - (circleHeight * viewModel.y1) / (2 * magnitude)), endPoint: CGPoint(
                        x: centerX + (circleHeight * (viewModel.x3 + (vibData.isAttatched ? viewModel.x2 : viewModel.x1)) / (2 * magnitude)),
                        y: centerY - (circleHeight * (viewModel.y3 + (vibData.isAttatched ? viewModel.y2 : viewModel.y1))) / (2 * magnitude)))
                    .stroke(lineWidth: 1.5)
                    .opacity(vibData.isAttatched ? 0 : 1)
                    .shadow(color: Color("Shadow"), radius: 2, x: 0, y: 3)
                    
                    ArrowShape(startPoint: CGPoint(x: centerX + (circleHeight * viewModel.x2) / (2 * magnitude), y: centerY - (circleHeight * viewModel.y2) / (2 * magnitude)), endPoint: CGPoint(
                        x: centerX + (circleHeight * (viewModel.x3 + (vibData.isAttatched ? viewModel.x2 : viewModel.x1)) / (2 * magnitude)),
                        y: centerY - (circleHeight * (viewModel.y3 + (vibData.isAttatched ? viewModel.y2 : viewModel.y1))) / (2 * magnitude)))
                    .stroke(lineWidth: 1.5)
                    .opacity(vibData.isAttatched ? 1 : 0)
                    .shadow(color: Color("Shadow"), radius: 2, x: 0, y: 3)
                    
                    ArrowShape(startPoint: CGPoint(x: centerX + (circleHeight * viewModel.x1) / (2 * magnitude), y: centerY - (circleHeight * viewModel.y1) / (2 * magnitude)), endPoint: CGPoint(x: centerX + (circleHeight * viewModel.x2) / (2 * magnitude), y: centerY - (circleHeight * viewModel.y2) / (2 * magnitude)))
                    .stroke(lineWidth: 1.5)
                    .shadow(color: Color("Shadow"), radius: 2, x: 0, y: 3)
                    
                }
                
                HStack {
                    CustomImageView(systemName: "minus.circle", modify: $vibData.modifyPhase, addValue: -1)
                    Spacer()
                    Text("각도")
                        .foregroundColor(.primary)
                        .fontWeight(.bold)
                    Spacer()
                    CustomImageView(systemName: "plus.circle", modify: $vibData.modifyPhase, addValue: +1)
                }
                .padding(.horizontal)
                .padding(.top, 20)
            }
            .onAppear(perform: {
                self.magnitude = circleMagnitude()
            })
        .frame(width: UIScreen.main.bounds.width, height: UIScreen.main.bounds.width - 30)
    }
    
    func circleMagnitude() -> CGFloat {
        let firstVib: Double = Double(vibData.vibFirst) ?? 0
        let secondVib: Double = Double(vibData.vibSecond) ?? 0
        let thirdVib: Double = viewModel.computedMagnitude
        
        return CGFloat(highestDigitAndPosition(of: max(firstVib, secondVib, thirdVib)))
    }
    
    func highestDigitAndPosition(of value: Double) -> Int {
        let intValue = Int(abs(value))
        if intValue == 0 {
            return 0
        }

        var position = 0
        var tempValue = intValue

        while tempValue >= 10 {
            position += 1
            tempValue /= 10
        }

        let highestDigit = (tempValue + 1) * Int(pow(10, Double(position)))
        return highestDigit
    }
}

struct ArrowShape: Shape {
    
    var startPoint: CGPoint
    var endPoint: CGPoint
    
    func path(in rect: CGRect) -> Path {
        var path = Path()

        // 화살표의 꼬리 부분
        path.move(to: startPoint)
        path.addLine(to: endPoint)

        // 화살표의 머리 부분 (삼각형)
        let arrowHeadLength = CGFloat(10.0)
        let arrowHeadAngle = CGFloat.pi / 3  // 30도
        
        // 화살표 머리의 두 선분의 각도 계산
        let angle = atan2(endPoint.y - startPoint.y, endPoint.x - startPoint.x)
        let line1Angle = angle + .pi / 2 + arrowHeadAngle
        let line2Angle = angle - .pi / 2 - arrowHeadAngle
        
        // 화살표 머리 그리기
        path.move(to: endPoint)
        path.addLine(to: CGPoint(
            x: endPoint.x + cos(line1Angle) * arrowHeadLength,
            y: endPoint.y + sin(line1Angle) * arrowHeadLength
        ))
        
        path.move(to: endPoint)
        path.addLine(to: CGPoint(
            x: endPoint.x + cos(line2Angle) * arrowHeadLength,
            y: endPoint.y + sin(line2Angle) * arrowHeadLength
        ))
        return path
    }
}

#Preview {
    SheetView(viewModel: WBViewModel(), vibData: VibData(dataName: "FDF"))
}
