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
let NOTEBOOK_LINE_SPACING = 17
let CANVAS_HEIGHT = NOTEBOOK_LINE_SPACING * 5
let SCALED_CANVAS_WIDTH = Double(CANVAS_WIDTH) * SCALE
let SCALED_CANVAS_HEIGHT = Double(CANVAS_HEIGHT) * SCALE
let PIXEL_SIZE = SCALE
let CORNER_RADIUS = 6.0
let CONTROLS_HEIGHT = SCALED_CANVAS_HEIGHT

let APP_BACKGROUND_COLOR = Color(hex: "f0f0f0")
let HIGHLIGHT_COLOR = Color(hex: "0b155b")
let HIGHLIGHT_LIGHT_COLOR = Color(hex: "b6ccff")
let BACKGROUND_COLOR = Color(hex: "fcfcfc")
let MODAL_BACKGROUND_COLOR = Color(hex: "b3b3b3")
let DARK_BORDER_COLOR = Color(hex: "666667")
let RIGHT_BUTTON_COLOR = Color(hex: "e3e3e3")
let KEYBOARD_BACKGROUND_COLOR = Color(hex: "fcfcfd")
let KEYBOARD_BUTTON_COLOR = Color(hex: "f0f0f0")
let CONTROL_BUTTON_COLOR = Color(hex: "d1d1d2")
let LEFT_BUTTON_BACKGROUND_COLOR = Color(hex: "b5b5b5")
let CONTROL_TEXT_COLOR = Color(hex: "5b5b5c")

let VERTICAL_PADDING = (Double(CANVAS_HEIGHT) * SCALE - Double(CANVAS_HEIGHT)) / 2
let HORIZONTAL_PADDING = (Double(CANVAS_WIDTH) * SCALE - Double(CANVAS_WIDTH)) / 2

enum PenType {
    case pen
    case eraser
}

enum PenSize {
    case big
    case small
}

enum Keyboard {
    case lowercase
    case uppercase
    case accent
    case japanese
    case symbols
    case emoji
}

struct SwiftUIView: View {
    @State private var grid: [[Int]] = Array(repeating: Array(repeating: 0, count: CANVAS_WIDTH), count: CANVAS_HEIGHT)
    @State private var lastTouchLocation: CGPoint? = nil
    @State private var penType = PenType.pen
    @State private var penSize = PenSize.big
    @State private var keyboard = Keyboard.lowercase
    
    let conversation: MSConversation
    let keyboards = [
        Keyboard.lowercase: [
            ["1", "2", "3", "4", "5", "6", "7", "8", "9", "0", "-", "="],
            ["SPACER", "q", "w", "e", "r", "t", "y", "u", "i", "o", "p", "BACKSPACE"],
            ["CAPS", "a", "s", "d", "f", "g", "h", "j", "k", "l", "ENTER"],
            ["SHIFT", "z", "x", "c", "v", "b", "n", "m", ",", ".", "/"],
            [";", "'", "SPACE", "[", "]"]
        ],
        Keyboard.uppercase: [
            ["!", "@", "#", "$", "%", "^", "&", "*", "(", ")", "_", "+"],
            ["SPACER", "Q", "W", "E", "R", "T", "Y", "U", "I", "O", "P", "BACKSPACE"],
            ["CAPS", "A", "S", "D", "F", "G", "H", "J", "K", "L", "ENTER"],
            ["SHIFT", "Z", "X", "C", "V", "B", "N", "M", "<", ">", "?"],
            [":", "~", "SPACE", "{", "}"]
        ]
    ]
    
