//
//  Shape.swift
//  SetGame
//
//  Created by Anh Phan on 2/15/23.
//

import Foundation
import SwiftUI


struct Circle: Shape {
    
    func path(in rect: CGRect) -> Path {
        let center = CGPoint(x: rect.midX, y: rect.midY)
        let radius = min(rect.height, rect.width) / 3
        
        var p = Path()
        p.addArc(center: center, radius: radius, startAngle: Angle(degrees:0), endAngle: Angle(degrees:360), clockwise: true)
        return p
    }
    
}


struct Square: Shape {
    
    func path(in rect: CGRect) -> Path {
        let center = CGPoint(x: rect.midX, y: rect.midY)
        let sideLength = 2 * min(rect.height, rect.width) / 3
        let corner1 = CGPoint(
            x: center.x - sideLength / 2,
            y: center.y - sideLength / 2
        )
        let corner2 = CGPoint(
            x: center.x - sideLength / 2,
            y: center.y + sideLength / 2
        )
        let corner3 = CGPoint(
            x: center.x + sideLength / 2,
            y: center.y + sideLength / 2
        )
        let corner4 = CGPoint(
            x: center.x + sideLength / 2,
            y: center.y - sideLength / 2
        )
        
        var p = Path()
        p.move(to: corner1)
        p.addLine(to: corner2)
        p.addLine(to: corner3)
        p.addLine(to: corner4)
        p.addLine(to: corner1)
        return p
        
    }
    
}

struct Triangle: Shape {
    
    func path(in rect: CGRect) -> Path {
        let center = CGPoint(x: rect.midX, y: rect.midY)
        let radius = min(rect.height, rect.width) / 2
        let point1 = CGPoint(
            x: center.x + radius * CGFloat(cos(Angle(degrees:270).radians)),
            y: center.y + radius * CGFloat(sin(Angle(degrees:270).radians))
        )
        let point2 = CGPoint(
            x: center.x + radius * CGFloat(cos(Angle(degrees:30).radians)),
            y: center.y + radius * CGFloat(sin(Angle(degrees:30).radians))
        )
        let point3 = CGPoint(
            x: center.x + radius * CGFloat(cos(Angle(degrees:150).radians)),
            y: center.y + radius * CGFloat(sin(Angle(degrees:150).radians))
        )
        var p = Path()
        p.move(to: center)
        p.addLine(to: point1)
        p.addLine(to: point2)
        p.addLine(to: point3)
        p.addLine(to: point1)
        return p
    }
    
}
