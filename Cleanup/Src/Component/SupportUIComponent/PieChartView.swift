//
//  PieChartView.swift
//  Cleanup
//
//  Created by Kunal Personl on 10/10/24.
//

import SwiftUI


struct DonutSegment: Shape {
    var startAngle: Angle
    var endAngle: Angle
    var innerRadiusRatio: CGFloat = 0.6 // The ratio for the inner hole size

    func path(in rect: CGRect) -> Path {
        var path = Path()
        let center = CGPoint(x: rect.midX, y: rect.midY)
        let radius = min(rect.width, rect.height) / 2
        let innerRadius = radius * innerRadiusRatio

        // Outer circle (Arc)
        path.move(to: CGPoint(x: center.x + innerRadius * cos(CGFloat(startAngle.radians)),
                              y: center.y + innerRadius * sin(CGFloat(startAngle.radians))))
        path.addArc(center: center,
                    radius: radius,
                    startAngle: startAngle,
                    endAngle: endAngle,
                    clockwise: false)
        
        // Inner circle (Reverse Arc)
        path.addArc(center: center,
                    radius: innerRadius,
                    startAngle: endAngle,
                    endAngle: startAngle,
                    clockwise: true)
        
        path.closeSubpath()
        return path
    }
}

struct ChartInfo : Identifiable {
    var id = UUID()
    var value : Double
    var color : Color
    var text: String
}

struct DonutChartView: View {
//    var values: [Double]
//    var colors: [Color]
    var info : [ChartInfo]
    var innerText: String = "Categories"
    
    var total: Double {
        info.reduce(0) { result, chartInfo in
           result + chartInfo.value
       }
    }
    
    var body: some View {
        VStack{
            GeometryReader { geometry in
                let size = min(geometry.size.width, geometry.size.height)
                let center = CGPoint(x: geometry.size.width / 2, y: geometry.size.height / 2)
                let radius = size / 2
                let startAngle = Angle(degrees: -90)
                
                ZStack {
                    // Draw donut segments
                    ForEach(0..<self.info.count, id: \.self) { index in
                        let value = self.info[index].value
                        let endAngle = self.angle(for: value)
                        
                        DonutSegment(startAngle: startAngle + self.totalAngle(before: index),
                                     endAngle: startAngle + self.totalAngle(before: index) + endAngle)
                        .fill(self.info[index].color)
                        .frame(width: size, height: size)
                    }
                    
                    // Center label
                    Text(innerText)
                        .foregroundColor(.black)
                        .position(center)
                }
            }
            .onLoad {
                
            }
            
            // Display chart legend at the bottom
            HStack {
                ForEach(info) { chartInfo in
                    HStack {
                        Circle()
                            .fill(chartInfo.color)
                            .frame(width: 15, height: 15)
                        
                        Text(chartInfo.text)
                            .font(.caption)
                            .foregroundColor(.black)
                    }
                    .padding(.horizontal, 4)
                }
            }
            .padding(.top, 10)
            
        }
    }
    
    func angle(for value: Double) -> Angle {
        return Angle(degrees: 360 * (value / total))
    }
    
    func totalAngle(before index: Int) -> Angle {
        let sum = info.prefix(index).reduce(0) { result, chartInfo in
            result + chartInfo.value
        }
        return angle(for: sum)
    }
}

let chartData: [ChartInfo] = [
    ChartInfo(value: 10, color: .blue, text: "Xcode"),
    ChartInfo(value: 20, color: .green, text: "Swift"),
    ChartInfo(value: 15, color: .orange, text: "SwiftUI"),
    ChartInfo(value: 25, color: .purple, text: "WWDC")
]


#Preview {
    DonutChartView(info: chartData,
                   innerText: "Categories")
        .frame(height: 250)
}
