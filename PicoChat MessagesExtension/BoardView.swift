//
//  BoardView.swift
//  PicoChat
//
//  Created by Idrees Hassan on 2/1/25.
//

import SwiftUI

struct BoardView: View {
    let type: BoardType
    @Binding var grid: [[Int]]
    @Binding var heldGlyph: String?
    @Binding var dragX: Int?
    @Binding var dragY: Int?
    @Binding var canvasFrame: CGRect
    @Binding var colorTheme: ColorTheme
    @Binding var inputState: InputState
    @Binding var drawing: Bool
    @Binding var lastTouchLocation: CGPoint?
    @Binding var name: [String]
    @Binding var penType: PenType
    @Binding var penSize: PenSize
    @Binding var penColorIndex: Int
    @Binding var penLength: Int
    @Binding var rainbowPen: Bool
    @Binding var touching: Bool
    let takeSnapshot: () -> Void
    let beginNameChange: () -> Void
    let captureWork: () -> Void
    
    var body: some View {
        Canvas(
            opaque: true,
            colorMode: .linear,
            rendersAsynchronously: true
        ) { context, size in
            context.fill(Path(CGRect(origin: .zero, size: size)), with: .color(BACKGROUND_COLOR))

            // Draw notebook lines
            if (type == BoardType.interactive) {
                for y in stride(from: 0, to: CANVAS_HEIGHT, by: NOTEBOOK_LINE_SPACING) {
                    context.fill(Path(CGRect(x: 0, y: y, width: CANVAS_WIDTH, height: 1)), with: .color(colorTheme.background))
                }
            }

            // Draw batched adjacent pixels
            for y in 0..<grid.count {
                var x = 0
                while x < grid[y].count {
                    if grid[y][x] > 0 {
                        let colorIndex = grid[y][x] - 1
                        var width = 1

                        // Find the length of the continuous segment with the same color
                        while x + width < grid[y].count && grid[y][x + width] == grid[y][x] {
                            width += 1
                        }

                        // Draw the batch as a single rectangle
                        context.fill(Path(CGRect(x: x, y: y, width: width, height: 1)), with: .color(PEN_COLORS[colorIndex]))

                        // Move x forward by the batch width
                        x += width
                    } else {
                        x += 1
                    }
                }
            }

            if type == BoardType.interactive {
                // Get coordinates relative to the canvas pixels
                var overlayPixels: [[Int]] = []
                if dragX != nil && dragY != nil && heldGlyph != nil {
                    overlayPixels = getTypedPixels(x: dragX!, y: dragY!, glyph: heldGlyph!)
                }

                // Draw overlay
                for pixel in overlayPixels {
                    let x = pixel[0]
                    let y = pixel[1]
                    let value = pixel[2]
                    if value != 0 {
                        context.fill(Path(CGRect(x: x, y: y, width: 1, height: 1)), with: .color(PEN_COLORS[value - 1]))
                    }
                }
            }
        }
        .frame(width: CGFloat(CANVAS_WIDTH), height: CGFloat(CANVAS_HEIGHT))
        .roundedBorder(radius: CORNER_RADIUS, borderLineWidth: 1, borderColor: .white, insetColor: colorTheme.border, nameColor: colorTheme.background)
        .overlay(alignment: .topLeading, content: {
            NameView(name: name, colorTheme: colorTheme, inputState: inputState, beginNameChange: beginNameChange, boardType: type)
        })
        .applyIf(type == BoardType.interactive) { view in
            view.gesture(
                DragGesture(minimumDistance: 0, coordinateSpace: .local)
                    .onChanged { value in
                        touching = true
                        if inputState == InputState.settingName {
                            return
                        }
                        if !drawing {
                            takeSnapshot()
                            drawing = true
                        }
                        var ink = getAndIncrementInk()
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
                                ink = getAndIncrementInk()

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
                        if drawing {
                            captureWork()
                        }
                        lastTouchLocation = nil
                        drawing = false
                        touching = false
                    }
            )
            .allowsHitTesting(inputState != InputState.settingName)
            .overlay(alignment: .bottom) {
                if inputState == InputState.settingName {
                    colorPicker()
                }
            }
            .background(GeometryReader { proxy in
                Color.clear
                    .onAppear {
                        canvasFrame = proxy.frame(in: .named("screen"))
                    }
                    .onChange(of: proxy.frame(in: .named("screen"))) { newFrame in
                        canvasFrame = newFrame
                    }
            })
        }
        .applyIf(type != BoardType.export) { view in
            view
                .padding(.top, VERTICAL_PADDING)
                .padding(.bottom, VERTICAL_PADDING)
                .padding(.leading, HORIZONTAL_PADDING)
                .padding(.trailing, HORIZONTAL_PADDING)
                .scaleEffect(CGFloat(SCALE))
        }
        .applyIf(type == BoardType.export) { view in
            view
                .padding(.top, 25)
                .padding(.bottom, 25)
                .padding(.leading, 7)
                .padding(.trailing, 7)
        }
    }
    
