class StarPolygonRenderer {
    class func image(withSize size: CGSize,
                     fillColor: UIColor = UIColor.green,
                     pointCount: Int = 5,
                     radiusRatio: CGFloat = 0.382) -> UIImage {
        let outerRadius = min(size.width, size.height) / 2
        let innerRadius = outerRadius * radiusRatio
        
        let centerX = size.width / 2
        let centerY = size.height / 2
        
        let renderer = UIGraphicsImageRenderer(size: size)
        
        let image = renderer.image { rendererContext in
            let cgContext = rendererContext.cgContext
            //cgContext.setFillColor(fillColor.cgColor)
            
            let angleStride = (2 * CGFloat.pi) / CGFloat(pointCount)
            
            var outerAngle = CGFloat.pi / 2
            var innerAngle = outerAngle - (angleStride / 2)
            
            let topPoint = CGPoint(x: centerX + outerRadius * cos(outerAngle),
                                   y: centerY - outerRadius * sin(outerAngle))

            cgContext.move(to: topPoint)
            
            for i in 0..<pointCount {
                outerAngle += angleStride
                innerAngle += angleStride
                
                let innerPoint = CGPoint(x: centerX + innerRadius * cos(innerAngle),
                                         y: centerY - innerRadius * sin(innerAngle))

                let attrs: [NSAttributedStringKey: Any] = [
                    NSAttributedStringKey.font: UIFont.systemFont(ofSize: 20),
                    NSAttributedStringKey.foregroundColor: UIColor.red
                ]
                let innerStr = NSAttributedString(string: "\(i) inner", attributes: attrs)
                innerStr.draw(at: innerPoint)
                cgContext.addLine(to: innerPoint)
                
                let outerPoint = CGPoint(x: centerX + outerRadius * cos(outerAngle),
                                         y: centerY - outerRadius * sin(outerAngle))

                let outerAttrs: [NSAttributedStringKey: Any] = [
                    NSAttributedStringKey.font: UIFont.systemFont(ofSize: 20),
                    NSAttributedStringKey.foregroundColor: UIColor.blue
                ]
                let outerStr = NSAttributedString(string: "\(i) outer", attributes: outerAttrs)
                outerStr.draw(at: outerPoint)
                cgContext.addLine(to: outerPoint)
            }
            
            cgContext.fillPath()
        }
        
        return image
    }
}
