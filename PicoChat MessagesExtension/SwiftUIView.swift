//
//  SwiftUIView.swift
//  PicoChat
//
//  Created by Idrees Hassan on 1/13/25.
//


import SwiftUI
import Messages

let SCALE = 1.5
let CANVAS_WIDTH = 234
let CANVAS_HEIGHT = 85
let dark_color = Color(hex: "0b155b")
let fill_color = Color(hex: "b7baef")

struct SwiftUIView: View {
    @State private var grid: [[Int]] = Array(repeating: Array(repeating: 0, count: CANVAS_WIDTH), count: CANVAS_HEIGHT)
    @State private var lastTouchLocation: CGPoint? = nil
    let conversation: MSConversation
    
    private func createCanvas(interactive: Bool) -> some View {
        Canvas(
            opaque: true,
            colorMode: .linear,
            rendersAsynchronously: false
        ) { context, size in
            // Fill the canvas with a white background
            context.fill(Path(CGRect(origin: .zero, size: size)), with: .color(.white))
            // Draw each pixel
            for y in 0..<grid.count {
                for x in 0..<grid[y].count {
                    if grid[y][x] == 1 {
                        context.fill(Path(CGRect(x: x, y: y, width: 1, height: 1)), with: .color(.black))
                    }
                }
            }
        }
        .frame(width: CGFloat(CANVAS_WIDTH), height: CGFloat(CANVAS_HEIGHT))
        .cornerRadiusWithBorder(radius: 5, borderLineWidth: 1, borderColor: dark_color)
        .applyIf(interactive) { view in
            view.gesture(
                DragGesture(minimumDistance: 0, coordinateSpace: .local)
                    .onChanged { value in
                        if value.location.x >= 0 && value.location.x < CGFloat(CANVAS_WIDTH) && value.location.y >= 0 && value.location.y < CGFloat(CANVAS_HEIGHT) {
                            grid[Int(value.location.y)][Int(value.location.x)] = 1
                        }
                        if let lastTouch = lastTouchLocation {
                            // Bresenham's Line Algorithm
                            let from = lastTouch
                            let to = value.location

                            let x0 = Int(from.x)
                            let y0 = Int(from.y)
                            let x1 = Int(to.x)
                            let y1 = Int(to.y)
                            
                            let dx = abs(x1 - x0)
                            let dy = abs(y1 - y0)
                            
                            let sx = x0 < x1 ? 1 : -1
                            let sy = y0 < y1 ? 1 : -1
                            
                            var err = dx - dy
                            
                            var x = x0
                            var y = y0
                            
                            while true {
                                if x >= 0 && x < CANVAS_WIDTH && y >= 0 && y < CANVAS_HEIGHT {
                                    grid[y][x] = 1
                                }
                                if x == x1 && y == y1 {
                                    break
                                }
                                let e2 = 2 * err
                                if e2 > -dy {
                                    err -= dy
                                    x += sx
                                }
                                if e2 < dx {
                                    err += dx
                                    y += sy
                                }
                            }
                        }

                        lastTouchLocation = value.location
                    }
                    .onEnded { _ in
                        lastTouchLocation = nil
                        print("Touch ended")
                    }
            )
            .padding(.bottom, (Double(CANVAS_HEIGHT) * SCALE - Double(CANVAS_HEIGHT)) / 2)
            .scaleEffect(CGFloat(SCALE))
        }
        .applyIf(!interactive) { view in
            view.padding(30)
        }
    }
    
    var body: some View {
        VStack {
            Text("Hello, iMessage!")
                .font(.largeTitle)
                .padding()
            
            // Interactive canvas
            createCanvas(interactive: true)
            
            Button("Tap me!") {
                print("Button tapped!")
                let renderer = ImageRenderer(content: createCanvas(interactive: false))
                if let image = renderer.uiImage {
                    let url = FileManager.default.temporaryDirectory.appendingPathComponent(UUID().uuidString).appendingPathExtension("png")
                    if let data = image.pngData() {
                        try? data.write(to: url)
                    }
                    conversation.insertAttachment(url, withAlternateFilename: "Image.png") { error in
                        if let error = error {
                            print("Failed to insert image: \(error.localizedDescription)")
                        }
                    }
                }
            }
            .padding()
            .background(Color.blue)
            .foregroundColor(.white)
            .cornerRadius(10)
        }
    }
}