    func getAndIncrementInk() -> Int {
        if rainbowPen {
            penLength += 1
            if penLength >= 3 {
                penLength = 0
                penColorIndex += 1
                if penColorIndex > 12 {
                    penColorIndex = 1
                }
            }
            return penType == PenType.eraser ? 0 : (penColorIndex + 1)
        }
        return penType == PenType.eraser ? 0 : 1
    }
    
    func draw(x: Int, y: Int, value: Int) {
        if (x >= 0 && x < CANVAS_WIDTH && y >= 0 && y < CANVAS_HEIGHT) {
            grid[y][x] = value;
        }
    }
    
    func colorPicker() -> some View {
        let SQUARE_SIZE = 10.0
        return HStack(spacing: 4) {
            ForEach(0..<COLORS.count, id: \.self) { i in
                ZStack {
                }
                .frame(width: SQUARE_SIZE, height: SQUARE_SIZE)
                .background(COLORS[i].leftBackground)
                .onTapGesture {
                    colorTheme = COLORS[i]
                }
            }
        }
        .offset(y: CGFloat(-5 - NOTEBOOK_LINE_SPACING))
    }
}

struct NameView: View, Equatable {
    let name: [String]
    let colorTheme: ColorTheme
    let inputState: InputState
    let beginNameChange: () -> Void
    let boardType: BoardType
    
    static func == (lhs: NameView, rhs: NameView) -> Bool {
        return lhs.name == rhs.name && lhs.colorTheme == rhs.colorTheme && lhs.inputState == rhs.inputState
    }
    
    var body: some View {
        Canvas(opaque: false,
               colorMode: .linear,
               rendersAsynchronously: true
        ) { context, size in
            let nameWidths = name.map { Glyphs.glyphPixels[$0]![0].count }
            var x = 6
            for i in 0..<name.count {
                let pixels = getTypedPixels(x: x, y: NOTEBOOK_LINE_SPACING - 3, glyph: name[i])
                let width = nameWidths[i]
                for pixel in pixels {
                    let pixelX = pixel[0]
                    let pixelY = pixel[1]
                    let value = pixel[2]
                    if value != 0 {
                        context.fill(Path(CGRect(x: pixelX, y: pixelY, width: 1, height: 1)), with: .color(colorTheme.border))
                    }
                }
                x += width + 1
            }

        }
        .frame(width: max(CGFloat(MIN_NAME_WIDTH), calculateNameWidth() + 12), height: CGFloat(NOTEBOOK_LINE_SPACING) + 1.5)
        .background(alignment: .topLeading) {
            // iOS 16 doesn't allow for fill and stroke at the same time, so have to make two shapes
            // Fill
            UnevenRoundedRectangle(cornerRadii: .init(
                topLeading: CORNER_RADIUS,
                bottomTrailing: CORNER_RADIUS), style: .continuous)
            .inset(by: 1)
            .foregroundStyle(colorTheme.background)
            // Stroke
            UnevenRoundedRectangle(cornerRadii: .init(
                topLeading: CORNER_RADIUS,
                bottomTrailing: CORNER_RADIUS), style: .continuous)
            .inset(by: 1)
            .strokeBorder(colorTheme.border, lineWidth: 1, antialiased: true)
        }
        .applyIf(boardType == BoardType.interactive) { view in
            view
                .onTapGesture {
                    if inputState == InputState.normal {
                        beginNameChange()
                    }
                }
        }
        .drawingGroup(opaque: false, colorMode: .linear)
    }
    
    func calculateNameWidth() -> CGFloat {
        let nameWidths = name.map{ Glyphs.glyphPixels[$0]![0].count }
        var width = 0
        for i in 0..<name.count {
            width += nameWidths[i] + 1
        }
        return CGFloat(width) - 1
    }
}
