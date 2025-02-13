//
//  KeyboardView.swift
//  PicoChat
//
//  Created by Idrees Hassan on 2/1/25.
//

import SwiftUI

struct KeyboardView: View, Equatable {
    let currentKb: [[String]]
    @Binding var heldGlyph: String?
    @Binding var capsLock: Bool
    @Binding var keyboard: Keyboard
    @Binding var inputState: InputState
    @Binding var dragPosition: CGPoint
    @Binding var dragX: Int?
    @Binding var dragY: Int?
    @Binding var canvasFrame: CGRect
    @Binding var colorTheme: ColorTheme
    var loadSnapshot: (Snapshot?) -> Void
    var newLine: () -> Void
    var type: (String, Int?, Int?, Bool?) -> Void
    var addGlyphToName: (String) -> Void
    var removeGlyphFromName: () -> Void
    var confirmNameChange: () -> Void
    
    static func == (lhs: KeyboardView, rhs: KeyboardView) -> Bool {
        return lhs.currentKb == rhs.currentKb
    }
    
    var body: some View {
        let _ = Self._printChanges()
        Grid(horizontalSpacing: 1, verticalSpacing: 1) {
            ForEach(currentKb.indices, id: \ .self) { rowIndex in
                GridRow {
                    ForEach(currentKb[rowIndex], id: \ .self) { glyph in
                        KeyView(
                            glyph: glyph,
                            heldGlyph: $heldGlyph,
                            capsLock: $capsLock,
                            keyboard: $keyboard,
                            inputState: $inputState,
                            dragPosition: $dragPosition,
                            dragX: $dragX,
                            dragY: $dragY,
                            canvasFrame: $canvasFrame,
                            colorTheme: $colorTheme,
                            loadSnapshot: loadSnapshot,
                            newLine: newLine,
                            type: type,
                            addGlyphToName: addGlyphToName,
                            removeGlyphFromName: removeGlyphFromName,
                            confirmNameChange: confirmNameChange
                        )
                    }
                }
                .frame(maxWidth: .infinity)
                .frame(maxHeight: .infinity)
            }
        }
        .padding(.leading, PIXEL_SIZE)
        .padding(.trailing, PIXEL_SIZE)
        .padding(.top, PIXEL_SIZE)
        .padding(.bottom, PIXEL_SIZE)
        .frame(maxHeight: .infinity)
        .frame(maxWidth: .infinity)
        .frame(minWidth: KEYBOARD_OVERRIDE)
        .layoutPriority(12)
        .background(KEYBOARD_BACKGROUND_COLOR)
        .roundedBorder(radius: CORNER_RADIUS * PIXEL_SIZE, borderLineWidth: PIXEL_SIZE, borderColor: DARK_BORDER_COLOR, insetColor: KEYBOARD_BACKGROUND_COLOR)
    }
}

struct KeyView: View {
    let glyph: String
    @Binding var heldGlyph: String?
    @Binding var capsLock: Bool
    @Binding var keyboard: Keyboard
    @Binding var inputState: InputState
    @Binding var dragPosition: CGPoint
    @Binding var dragX: Int?
    @Binding var dragY: Int?
    @Binding var canvasFrame: CGRect
    @Binding var colorTheme: ColorTheme
    var loadSnapshot: (Snapshot?) -> Void
    var newLine: () -> Void
    var type: (String, Int?, Int?, Bool?) -> Void
    var addGlyphToName: (String) -> Void
    var removeGlyphFromName: () -> Void
    var confirmNameChange: () -> Void
    
