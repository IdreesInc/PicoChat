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
let SCALED_CANVAS_WIDTH = Double(CANVAS_WIDTH) * SCALE
let SCALED_CANVAS_HEIGHT = Double(CANVAS_HEIGHT) * SCALE
let PIXEL_SIZE = SCALE
let corner_radius = 6.0
let controls_height = SCALED_CANVAS_HEIGHT + 10

let dark_color = Color(hex: "0b155b")
let fill_color = Color(hex: "b7baef")
let background_color = Color(hex: "fcfcfc")
let modal_background_color = Color(hex: "b3b3b3")
let dark_border_color = Color(hex: "666667")
let button_fill_color = Color(hex: "e3e3e3")

let vertical_padding = (Double(CANVAS_HEIGHT) * SCALE - Double(CANVAS_HEIGHT)) / 2
let horizontal_padding = (Double(CANVAS_WIDTH) * SCALE - Double(CANVAS_WIDTH)) / 2

struct SwiftUIView: View {
    @State private var grid: [[Int]] = Array(repeating: Array(repeating: 0, count: CANVAS_WIDTH), count: CANVAS_HEIGHT)
    @State private var lastTouchLocation: CGPoint? = nil
    let conversation: MSConversation
    
    var body: some View {
        // Whole view
        HStack {
            Spacer()
            
            // Canvas and Keyboard Modal
            let modalPadding: CGFloat = 7
            VStack {
                // Canvas
                VStack {
                    // Interactive canvas
                    chatCanvas(interactive: true)
                }
                .padding(.top, modalPadding)
                .padding(.leading, modalPadding)
                .padding(.trailing, modalPadding)
                
                // Keyboard and controls
                HStack(spacing: 4) {
                    RoundedRectangle(cornerRadius: 0)
                        .fill(background_color)
                        .frame(height: controls_height)
                        .roundedBorder(radius: corner_radius * PIXEL_SIZE, borderLineWidth: PIXEL_SIZE, borderColor: dark_border_color)
                    
                    rightControls()
                }
                .padding(.bottom, modalPadding)
                .padding(.leading, modalPadding)
            }
            .background(modal_background_color)
            .frame(width: SCALED_CANVAS_WIDTH + 2 * modalPadding)
            .roundedBorder(radius: 11, borderLineWidth: PIXEL_SIZE, borderColor: dark_border_color, topRight: false, bottomRight: false)
            .offset(x: PIXEL_SIZE * SCALE)
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity)
        .background(background_color)
    }
    
    private func send() {
        let renderer = ImageRenderer(content: chatCanvas(interactive: false))
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
    
    private func clear() {
        for y in 0..<grid.count {
            for x in 0..<grid[y].count {
                grid[y][x] = 0
            }
        }
    }
    
    private func rightControls() -> some View {
        VStack (spacing: 0){
            rightButton(top: true)
            .onTapGesture {
                send()
            }
            rightButton()
            rightButton(bottom: true)
            .onTapGesture {
                clear()
            }
        }
        .frame(height: controls_height)
    }
    
    private func rightButton(top: Bool = false, bottom: Bool = false) -> some View {
        ZStack {
            
        }
        .frame(width: 55)
        .frame(maxHeight: .infinity)
        .background(button_fill_color)
        .roundedBorder(radius: corner_radius * PIXEL_SIZE, borderLineWidth: PIXEL_SIZE, borderColor: dark_border_color, topLeft: top, topRight: false, bottomLeft: bottom, bottomRight: false)
    }
    
    private func chatCanvas(interactive: Bool) -> some View {
        Canvas(
            opaque: true,
            colorMode: .linear,
            rendersAsynchronously: false
        ) { context, size in
            // Fill the canvas with a white background
            context.fill(Path(CGRect(origin: .zero, size: size)), with: .color(background_color))
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
        .roundedBorder(radius: corner_radius, borderLineWidth: 1, borderColor: dark_color, inset: 1, name: true)
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
            .padding(.top, vertical_padding)
            .padding(.bottom, vertical_padding)
            .padding(.leading, horizontal_padding)
            .padding(.trailing, horizontal_padding)
            .scaleEffect(CGFloat(SCALE))
        }
        .applyIf(!interactive) { view in
            view.padding(30)
        }
    }
}

// Extensions

extension View {
    // Helper modifier to conditionally apply a view modifier
    func applyIf<Content: View>(_ condition: Bool, transform: (Self) -> Content) -> some View {
        condition ? AnyView(transform(self)) : AnyView(self)
    }
}

extension View {
    func roundedBorder(radius: CGFloat, borderLineWidth: CGFloat = 1, borderColor: Color = .gray, inset: CGFloat = 0, name: Bool = false, topLeft: Bool = true, topRight: Bool = true, bottomLeft: Bool = true, bottomRight: Bool = true) -> some View {
        modifier(ModifierRoundedBorder(radius: radius, borderLineWidth: borderLineWidth, borderColor: borderColor, inset: inset, name: name, topLeft: topLeft, topRight: topRight, bottomLeft: bottomLeft, bottomRight: bottomRight))
    }
}

fileprivate struct ModifierRoundedBorder: ViewModifier {
    var radius: CGFloat
    var borderLineWidth: CGFloat = 1
    var borderColor: Color = .gray
    var inset: CGFloat = 0
    var name: Bool = false
    var antialiased: Bool = true
    var topLeft: Bool
    var topRight: Bool
    var bottomLeft: Bool
    var bottomRight: Bool
    
    
    func body(content: Content) -> some View {
        content
            .clipShape(
                .rect(
                    topLeadingRadius: self.topLeft ? self.radius : 0,
                    bottomLeadingRadius: self.bottomLeft ? self.radius : 0,
                    bottomTrailingRadius: self.bottomRight ? self.radius : 0,
                    topTrailingRadius: self.topRight ? self.radius : 0
            ))
            .overlay(
                ZStack(alignment: .topLeading) {
                    UnevenRoundedRectangle(
                        cornerRadii: .init(
                            topLeading: self.topLeft ? self.radius : 0,
                            bottomLeading: self.bottomLeft ? self.radius : 0,
                            bottomTrailing: self.bottomRight ? self.radius : 0,
                            topTrailing: self.topRight ? self.radius : 0
                        ))
                        .inset(by: self.inset)
                        .strokeBorder(self.borderColor, lineWidth: self.borderLineWidth, antialiased: self.antialiased)
                    if name {
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