    var body: some View {
        // Whole view
        VStack {
            Spacer()
                .layoutPriority(2)
                .frame(maxHeight: 15)

            // App
            HStack(spacing: 0) {
                // Left buttons
                leftControls()
                
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
                    let currentKb = keyboards[keyboard] ?? keyboards[Keyboard.lowercase]!
                    HStack(spacing: 4) {
                        // Keyboard
                        VStack(spacing: 1) {
                            ForEach(currentKb, id: \.self) { row in
                                HStack(spacing: 1) {
                                    ForEach(row, id: \.self) { glyph in
                                        key(glyph: glyph)
                                    }
                                }
                            }
                        }
                        .frame(height: CONTROLS_HEIGHT)
                        .frame(maxWidth: .infinity)
                        .background(KEYBOARD_BACKGROUND_COLOR)
                        .roundedBorder(radius: CORNER_RADIUS * PIXEL_SIZE, borderLineWidth: PIXEL_SIZE, borderColor: DARK_BORDER_COLOR, insetColor: KEYBOARD_BACKGROUND_COLOR)
                        
                        // Right buttons
                        rightControls()
                }
                    .padding(.bottom, modalPadding)
                    .padding(.leading, modalPadding)
                }
                .background(MODAL_BACKGROUND_COLOR)
                .frame(width: SCALED_CANVAS_WIDTH + 2 * modalPadding)
                .roundedBorder(radius: 11, borderLineWidth: PIXEL_SIZE, borderColor: DARK_BORDER_COLOR, topRight: false, bottomRight: false)
                .offset(x: PIXEL_SIZE * SCALE)
            }
            .frame(maxWidth: .infinity)
            
            Spacer()
                .layoutPriority(2)
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity)
        .background(APP_BACKGROUND_COLOR)
    }
    
    private func send() {
        let renderer = ImageRenderer(content: chatCanvas(interactive: false))
        renderer.scale = 5
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
    
    private func sendAsSticker() {
        let renderer = ImageRenderer(content: chatCanvas(interactive: false))
        if let image = renderer.uiImage {
            let url = FileManager.default.temporaryDirectory.appendingPathComponent(UUID().uuidString).appendingPathExtension("png")
            if let data = image.pngData() {
                try? data.write(to: url)
            }
            conversation.insert(try! MSSticker(contentsOfFileURL: url, localizedDescription: "Sticker")) { error in
                if let error = error {
                    print("Failed to insert sticker: \(error.localizedDescription)")
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
    
    private func key(glyph: String) -> some View {
        let NORMAL_KEY_WIDTH = 23.0
        
        let keyWidth = glyph == "SPACER" ? floor(NORMAL_KEY_WIDTH / 2) : NORMAL_KEY_WIDTH * (Glyphs.controls[glyph] ?? 1)
        let keyColor = glyph == "SPACER" ? .clear : Glyphs.controls[glyph] != nil ? CONTROL_BUTTON_COLOR : KEYBOARD_BUTTON_COLOR
        let keyTextColor = glyph == "SPACER" ? .clear : Glyphs.controls[glyph] != nil ? CONTROL_TEXT_COLOR : .black
        
        let pixels = Glyphs.glyphPixels[glyph] ?? Glyphs.glyphPixels["A"]!
        let adjustments = Glyphs.adjustments[glyph] ?? [0, 0]
        let width = pixels[0].count
        let height = pixels.count
        let MAX_HEIGHT = 12
        let BOTTOM_SPACE = 1
        let yMod = MAX_HEIGHT - BOTTOM_SPACE - height + adjustments[1]
        
        return VStack(spacing: 0) {
            Canvas(
                opaque: false,
                colorMode: .linear,
                rendersAsynchronously: false
            ) { context, size in
                // Fill the canvas with a white background
                context.fill(Path(CGRect(origin: .zero, size: size)), with: .color(keyColor))
                for y in 0..<height {
                    for x in 0..<width {
                        if pixels[y][x] == 1 {
                            context.fill(Path(CGRect(x: x, y: y + yMod, width: 1, height: 1)), with: .color(keyTextColor))
                        }
                    }
                }
            }
            .frame(width: CGFloat(width), height: CGFloat(MAX_HEIGHT))
            .scaleEffect(1.4)
        }
        .frame(maxHeight: .infinity)
        .frame(width: keyWidth)
        .background(keyColor)
        .onTapGesture {
            if glyph == "SHIFT" {
                keyboard = keyboard == Keyboard.uppercase ? Keyboard.lowercase : Keyboard.uppercase
            }
        }
    }
    
    private func leftControls() -> some View {
        VStack(spacing: 0) {
            // Pen
            leftButton(highlight: penType == PenType.pen, top: true)
                .onTapGesture {
                    penType = PenType.pen
                }
            Spacer()
            // Eraser
            leftButton(highlight: penType == PenType.eraser)
                .onTapGesture {
                    penType = PenType.eraser
                }
            Spacer()
            // Big pen
            leftButton(highlight: penSize == PenSize.big)
                .onTapGesture {
                    penSize = PenSize.big
                }
            Spacer()
            // Small pen
            leftButton(highlight: penSize == PenSize.small)
                .onTapGesture {
                    penSize = PenSize.small
                }
            Spacer()
            // Alphanumeric
            leftButton(highlight: keyboard == Keyboard.lowercase || keyboard == Keyboard.uppercase)
                .onTapGesture {
                    keyboard = Keyboard.lowercase
                }
            Spacer()
            // Accent
            leftButton(highlight: keyboard == Keyboard.accent)
                .onTapGesture {
                    keyboard = Keyboard.accent
                }
            Spacer()
            // Japanese
            leftButton(highlight: keyboard == Keyboard.japanese)
                .onTapGesture {
                    keyboard = Keyboard.japanese
                }
            Spacer()
            // Symbols
            leftButton(highlight: keyboard == Keyboard.symbols)
                .onTapGesture {
                    keyboard = Keyboard.symbols
                }
            Spacer()
            // Emoji
            leftButton(highlight: keyboard == Keyboard.emoji, bottom: true)
                .onTapGesture {
                    keyboard = Keyboard.emoji
                }
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity)
        .padding(.top, PIXEL_SIZE)
        .padding(.bottom, 15)
        .layoutPriority(1)
    }
    
    private func leftButton(highlight: Bool = false, top: Bool = false, bottom: Bool = false) -> some View {
        ZStack {
        }
        .frame(width: 22, height: 22)
        .background(highlight ? HIGHLIGHT_LIGHT_COLOR : LEFT_BUTTON_BACKGROUND_COLOR)
        .roundedBorder(radius: 4, borderLineWidth: PIXEL_SIZE, borderColor: highlight ? HIGHLIGHT_LIGHT_COLOR : LEFT_BUTTON_BACKGROUND_COLOR, insetColor: nil, topLeft: top, topRight: false, bottomLeft: bottom, bottomRight: false)
    }
    
    private func rightControls() -> some View {
        VStack (spacing: 0){
            rightButton(top: true)
            .onTapGesture {
                send()
                clear()
            }
            rightButton()
            rightButton(bottom: true)
            .onTapGesture {
                clear()
            }
        }
        .frame(height: CONTROLS_HEIGHT)
    }
    
    private func rightButton(top: Bool = false, bottom: Bool = false) -> some View {
        ZStack {
        }
        .frame(width: 55)
        .frame(maxHeight: .infinity)
        .background(RIGHT_BUTTON_COLOR)
        .roundedBorder(radius: CORNER_RADIUS * PIXEL_SIZE, borderLineWidth: PIXEL_SIZE, borderColor: DARK_BORDER_COLOR, insetColor: KEYBOARD_BACKGROUND_COLOR, topLeft: top, topRight: false, bottomLeft: bottom, bottomRight: false)
    }
    
    private func chatCanvas(interactive: Bool) -> some View {
        Canvas(
            opaque: true,
            colorMode: .linear,
            rendersAsynchronously: false
        ) { context, size in
            // Fill the canvas with a white background
            context.fill(Path(CGRect(origin: .zero, size: size)), with: .color(BACKGROUND_COLOR))
            // Draw notebook lines
            if (interactive) {
                for y in stride(from: 0, to: CANVAS_HEIGHT, by: NOTEBOOK_LINE_SPACING) {
                    context.stroke(Path { path in
                        path.move(to: CGPoint(x: 0, y: y))
                        path.addLine(to: CGPoint(x: CANVAS_WIDTH, y: y))
                    }, with: .color(HIGHLIGHT_LIGHT_COLOR), lineWidth: 1)
                }
            }
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
        .roundedBorder(radius: CORNER_RADIUS, borderLineWidth: 1, borderColor: .white, insetColor: HIGHLIGHT_COLOR, name: true)
        .applyIf(interactive) { view in
            view.gesture(
                DragGesture(minimumDistance: 0, coordinateSpace: .local)
                    .onChanged { value in
                        let ink = penType == PenType.eraser ? 0 : 1
                        if value.location.x >= 0 && value.location.x < CGFloat(CANVAS_WIDTH) && value.location.y >= 0 && value.location.y < CGFloat(CANVAS_HEIGHT) {
                            draw(x: Int(value.location.x), y: Int(value.location.y), value: ink)
                            if penSize == PenSize.big {
                                draw(x: Int(value.location.x) - 1, y: Int(value.location.y), value: ink)
                                draw(x: Int(value.location.x) - 1, y: Int(value.location.y) - 1, value: ink)
                                draw(x: Int(value.location.x), y: Int(value.location.y) - 1, value: ink)
                            }
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
                                draw(x: x, y: y, value: ink)
                                if penSize == PenSize.big {
                                    draw(x: x - 1, y: y, value: ink)
                                    draw(x: x - 1, y: y - 1, value: ink)
                                    draw(x: x, y: y - 1, value: ink)
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
            .padding(.top, VERTICAL_PADDING)
            .padding(.bottom, VERTICAL_PADDING)
            .padding(.leading, HORIZONTAL_PADDING)
            .padding(.trailing, HORIZONTAL_PADDING)
            .scaleEffect(CGFloat(SCALE))
        }
        .applyIf(!interactive) { view in
            view
            .padding(.top, 28)
            .padding(.bottom, 28)
            .padding(.leading, 5)
            .padding(.trailing, 5)
        }
    }
    
    func draw(x: Int, y: Int, value: Int) {
        if (x >= 0 && x < CANVAS_WIDTH && y >= 0 && y < CANVAS_HEIGHT) {
            grid[y][x] = value;
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
    func roundedBorder(radius: CGFloat, borderLineWidth: CGFloat = 1, borderColor: Color = .gray, insetColor: Color? = nil, name: Bool = false, topLeft: Bool = true, topRight: Bool = true, bottomLeft: Bool = true, bottomRight: Bool = true) -> some View {
        modifier(ModifierRoundedBorder(radius: radius, borderLineWidth: borderLineWidth, borderColor: borderColor, insetColor: insetColor, name: name, topLeft: topLeft, topRight: topRight, bottomLeft: bottomLeft, bottomRight: bottomRight))
    }
}

fileprivate struct ModifierRoundedBorder: ViewModifier {
    var radius: CGFloat
    var borderLineWidth: CGFloat = 1
    var borderColor: Color = .gray
    var insetColor: Color?
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
                    .strokeBorder(self.borderColor, lineWidth: self.borderLineWidth, antialiased: self.antialiased)
                    if self.insetColor != nil {
                        UnevenRoundedRectangle(
                            cornerRadii: .init(
                                topLeading: self.topLeft ? self.radius : 0,
                                bottomLeading: self.bottomLeft ? self.radius : 0,
                                bottomTrailing: self.bottomRight ? self.radius : 0,
                                topTrailing: self.topRight ? self.radius : 0
                            ))
                        .inset(by: self.borderLineWidth)
                        .strokeBorder(self.insetColor!, lineWidth: self.borderLineWidth, antialiased: self.antialiased)
                    }
                    if name {
                        UnevenRoundedRectangle(cornerRadii: .init(
                            topLeading: self.radius,
                            bottomTrailing: self.radius), style: .continuous)
                        .inset(by: self.borderLineWidth)
                        .frame(width: 59, height: CGFloat(NOTEBOOK_LINE_SPACING) + 1)
                        .foregroundStyle(HIGHLIGHT_LIGHT_COLOR)
                        UnevenRoundedRectangle(cornerRadii: .init(
                            topLeading: self.radius,
                            bottomTrailing: self.radius), style: .continuous)
                        .inset(by: self.borderLineWidth)
                        .strokeBorder(HIGHLIGHT_COLOR, lineWidth: self.borderLineWidth, antialiased: self.antialiased)
                        .frame(width: 59, height: CGFloat(NOTEBOOK_LINE_SPACING) + 1)
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