    var body: some View {
        let _ = Self._printChanges()
        
        let isControl = Glyphs.controls[glyph] != nil
        var keyBgColor = isControl ? CONTROL_BUTTON_COLOR : KEYBOARD_BUTTON_COLOR
        var keyTextColor = isControl ? CONTROL_TEXT_COLOR : .black
        var canvasScale = KEY_CANVAS_SCALE
        
        let pixels = Glyphs.glyphPixels[glyph] ?? Glyphs.glyphPixels["?"]!
        let adjustments = Glyphs.adjustments[glyph] ?? [0, 0]
        let width = pixels[0].count
        let height = pixels.count
        let MAX_HEIGHT = 12
        let BOTTOM_SPACE = 1
        let yMod = MAX_HEIGHT - BOTTOM_SPACE - height + adjustments[1]
        
        switch glyph {
        case "HALF_SPACER", "SPACER":
            keyBgColor = .clear
            keyTextColor = .clear
        case "CAPS":
            keyBgColor = capsLock ? colorTheme.controlPressedBackground : keyBgColor
            keyTextColor = capsLock ? colorTheme.keyPressedText : keyTextColor
        case "SMALL_SPACE":
            canvasScale = KEY_CANVAS_SCALE - 0.2
        default:
            break
        }
        
        if glyph == heldGlyph {
            keyBgColor = isControl ? colorTheme.controlPressedBackground : colorTheme.keyPressedBackground
            keyTextColor = colorTheme.keyPressedText
        }
        
        return VStack(spacing: 0) {
            Canvas(
                opaque: false,
                colorMode: .linear,
                rendersAsynchronously: true
            ) { context, size in
                context.fill(Path(CGRect(origin: .zero, size: size)), with: .color(keyBgColor))
                for y in 0..<height {
                    for x in 0..<width {
                        if pixels[y][x] == 1 {
                            context.fill(Path(CGRect(x: x, y: y + yMod, width: 1, height: 1)), with: .color(keyTextColor))
                        }
                    }
                }
            }
            .frame(width: CGFloat(width), height: CGFloat(MAX_HEIGHT))
            .scaleEffect(canvasScale)
        }
        .frame(maxWidth: .infinity)
        .frame(maxHeight: .infinity)
        .background(keyBgColor)
        .gridCellColumns(Glyphs.controls[glyph] ?? 2)
        .gesture(
            DragGesture(minimumDistance: 0, coordinateSpace: .named("screen"))
                .onChanged { value in
                    heldGlyph = glyph
                    if inputState == .normal, !isControl, (abs(value.translation.width) > 5 || abs(value.translation.height) > 5) {
                        dragPosition = value.location.applying(.init(translationX: -canvasFrame.minX, y: -canvasFrame.minY))
                        let potDragX = floor(dragPosition.x / canvasFrame.width * CGFloat(CANVAS_WIDTH) - 3)
                        let potDragY = floor(dragPosition.y / canvasFrame.height * CGFloat(CANVAS_HEIGHT) - 15)
                        if potDragX.isFinite, potDragY.isFinite, potDragX >= 0, potDragX < CGFloat(CANVAS_WIDTH), potDragY >= 0, potDragY < CGFloat(CANVAS_HEIGHT) {
                            dragX = Int(potDragX)
                            dragY = Int(potDragY)
                        } else {
                            dragX = nil
                            dragY = nil
                        }
                    }
                }
                .onEnded { _ in
                    submitKey()
                }
        )
    }
    
    private func submitKey() {
        var typedGlyph = glyph
        switch glyph {
        case "SHIFT":
            keyboard = keyboard == .uppercase ? .lowercase : .uppercase
            capsLock = false
        case "CAPS":
            capsLock.toggle()
            keyboard = capsLock ? .uppercase : .lowercase
        case "ENTER", "SMALL_ENTER":
            if inputState == .normal {
                newLine()
            } else if inputState == .settingName {
                confirmNameChange()
            }
        case "BACKSPACE", "SMALL_BACKSPACE":
            if inputState == .normal {
                loadSnapshot(nil)
            } else if inputState == .settingName {
                removeGlyphFromName()
            }
        case "SPACE", "SMALL_SPACE":
            typedGlyph = " "
            fallthrough
        default:
            if !capsLock, keyboard == .uppercase {
                keyboard = .lowercase
            }
            if inputState == .normal {
                type(typedGlyph, dragX, dragY, nil)
            } else if inputState == .settingName {
                addGlyphToName(typedGlyph)
            }
        }
        dragPosition = .zero
        dragX = nil
        dragY = nil
        heldGlyph = nil
    }
}
