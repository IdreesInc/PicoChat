//
//  CustomButton.swift
//  PicoChat
//
//  Created by Idrees Hassan on 2/15/25.
//

import SwiftUI

struct CustomButton: View {
    let action: () -> Void
    let glyphs: [String]
    let pressedBackground: Color
    let pressedStroke: Color
    let active: Bool
    
    @State private var isPressed = false
    
    var body: some View {
        let pixels = getPixelsForGlyphs(glyphs: glyphs)
        let width = CGFloat(pixels.map { $0[0] }.max() ?? 0) + 1
        let height = CGFloat(pixels.map { $0[1] }.max() ?? 0) + 1
        let background = isPressed || active ? pressedBackground : CONTROL_BUTTON_COLOR
        let stroke = isPressed || active ? pressedStroke : CONTROL_TEXT_COLOR
        ZStack(alignment: .center) {
            Canvas(
                opaque: false,
                colorMode: .linear,
                rendersAsynchronously: true
            ) { context, size in
                for pixel in pixels {
                    if pixel[2] == 0 {
                        continue
                    }
                    let color = pixel[2] == 1 ? stroke : PEN_COLORS[pixel[2] - 1]
                    context.fill(Path(CGRect(x: pixel[0], y: pixel[1], width: 1, height: 1)), with: .color(color))
                }
            }
            .frame(width: width, height: height)
        }
        .frame(width: width + 10, height: height + 4)
        .background(background)
        .roundedBorder(radius: 4, borderLineWidth: 1, borderColor: stroke)
        .simultaneousGesture(
            DragGesture(minimumDistance: 0, coordinateSpace: .global)
                .onChanged { _ in
                    isPressed = true
                }
                .onEnded { _ in
                    isPressed = false
                    action()
                }
        )
    }
    
    func getPixelsForGlyphs(glyphs: [String], y: Int = 9) -> [[Int]] {
        var x = 0
        var pixels = [[Int]]()
        for glyph in glyphs {
            let glyphPixels = getTypedPixels(x: x, y: y, glyph: glyph)
            pixels.append(contentsOf: glyphPixels)
            x += (Glyphs.glyphPixels[glyph] ?? Glyphs.glyphPixels["?"]!)[0].count + 1
        }
        return pixels
    }
}