extension View {
    // Helper modifier to conditionally apply a view modifier
    func applyIf<Content: View>(_ condition: Bool, transform: (Self) -> Content) -> some View {
        condition ? AnyView(transform(self)) : AnyView(self)
    }
}


func createSticker(fileURL: URL, localizedDescription: String) -> MSSticker? {
    do {
        return try MSSticker(contentsOfFileURL: fileURL, localizedDescription: localizedDescription)
    } catch {
        print("Error creating sticker: \(error)")
        return nil
    }
}


func createDynamicSticker(text: String, size: CGSize, completion: @escaping (URL?) -> Void) {
    // Define file URL for the sticker
    let fileURL = FileManager.default.temporaryDirectory.appendingPathComponent(UUID().uuidString).appendingPathExtension("png")
    
    // Create a graphics context
    UIGraphicsBeginImageContext(size)
    guard let context = UIGraphicsGetCurrentContext() else {
        completion(nil)
        return
    }
    
    // Draw background
    UIColor.systemBlue.setFill()
    context.fill(CGRect(origin: .zero, size: size))
    
    // Draw text
    let textAttributes: [NSAttributedString.Key: Any] = [
        .font: UIFont.boldSystemFont(ofSize: 36),
        .foregroundColor: UIColor.white
    ]
    let textRect = CGRect(x: 0, y: 0, width: size.width, height: size.height)
    let textString = NSString(string: text)
    textString.draw(in: textRect, withAttributes: textAttributes)
    
    // Get the image and write to file
    if let image = UIGraphicsGetImageFromCurrentImageContext() {
        do {
            try image.pngData()?.write(to: fileURL)
            completion(fileURL)
        } catch {
            print("Error writing image to file: \(error)")
            completion(nil)
        }
    }
    UIGraphicsEndImageContext()
}

extension View {
    func cornerRadiusWithBorder(radius: CGFloat, borderLineWidth: CGFloat = 1, borderColor: Color = .gray, antialiased: Bool = true) -> some View {
        modifier(ModifierCornerRadiusWithBorder(radius: radius, borderLineWidth: borderLineWidth, borderColor: borderColor, antialiased: antialiased))
    }
}

fileprivate struct ModifierCornerRadiusWithBorder: ViewModifier {
    var radius: CGFloat
    var borderLineWidth: CGFloat = 1
    var borderColor: Color = .gray
    var antialiased: Bool = true
    
    func body(content: Content) -> some View {
        content
            .cornerRadius(self.radius, antialiased: self.antialiased)
            .overlay(
                ZStack(alignment: .topLeading) {
                    RoundedRectangle(cornerRadius: self.radius)
                        .inset(by: self.borderLineWidth)
                        .strokeBorder(self.borderColor, lineWidth: self.borderLineWidth, antialiased: self.antialiased)
                    UnevenRoundedRectangle(cornerRadii: .init(
                        topLeading: self.radius,
                        bottomTrailing: self.radius), style: .continuous)
                    .inset(by: self.borderLineWidth)
                    .frame(width: 59, height: 18)
                    .foregroundStyle(fill_color)
                    UnevenRoundedRectangle(cornerRadii: .init(
                        topLeading: self.radius,
                        bottomTrailing: self.radius), style: .continuous)
                    .inset(by: self.borderLineWidth)
                    .strokeBorder(self.borderColor, lineWidth: self.borderLineWidth, antialiased: self.antialiased)
                    .frame(width: 59, height: 18)
                }
            )
    }
}

extension Color {
    init(hex: String) {
        let hex = hex.trimmingCharacters(in: CharacterSet.alphanumerics.inverted)
        var int: UInt64 = 0
        Scanner(string: hex).scanHexInt64(&int)
        let a, r, g, b: UInt64
        switch hex.count {
        case 3: // RGB (12-bit)
            (a, r, g, b) = (255, (int >> 8) * 17, (int >> 4 & 0xF) * 17, (int & 0xF) * 17)
        case 6: // RGB (24-bit)
            (a, r, g, b) = (255, int >> 16, int >> 8 & 0xFF, int & 0xFF)
        case 8: // ARGB (32-bit)
            (a, r, g, b) = (int >> 24, int >> 16 & 0xFF, int >> 8 & 0xFF, int & 0xFF)
        default:
            (a, r, g, b) = (1, 1, 1, 0)
        }
        
        self.init(
            .sRGB,
            red: Double(r) / 255,
            green: Double(g) / 255,
            blue:  Double(b) / 255,
            opacity: Double(a) / 255
        )
    }
}
