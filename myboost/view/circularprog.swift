//
//  circularprog.swift
//  myboost
//
//  Created by Mac2021 on 30/4/2023.
//

import SwiftUI

struct ProgressBar: View {
    @State var value: Double
    
    var body: some View {
        GeometryReader { geometry in
            ZStack(alignment: .leading) {
                Rectangle().frame(width: geometry.size.width , height: geometry.size.height)
                    .opacity(0.3)
                    .foregroundColor(Color(UIColor.systemTeal))
                
                Rectangle().frame(width: min(CGFloat(self.value)*geometry.size.width, geometry.size.width), height: geometry.size.height)
                    .foregroundColor(Color(UIColor.white))
                    .animation(.linear)
            }.cornerRadius(45.0)
        }
    }
}




struct CircularProgressView: View {
    @State var progress = 0.5
    
    var body: some View {
        
        ZStack {
                    Circle()
                .stroke(lineWidth: 5.0)
                        .opacity(0.2)
                        .foregroundColor(Color.white)
                    
                    Circle()
                        .trim(from: 0.0, to: CGFloat(min(self.progress, 1.0)))
                        .stroke(style: StrokeStyle(lineWidth: 5.0, lineCap: .round, lineJoin: .round))
                        .foregroundColor(Color.white)
                        .rotationEffect(Angle(degrees: 270.0))
                        .animation(.linear)
                    Text(String(format: "%.0f %%", min(self.progress, 1.0)*100.0))
                        
                }
    }
}

struct circularprog_Previews: PreviewProvider {
    static var previews: some View {
        CircularProgressView()
    }
}
