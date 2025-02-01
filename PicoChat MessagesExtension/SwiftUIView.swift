//
//  SwiftUIView.swift
//  PicoChat
//
//  Created by Idrees Hassan on 1/13/25.
//


import SwiftUI
import Messages
import TinyMoon

struct Sizing {
    var scale: CGFloat
    var keyboardOverride: CGFloat? = nil
    var topMargin: CGFloat
    var bottomMargin: CGFloat
    var rightIconPadding: CGFloat
    var keyCanvasScale: CGFloat
}

let SIZINGS = [
    "normal": Sizing(scale: 1.5 * UIScreen.main.bounds.width / 393, keyboardOverride: nil, topMargin: -2, bottomMargin: -10, rightIconPadding: 8, keyCanvasScale: 1.4),
    "small": Sizing(scale: 1.15, keyboardOverride: 280, topMargin: -4, bottomMargin: 3, rightIconPadding: 5, keyCanvasScale: 1.3)
]

let sizing = UIScreen.main.bounds.height > 700 ? SIZINGS["normal"]! : SIZINGS["small"]!

let SCALE = sizing.scale
let KEYBOARD_OVERRIDE: CGFloat? = sizing.keyboardOverride
let TOP_MARGIN = sizing.topMargin
let BOTTOM_MARGIN = sizing.bottomMargin
let RIGHT_ICON_PADDING = sizing.rightIconPadding
let KEY_CANVAS_SCALE = sizing.keyCanvasScale
let RIGHT_BUTTON_CANVAS_SCALE = 1.6
let CANVAS_WIDTH = 234
let NOTEBOOK_LINE_SPACING = 18
let CANVAS_HEIGHT = NOTEBOOK_LINE_SPACING * 5 + 1
let MIN_NAME_WIDTH = 59
let SCALED_CANVAS_WIDTH = Double(CANVAS_WIDTH) * SCALE
let SCALED_CANVAS_HEIGHT = Double(CANVAS_HEIGHT) * SCALE
let PIXEL_SIZE = SCALE
let CORNER_RADIUS = 6.0
let STARTING_X = MIN_NAME_WIDTH + 4 - 1
let STARTING_Y = NOTEBOOK_LINE_SPACING - 3
let MAX_NAME_LENGTH = 16
let HORIZONTAL_MARGIN = 5
let KEY_WIDTH = 23.0
let RIGHT_BUTTON_WIDTH = 52.0
let MAX_HEIGHT = UIScreen.main.bounds.width * 0.8

let DEFAULT_NAME = ["P", "i", "c", "o", "C", "h", "a", "t"]

let APP_BACKGROUND_COLOR = Color(hex: "f0f0f0")
let BACKGROUND_COLOR = Color(hex: "fcfcfc")
let MODAL_BACKGROUND_COLOR = Color(hex: "b3b3b3")
let DARK_BORDER_COLOR = Color(hex: "666667")
let RIGHT_BUTTON_COLOR = Color(hex: "e3e3e3")
let KEYBOARD_BACKGROUND_COLOR = Color(hex: "fcfcfd")
let KEYBOARD_BUTTON_COLOR = Color(hex: "f0f0f0")
let CONTROL_BUTTON_COLOR = Color(hex: "d1d1d2")
let LEFT_BUTTON_STROKE_COLOR = Color(hex: "535353")
let LEFT_BUTTON_SHADOW_COLOR = Color(hex: "6c6c6c")
let LEFT_BUTTON_BACKGROUND_COLOR = Color(hex: "b5b5b5")
let LEFT_BUTTON_HIGHLIGHT_MIX_COLOR = Color(hex: "dbdbdb")
let RIGHT_BUTTON_STROKE_COLOR = Color(hex: "acacac")
let CONTROL_TEXT_COLOR = Color(hex: "5b5b5c")

let VERTICAL_PADDING = (Double(CANVAS_HEIGHT) * SCALE - Double(CANVAS_HEIGHT)) / 2
let HORIZONTAL_PADDING = (Double(CANVAS_WIDTH) * SCALE - Double(CANVAS_WIDTH)) / 2

let MAX_SNAPSHOTS = 50

let COLORS = [
    ColorTheme([Color(hex: "#B2C3DB"), Color(hex: "#415969"), Color(hex: "#697182"), Color(hex: "#303851"), Color(hex: "#28518A"), Color(hex: "#828AC3"), Color(hex: "#9A9AB2")]),
    ColorTheme([Color(hex: "#EBBA9A"), Color(hex: "#923800"), Color(hex: "#AA5928"), Color(hex: "#692800"), Color(hex: "#BA5110"), Color(hex: "#FBBA82"), Color(hex: "#FBA269")]),
    ColorTheme([Color(hex: "#FBBABA"), Color(hex: "#FB0000"), Color(hex: "#FB3041"), Color(hex: "#8A0008"), Color(hex: "#FB3849"), Color(hex: "#FB9AA2"), Color(hex: "#F3A2A2")]),
    ColorTheme([Color(hex: "#FBCBFB"), Color(hex: "#EB30EB"), Color(hex: "#E382EB"), Color(hex: "#793059"), Color(hex: "#EB00C3"), Color(hex: "#FBC3EB"), Color(hex: "#FBB2FB")]),
    ColorTheme([Color(hex: "#FBDB92"), Color(hex: "#FB6900"), Color(hex: "#FB8208"), Color(hex: "#8A4900"), Color(hex: "#FB8230"), Color(hex: "#FBFB41"), Color(hex: "#FBFB79")]),
    ColorTheme([Color(hex: "#FBFB71"), Color(hex: "#E3BA00"), Color(hex: "#FBCB20"), Color(hex: "#494900"), Color(hex: "#FB8230"), Color(hex: "#FBFB41"), Color(hex: "#FBFB79")]),
    ColorTheme([Color(hex: "#C3FB71"), Color(hex: "#69A200"), Color(hex: "#92D300"), Color(hex: "#103800"), Color(hex: "#69A208"), Color(hex: "#BAFB79"), Color(hex: "#AAFB61")]),
    ColorTheme([Color(hex: "#BAFBAA"), Color(hex: "#00C300"), Color(hex: "#18F318"), Color(hex: "#005100"), Color(hex: "#009A69"), Color(hex: "#AAF3BA"), Color(hex: "#9AEB9A")]),
    ColorTheme([Color(hex: "#9AEB9A"), Color(hex: "#008A30"), Color(hex: "#20AA49"), Color(hex: "#005100"), Color(hex: "#009A69"), Color(hex: "#AAF3BA"), Color(hex: "#9AEB9A")]),
    ColorTheme([Color(hex: "#B2FBDB"), Color(hex: "#38C39A"), Color(hex: "#61D38A"), Color(hex: "#185130"), Color(hex: "#009A69"), Color(hex: "#AAF3BA"), Color(hex: "#9AEB9A")]),
    ColorTheme([Color(hex: "#D3F3FB"), Color(hex: "#289ACB"), Color(hex: "#61B2DB"), Color(hex: "#104969"), Color(hex: "#0069FB"), Color(hex: "#B2D3EB"), Color(hex: "#9ADBFB")]),
    ColorTheme([Color(hex: "#BACBFB"), Color(hex: "#0049CB"), Color(hex: "#2869E3"), Color(hex: "#002069"), Color(hex: "#0069FB"), Color(hex: "#B2D3EB"), Color(hex: "#9ADBFB")]),
    ColorTheme([Color(hex: "#BABAF3"), Color(hex: "#00008A"), Color(hex: "#5151AA"), Color(hex: "#002069"), Color(hex: "#0069FB"), Color(hex: "#B2D3EB"), Color(hex: "#9ADBFB")]),
    ColorTheme([Color(hex: "#DBBAFB"), Color(hex: "#6900A2"), Color(hex: "#9A41CB"), Color(hex: "#410061"), Color(hex: "#8A00D3"), Color(hex: "#EBBAFB"), Color(hex: "#E39AFB")]),
    ColorTheme([Color(hex: "#FBAAF3"), Color(hex: "#BA00D3"), Color(hex: "#E341F3"), Color(hex: "#79008A"), Color(hex: "#EB00C3"), Color(hex: "#FBC3EB"), Color(hex: "#FBB2FB")]),
    ColorTheme([Color(hex: "#FBDBF3"), Color(hex: "#FB0071"), Color(hex: "#FB41AA"), Color(hex: "#79008A"), Color(hex: "#EB00C3"), Color(hex: "#FBC3EB"), Color(hex: "#FBB2FB")]),
]

let PEN_COLORS = [
    Color(hex: "#000000"),
    Color(hex: "#ff00f3"),
    Color(hex: "#ff0096"),
    Color(hex: "#ff0021"),
    Color(hex: "#ff3400"),
    Color(hex: "#ffa500"),
    Color(hex: "#5dff00"),
    Color(hex: "#00ff00"),
    Color(hex: "#00ffbf"),
    Color(hex: "#00cfff"),
    Color(hex: "#0086ff"),
    Color(hex: "#0034ff"),
    Color(hex: "#3400ff"),
]

let moonPhase = TinyMoon.calculateMoonPhase().emoji

struct ColorTheme {
    var background: Color
    var border: Color
    var leftBackground: Color
    var leftStroke: Color
    var keyPressedText: Color
    var controlPressedBackground: Color
    var keyPressedBackground: Color
    
    init(_ colors: [Color]) {
        background = colors[0]
        border = colors[1]
        leftBackground = colors[2]
        leftStroke = colors[3]
        keyPressedText = colors[4]
        controlPressedBackground = colors[5]
        keyPressedBackground = colors[6]
    }
}

extension ColorTheme: Equatable {
    static func == (lhs: ColorTheme, rhs: ColorTheme) -> Bool {
        return lhs.background == rhs.background
        && lhs.border == rhs.border
        && lhs.leftBackground == rhs.leftBackground
        && lhs.leftStroke == rhs.leftStroke
        && lhs.keyPressedText == rhs.keyPressedText
        && lhs.controlPressedBackground == rhs.controlPressedBackground
        && lhs.keyPressedBackground == rhs.keyPressedBackground
    }
}

struct Snapshot: Identifiable, Codable {
    var id = UUID()
    var grid: [[Int]]
    var lastGlyphLocation: [Int]
}

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
    case symbols
    case emoji
    case extra
}

enum InputState {
    case normal
    case settingName
}

enum BoardType {
    case interactive
    case export
    case capture
}

struct PicoChatView: View {
    @ObservedObject var presentationStyleWrapper: PresentationStyleWrapper
    
    @State private var grid: [[Int]] = Array(repeating: Array(repeating: 0, count: CANVAS_WIDTH), count: CANVAS_HEIGHT)
    @State private var lastTouchLocation: CGPoint? = nil
    @State private var penType = PenType.pen
    @State private var penSize = PenSize.big
    @State private var keyboard = Keyboard.lowercase
    @State private var capsLock = false
    @State private var colorTheme = COLORS[Int.random(in: 0..<COLORS.count)]
    @State private var lastGlyphLocation = [STARTING_X, STARTING_Y]
    @State private var heldGlyph: String? = nil
    @State private var heldButton: String? = nil
    @State private var drawing = false
    @State private var canvasFrame: CGRect = .zero
    @State private var dragPosition: CGPoint = .zero
    @State private var dragX: Int? = nil
    @State private var dragY: Int? = nil
    @State private var snapshots = [Snapshot]()
    @State private var penColorIndex = 0
    @State private var penLength = 0
    @State private var rainbowPen = false
    @State private var rainbowPenThemeIndex = 0
    @State private var name = DEFAULT_NAME.map { $0 }
    @State private var oldName: [String]? = nil
    @State private var oldColor: ColorTheme? = nil
    @State private var inputState = InputState.normal
    
    @State private var favorites = [Snapshot]()
    @State private var favoritesAlertPresented = false
    @State private var landscapeMode = UIScreen.main.bounds.width > UIScreen.main.bounds.height
    
    let conversation: MSConversation
    let keyboards = [
        Keyboard.lowercase: [
            ["1", "2", "3", "4", "5", "6", "7", "8", "9", "0", "-", "="],
            ["HALF_SPACER", "q", "w", "e", "r", "t", "y", "u", "i", "o", "p", "BACKSPACE"],
            ["CAPS", "a", "s", "d", "f", "g", "h", "j", "k", "l", "ENTER"],
            ["SHIFT", "z", "x", "c", "v", "b", "n", "m", ",", ".", "/"],
            ["SPACER", ";", "’", "SPACE", "[", "]"]
        ],
        Keyboard.uppercase: [
            ["!", "@", "#", "$", "%", "^", "&", "*", "(", ")", "_", "+"],
            ["HALF_SPACER", "Q", "W", "E", "R", "T", "Y", "U", "I", "O", "P", "BACKSPACE"],
            ["CAPS", "A", "S", "D", "F", "G", "H", "J", "K", "L", "ENTER"],
            ["SHIFT", "Z", "X", "C", "V", "B", "N", "M", "<", ">", "?"],
            ["SPACER", ":", "~", "SPACE", "{", "}"]
        ],
        Keyboard.accent: [
            ["à", "á", "â", "ä", "è", "é", "ê", "ë", "ì", "í", "î", "SPACER"],
            ["ï", "ò", "ó", "ô", "ö", "œ", "ù", "ú", "û", "ü", "ç", "SMALL_BACKSPACE"],
            ["ñ", "β", "À", "Á", "Â", "Ä", "È", "É", "Ê", "Ë", "Ì", "SMALL_ENTER"],
            ["Í", "Î", "Ï", "Ò", "Ó", "Ô", "Ö", "Œ", "Ù", "Ú", "Û", "SMALL_SPACE"],
            ["Ü", "Ç", "Ñ", "¡", "¿", "€", "¢", "£", "SPACER", "SPACER", "SPACER", "SPACER"]
        ],
        Keyboard.symbols: [
            ["!", "?", "&", "″", "'", "～", ":", ";", "@", "~", "_", "SPACER"],
            ["+", "-", "*", "/", "×", "÷", "=", "→", "←", "↑", "↓", "SMALL_BACKSPACE"],
            ["「", "」", "“", "”", "(", ")", "<", ">", "{", "}", "•", "SMALL_ENTER"],
            ["%", "※", "〒", "#", "♭", "♪", "±", "$", "¢", "£", "\\", "SMALL_SPACE"],
            ["^", "°", "|", "／", "＼", "∞", "∴", "…", "™", "©", "®", "SPACER"]
        ],
        Keyboard.emoji: [
            ["1", "2", "3", "4", "5", "6", "7", "8", "9", "0", "-", "="],
            ["😊", "😠", "😟", "😑", "☼", "☁", "☂", "☃", "✉", "☎", "⏰", "SMALL_BACKSPACE"],
            ["Ⓐ", "Ⓑ", "ⓧ", "Ⓨ", "Ⓛ", "Ⓡ", "➕", "♠", "♦", "♥", "♣", "SMALL_ENTER"],
            ["[!]", "[?]", "+", "-", "☆", "○", "◇", "□", "△", "▽", "⦾", "SMALL_SPACE"],
            ["⮕", "⬅", "⬆", "⬇", "★", "●", "◆", "■", "▲", "▼", "✕", "SPACER"]
        ],
        Keyboard.extra: [
            ["♈️", "♉️", "♊️", "♋️", "♌️", "♍️", "♎️", "♏️", "♐️", "♑️", "♒️", "♓️"],
            ["✨", "☕", "🎏", "🐌", "JUNIMO", "⛩", "🌸", "🌼", "💽", "💾", "🍙", "SMALL_BACKSPACE"],
            ["PYORO", "🐈", "🧋", "🐸", "💔", "❄", "🪱", "🪦", "💀", "🦙", "🔥", "SMALL_ENTER"],
            ["☹️", ":P", "🫤", "🙃", "uwu", "🐇", "SPACER", "SPACER", "SPACER", "SPACER", "SPACER", "SMALL_SPACE"],
            ["🌑", "🌒", "🌓", "🌔", "🌕", "🌖", "🌗", "🌘"],
        ],
    ]
    
    func storeSettings() {
        print("Saving settings")
        let encodedName = name.joined(separator: "␟")
        let colorIndex = COLORS.firstIndex { $0 == colorTheme } ?? 0
        let encodedFavorites = try? JSONEncoder().encode(favorites)
        if let encodedFavorites = encodedFavorites {
            UserDefaults.standard.set(encodedFavorites, forKey: "favorites")
        } else {
            print("Failed to encode favorites")
        }
        UserDefaults.standard.set(encodedName, forKey: "name")
        UserDefaults.standard.set(colorIndex, forKey: "colorIndex")
    }
    
    func loadSettings() {
        print("Loading settings")
        if let encodedName = UserDefaults.standard.string(forKey: "name") {
            let retrievedName = encodedName.components(separatedBy: "␟")
            if retrievedName.count > 0 && retrievedName.filter({ Glyphs.glyphPixels[$0] == nil }).count == 0 {
                name = retrievedName
            }
        }
        if let colorIndex = UserDefaults.standard.object(forKey: "colorIndex") as? Int {
            colorTheme = COLORS[colorIndex % COLORS.count]
        }
        if let encodedFavorites = UserDefaults.standard.data(forKey: "favorites") {
            if let decodedFavorites = try? JSONDecoder().decode([Snapshot].self, from: encodedFavorites) {
                favorites = decodedFavorites
                print("Loaded " + String(favorites.count) + " favorites")
            } else {
                print("Failed to decode favorites")
            }
        }
    }
    
    @State private var canvasTouchLocation: CGPoint?
    @State private var showStylus = false
    
    struct StylusView: View {
        var canvasTouchLocation: CGPoint?
        var showStylus: Bool

        var body: some View {
            let _ = Self._printChanges()
            Image("stylus")
                .resizable()
                .frame(width: 350, height: 350)
                .zIndex(2)
                .position(x: (canvasTouchLocation?.x ?? 1000) + 350/2,
                          y: (canvasTouchLocation?.y ?? 1000) + 350/2)
                .opacity(0.7)
                .animation(.easeInOut(duration: 0.5), value: showStylus)
        }
    }
    
    var body: some View {
        let modalPadding: CGFloat = 7
        
        // Whole view
        ZStack {
            
            let layout = landscapeMode ? AnyLayout(HStackLayout(spacing: 0)) : AnyLayout(VStackLayout(spacing: 0))
            layout {
                // Favorites in landscape
                if landscapeMode {
                    favoritesView()
                }
                
                // App
                HStack(spacing: 0) {
                    let _ = Self._printChanges()

                    
                    Spacer()
                        .frame(minWidth: 0)
                    
                    // Left buttons
                    leftControls()
                        .padding(.leading, 3)
                        .padding(.trailing, 3)
                    
                    // Canvas and Keyboard Modal
                    VStack(spacing: 0) {
                        // Canvas
                        VStack {
                            // Interactive canvas
//                            board(BoardType.interactive, grid: grid)
                            BoardView(
                                type: .interactive,
                                grid: $grid,
                                heldGlyph: $heldGlyph,
                                dragX: $dragX,
                                dragY: $dragY,
                                canvasFrame: $canvasFrame,
                                colorTheme: $colorTheme,
                                inputState: $inputState,
                                drawing: $drawing,
                                lastTouchLocation: $lastTouchLocation,
                                name: $name,
                                penType: $penType,
                                penSize: $penSize,
                                penColorIndex: $penColorIndex,
                                penLength: $penLength,
                                rainbowPen: $rainbowPen,
                                takeSnapshot: takeSnapshot,
                                beginNameChange: beginNameChange
                            )
                            .simultaneousGesture(
                                DragGesture(minimumDistance: 0, coordinateSpace: .named("screen"))
                                    .onChanged { value in
                                        if inputState == InputState.settingName {
                                            return
                                        }
                                        canvasTouchLocation = value.location
                                        showStylus = true
                                    }
                                    .onEnded { _ in
                                        canvasTouchLocation = nil
                                        showStylus = false
                                    }
                            )
                        }
                        .padding(.top, modalPadding)
                        .padding(.leading, modalPadding)
                        .padding(.trailing, modalPadding)
                        
                        Spacer()
                            .frame(height: modalPadding)
                        
                        // Keyboard and controls
                        let currentKb = keyboards[keyboard] ?? keyboards[Keyboard.lowercase]!
                        HStack(spacing: 4) {
                            let _ = Self._printChanges()
                            // Keyboard
                            KeyboardView(
                                currentKb: currentKb,
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
                            // Right buttons
                            rightControls()
                        }
                        .padding(.bottom, modalPadding)
                        .padding(.leading, modalPadding)
                    }
                    .background(MODAL_BACKGROUND_COLOR)
                    .frame(minWidth: KEYBOARD_OVERRIDE == nil ? SCALED_CANVAS_WIDTH + 2 * modalPadding : nil)
                    .frame(maxHeight: .infinity)
                    .roundedBorder(radius: CORNER_RADIUS + modalPadding, borderLineWidth: PIXEL_SIZE, borderColor: DARK_BORDER_COLOR, topRight: false, bottomRight: false)
                    .offset(x: PIXEL_SIZE * SCALE)
                }
                .frame(maxWidth: .infinity, maxHeight: MAX_HEIGHT)
                .padding(.top, TOP_MARGIN)
                .padding(.bottom, BOTTOM_MARGIN)
                .layoutPriority(2)
                .zIndex(2)
                
                // Favorites in portrait
                if !landscapeMode && presentationStyleWrapper.presentationStyle == .expanded {
                    favoritesView()
                        .padding(.top, modalPadding)
                }
            }
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity)
        .background(APP_BACKGROUND_COLOR)
        .coordinateSpace(name: "screen")
        .onAppear {
            loadSettings()
        }
        .onGeometryChange(for: CGRect.self) { proxy in
           proxy.frame(in: .global)
       } action: { newValue in
           landscapeMode = UIScreen.main.bounds.width > UIScreen.main.bounds.height
       }
    }
    
//    func keyboardView(currentKb: [[String]]) -> some View {
//        Grid(horizontalSpacing: 1, verticalSpacing: 1) {
//            let _ = Self._printChanges()
//            ForEach(currentKb.indices, id: \.self) { rowIndex in
//                GridRow {
//                    ForEach(currentKb[rowIndex], id: \.self) { glyph in
////                                            key(glyph: glyph)
//                        KeyView(
//                            glyph: glyph,
//                            heldGlyph: $heldGlyph,
//                            capsLock: $capsLock,
//                            keyboard: $keyboard,
//                            inputState: $inputState,
//                            dragPosition: $dragPosition,
//                            dragX: $dragX,
//                            dragY: $dragY,
//                            canvasFrame: $canvasFrame,
//                            colorTheme: $colorTheme
//                        )
//                    }
//                }
//                .frame(maxWidth: .infinity)
//                .frame(maxHeight: .infinity)
//            }
//        }
//        .padding(.leading, PIXEL_SIZE)
//        .padding(.trailing, PIXEL_SIZE)
//        .padding(.top, PIXEL_SIZE)
//        .padding(.bottom, PIXEL_SIZE)
//        .frame(maxHeight: .infinity)
//        .frame(maxWidth: .infinity)
//        .frame(minWidth: KEYBOARD_OVERRIDE)
//        .layoutPriority(12)
//        .background(KEYBOARD_BACKGROUND_COLOR)
//        .roundedBorder(radius: CORNER_RADIUS * PIXEL_SIZE, borderLineWidth: PIXEL_SIZE, borderColor: DARK_BORDER_COLOR, insetColor: KEYBOARD_BACKGROUND_COLOR)
//    }
    
    struct KeyboardView: View {
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
    
    func favoritesView() -> some View {
        List {
            // Favorites
            ForEach(favorites.reversed()) { favorite in
                HStack(spacing: 0) {
                    Spacer()
                        .frame(minWidth: 0)
                    BoardView(
                        type: .capture,
                        grid: Binding.constant(favorite.grid),
                        heldGlyph: $heldGlyph,
                        dragX: $dragX,
                        dragY: $dragY,
                        canvasFrame: $canvasFrame,
                        colorTheme: $colorTheme,
                        inputState: $inputState,
                        drawing: $drawing,
                        lastTouchLocation: $lastTouchLocation,
                        name: $name,
                        penType: $penType,
                        penSize: $penSize,
                        penColorIndex: $penColorIndex,
                        penLength: $penLength,
                        rainbowPen: $rainbowPen,
                        takeSnapshot: takeSnapshot,
                        beginNameChange: beginNameChange
                    )
                        .swipeActions(edge: .trailing) {
                            Button(role: .destructive) { deleteFavorite(favorite: favorite) } label: {
                                Label("Delete", systemImage: "trash")
                            }
                        }
                        .onTapGesture {
                            takeSnapshot()
                            loadSnapshot(specific: favorite)
                        }
                        .applyIf(landscapeMode) { view in
                            view.scaleEffect(0.9)
                        }
                    Spacer()
                        .frame(minWidth: 0)
                }
                .frame(maxWidth: .infinity)
                .listRowBackground(Color.clear)
                .listRowSeparator(.hidden)
                .listRowInsets(EdgeInsets(top: 0, leading: 0, bottom: 0, trailing: 0))
                .padding(0)
            }
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity)
        .frame(minWidth: 100)
        .scrollContentBackground(.hidden)
        .listRowSpacing(10)
        .layoutPriority(2)
    }
    
//    private func board(_ type: BoardType, grid: [[Int]]) -> some View {
//        Canvas(
//            opaque: true,
//            colorMode: .linear,
//            rendersAsynchronously: false
//        ) { context, size in
//            context.fill(Path(CGRect(origin: .zero, size: size)), with: .color(BACKGROUND_COLOR))
//            
//            // Draw notebook lines
//            if (type == BoardType.interactive) {
//                for y in stride(from: 0, to: CANVAS_HEIGHT, by: NOTEBOOK_LINE_SPACING) {
//                    context.stroke(Path { path in
//                        path.move(to: CGPoint(x: 0, y: y))
//                        path.addLine(to: CGPoint(x: CANVAS_WIDTH, y: y))
//                    }, with: .color(colorTheme.background), lineWidth: 1)
//                }
//            }
//            
//            // Draw each pixel
//            for y in 0..<grid.count {
//                for x in 0..<grid[y].count {
//                    if grid[y][x] > 0 {
//                        context.fill(Path(CGRect(x: x, y: y, width: 1, height: 1)), with: .color(PEN_COLORS[grid[y][x] - 1]))
//                    }
//                }
//            }
//            
//            if type == BoardType.interactive {
//                // Get coordinates relative to the canvas pixels
//                var overlayPixels: [[Int]] = []
//                if dragX != nil && dragY != nil && heldGlyph != nil {
//                    overlayPixels = getTypedPixels(x: dragX!, y: dragY!, glyph: heldGlyph!)
//                }
//                
//                // Draw overlay
//                for pixel in overlayPixels {
//                    let x = pixel[0]
//                    let y = pixel[1]
//                    let value = pixel[2]
//                    if value != 0 {
//                        context.fill(Path(CGRect(x: x, y: y, width: 1, height: 1)), with: .color(PEN_COLORS[0]))
//                    }
//                }
//            }
//        }
//        .frame(width: CGFloat(CANVAS_WIDTH), height: CGFloat(CANVAS_HEIGHT))
//        .roundedBorder(radius: CORNER_RADIUS, borderLineWidth: 1, borderColor: .white, insetColor: colorTheme.border, nameColor: colorTheme.background)
//        .overlay(alignment: .topLeading, content: {
//            ZStack {
//                Canvas(opaque: false,
//                       colorMode: .linear,
//                       rendersAsynchronously: false
//                ) { context, size in
//                    let nameWidths = name.map { Glyphs.glyphPixels[$0]![0].count }
//                    var x = 6
//                    for i in 0..<name.count {
//                        let pixels = getTypedPixels(x: x, y: NOTEBOOK_LINE_SPACING - 3, glyph: name[i])
//                        let width = nameWidths[i]
//                        for pixel in pixels {
//                            let pixelX = pixel[0]
//                            let pixelY = pixel[1]
//                            let value = pixel[2]
//                            if value != 0 {
//                                context.fill(Path(CGRect(x: pixelX, y: pixelY, width: 1, height: 1)), with: .color(colorTheme.border))
//                            }
//                        }
//                        x += width + 1
//                    }
//                    
//                }.frame(width: max(CGFloat(MIN_NAME_WIDTH), calculateNameWidth() + 12), height: CGFloat(NOTEBOOK_LINE_SPACING) + 1.5)
//                    .background(alignment: .topLeading) {
//                        // iOS 16 doesn't allow for fill and stroke at the same time, so have to make two shapes
//                        // Fill
//                        UnevenRoundedRectangle(cornerRadii: .init(
//                            topLeading: CORNER_RADIUS,
//                            bottomTrailing: CORNER_RADIUS), style: .continuous)
//                        .inset(by: 1)
//                        .foregroundStyle(colorTheme.background)
//                        // Stroke
//                        UnevenRoundedRectangle(cornerRadii: .init(
//                            topLeading: CORNER_RADIUS,
//                            bottomTrailing: CORNER_RADIUS), style: .continuous)
//                        .inset(by: 1)
//                        .strokeBorder(colorTheme.border, lineWidth: 1, antialiased: true)
//                    }
//                    .applyIf(type == BoardType.interactive) { view in
//                        view
//                            .onTapGesture {
//                                if inputState == InputState.normal {
//                                    beginNameChange()
//                                }
//                            }
//                    }
//            }
//        })
//        .applyIf(type == BoardType.interactive) { view in
//            view.gesture(
//                DragGesture(minimumDistance: 0, coordinateSpace: .local)
//                    .onChanged { value in
//                        if inputState == InputState.settingName {
//                            return
//                        }
//                        if !drawing {
//                            takeSnapshot()
//                            drawing = true
//                        }
//                        var ink = getAndIncrementInk()
//                        if value.location.x >= 0 && value.location.x < CGFloat(CANVAS_WIDTH) && value.location.y >= 0 && value.location.y < CGFloat(CANVAS_HEIGHT) {
//                            draw(x: Int(value.location.x), y: Int(value.location.y), value: ink)
//                            if penSize == PenSize.big {
//                                draw(x: Int(value.location.x) - 1, y: Int(value.location.y), value: ink)
//                                draw(x: Int(value.location.x) - 1, y: Int(value.location.y) - 1, value: ink)
//                                draw(x: Int(value.location.x), y: Int(value.location.y) - 1, value: ink)
//                            }
//                        }
//                        if let lastTouch = lastTouchLocation {
//                            // Bresenham's Line Algorithm
//                            let from = lastTouch
//                            let to = value.location
//                            
//                            let x0 = Int(from.x)
//                            let y0 = Int(from.y)
//                            let x1 = Int(to.x)
//                            let y1 = Int(to.y)
//                            
//                            let dx = abs(x1 - x0)
//                            let dy = abs(y1 - y0)
//                            
//                            let sx = x0 < x1 ? 1 : -1
//                            let sy = y0 < y1 ? 1 : -1
//                            
//                            var err = dx - dy
//                            var x = x0
//                            var y = y0
//                            
//                            while true {
//                                ink = getAndIncrementInk()
//                                
//                                draw(x: x, y: y, value: ink)
//                                if penSize == PenSize.big {
//                                    draw(x: x - 1, y: y, value: ink)
//                                    draw(x: x - 1, y: y - 1, value: ink)
//                                    draw(x: x, y: y - 1, value: ink)
//                                }
//                                if x == x1 && y == y1 {
//                                    break
//                                }
//                                let e2 = 2 * err
//                                if e2 > -dy {
//                                    err -= dy
//                                    x += sx
//                                }
//                                if e2 < dx {
//                                    err += dx
//                                    y += sy
//                                }
//                            }
//                        }
//                        
//                        lastTouchLocation = value.location
//                    }
//                    .onEnded { _ in
//                        lastTouchLocation = nil
//                        drawing = false
//                    }
//            )
//            .allowsHitTesting(inputState != InputState.settingName)
//            .overlay(alignment: .bottom) {
//                if inputState == InputState.settingName {
//                    colorPicker()
//                }
//            }
//            .simultaneousGesture(
//                DragGesture(minimumDistance: 0, coordinateSpace: .named("screen"))
//                    .onChanged { value in
//                        if inputState == InputState.settingName {
//                            return
//                        }
//                        canvasTouchLocation = value.location
//                        showStylus = true
//                    }
//                    .onEnded { _ in
//                        canvasTouchLocation = nil
//                        showStylus = false
//                    }
//            )
//        }
//        .applyIf(type != BoardType.export) { view in
//            view
//                .padding(.top, VERTICAL_PADDING)
//                .padding(.bottom, VERTICAL_PADDING)
//                .padding(.leading, HORIZONTAL_PADDING)
//                .padding(.trailing, HORIZONTAL_PADDING)
//                .scaleEffect(CGFloat(SCALE))
//        }
//        .applyIf(type == BoardType.interactive) { view in
//            view
//                .background(GeometryReader { proxy in
//                    Color.clear
//                        .onAppear {
//                            canvasFrame = proxy.frame(in: .named("screen"))
//                        }
//                        .onChange(of: proxy.frame(in: .named("screen"))) { newFrame in
//                            canvasFrame = newFrame
//                        }
//                })
//        }
//        .applyIf(type == BoardType.export) { view in
//            view
//                .padding(.top, 25)
//                .padding(.bottom, 25)
//                .padding(.leading, 7)
//                .padding(.trailing, 7)
//        }
//    }
    
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
        let takeSnapshot: () -> Void
        let beginNameChange: () -> Void
        
        var body: some View {
            Canvas(
                opaque: true,
                colorMode: .linear,
                rendersAsynchronously: false
            ) { context, size in
                context.fill(Path(CGRect(origin: .zero, size: size)), with: .color(BACKGROUND_COLOR))
    
                // Draw notebook lines
                if (type == BoardType.interactive) {
                    for y in stride(from: 0, to: CANVAS_HEIGHT, by: NOTEBOOK_LINE_SPACING) {
                        context.stroke(Path { path in
                            path.move(to: CGPoint(x: 0, y: y))
                            path.addLine(to: CGPoint(x: CANVAS_WIDTH, y: y))
                        }, with: .color(colorTheme.background), lineWidth: 1)
                    }
                }
    
                // Draw each pixel
                for y in 0..<grid.count {
                    for x in 0..<grid[y].count {
                        if grid[y][x] > 0 {
                            context.fill(Path(CGRect(x: x, y: y, width: 1, height: 1)), with: .color(PEN_COLORS[grid[y][x] - 1]))
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
                            context.fill(Path(CGRect(x: x, y: y, width: 1, height: 1)), with: .color(PEN_COLORS[0]))
                        }
                    }
                }
            }
            .frame(width: CGFloat(CANVAS_WIDTH), height: CGFloat(CANVAS_HEIGHT))
            .roundedBorder(radius: CORNER_RADIUS, borderLineWidth: 1, borderColor: .white, insetColor: colorTheme.border, nameColor: colorTheme.background)
            .overlay(alignment: .topLeading, content: {
                ZStack {
                    Canvas(opaque: false,
                           colorMode: .linear,
                           rendersAsynchronously: false
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
    
                    }.frame(width: max(CGFloat(MIN_NAME_WIDTH), calculateNameWidth() + 12), height: CGFloat(NOTEBOOK_LINE_SPACING) + 1.5)
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
                        .applyIf(type == BoardType.interactive) { view in
                            view
                                .onTapGesture {
                                    if inputState == InputState.normal {
                                        beginNameChange()
                                    }
                                }
                        }
                }
            })
            .applyIf(type == BoardType.interactive) { view in
                view.gesture(
                    DragGesture(minimumDistance: 0, coordinateSpace: .local)
                        .onChanged { value in
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
                            lastTouchLocation = nil
                            drawing = false
                        }
                )
                .allowsHitTesting(inputState != InputState.settingName)
                .overlay(alignment: .bottom) {
                    if inputState == InputState.settingName {
                        colorPicker()
                    }
                }
            }
            .applyIf(type != BoardType.export) { view in
                view
                    .padding(.top, VERTICAL_PADDING)
                    .padding(.bottom, VERTICAL_PADDING)
                    .padding(.leading, HORIZONTAL_PADDING)
                    .padding(.trailing, HORIZONTAL_PADDING)
                    .scaleEffect(CGFloat(SCALE))
            }
            .applyIf(type == BoardType.interactive) { view in
                view
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
            .applyIf(type == BoardType.export) { view in
                view
                    .padding(.top, 25)
                    .padding(.bottom, 25)
                    .padding(.leading, 7)
                    .padding(.trailing, 7)
            }
        }
    
        func calculateNameWidth() -> CGFloat {
            let nameWidths = name.map{ Glyphs.glyphPixels[$0]![0].count }
            var width = 0
            for i in 0..<name.count {
                width += nameWidths[i] + 1
            }
            return CGFloat(width) - 1
        }
        
        func getAndIncrementInk() -> Int {
            if rainbowPen {
                penLength += 1
                if penLength >= 3 {
                    penLength = 0
                    penColorIndex += 1
                    if penColorIndex >= PEN_COLORS.count {
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
    
    func draw(x: Int, y: Int, value: Int) {
        if (x >= 0 && x < CANVAS_WIDTH && y >= 0 && y < CANVAS_HEIGHT) {
            grid[y][x] = value;
        }
    }
    
//    private func drawPixel(_ location: CGPoint, ink: Int) {
//        if location.x >= 0, location.x < CGFloat(CANVAS_WIDTH), location.y >= 0, location.y < CGFloat(CANVAS_HEIGHT) {
//            draw(x: Int(location.x), y: Int(location.y), value: ink)
//        }
//    }
    
    func beginNameChange() {
        inputState = InputState.settingName
        oldName = name.map { $0 }
        oldColor = colorTheme
        if name == DEFAULT_NAME {
            name = []
        }
        takeSnapshot()
        clear()
        // Type your name and select a color
        let letters = ["T", "y", "p", "e", " ", "y", "o", "u", "r", " ", "n", "a", "m", "e", " ", "a", "n", "d", " ", "s", "e", "l", "e", "c", "t", " ", "a", " ", "c", "o", "l", "o", "r"]
        newLine()
        for letter in letters {
            type(glyph: letter, snapshot: false)
        }
        newLine()
        // Press ENTER to confirm or CLEAR to cancel
        let enter = ["P", "r", "e", "s", "s", " ", "E", "N", "T", "E", "R", " ", "t", "o", " ", "c", "o", "n", "f", "i", "r", "m", " ", "o", "r", " ", "C", "L", "E", "A", "R", " ", "t", "o", " ", "c", "a", "n", "c", "e", "l",]
        for letter in enter {
            type(glyph: letter, snapshot: false)
        }
    }
    
    func addGlyphToName(glyph: String) {
        if name.count < MAX_NAME_LENGTH {
            name.append(glyph)
        }
    }
    
    func removeGlyphFromName() {
        if name.count > 0 {
            name.removeLast()
        }
    }
    
    func confirmNameChange() {
        if name.count == 0 {
            cancelNameChange()
        }
        inputState = InputState.normal
        oldName = nil
        oldColor = nil
        loadSnapshot()
        storeSettings()
    }
    
    func cancelNameChange() {
        inputState = InputState.normal
        name = oldName.map { $0 } ?? []
        colorTheme = oldColor ?? colorTheme
        oldName = nil
        oldColor = nil
        loadSnapshot()
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
                    rendersAsynchronously: false
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
    
    private func key(glyph: String) -> some View {
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
        
        if glyph == "HALF_SPACER" {
            keyBgColor = .clear
            keyTextColor = .clear
        } else if glyph == "SPACER" {
            keyBgColor = .clear
            keyTextColor = .clear
        } else if glyph == "CAPS" {
            keyBgColor = capsLock ? colorTheme.controlPressedBackground : keyBgColor
            keyTextColor = capsLock ? colorTheme.keyPressedText : keyTextColor
        } else if glyph == "SMALL_SPACE" {
            canvasScale = KEY_CANVAS_SCALE - 0.2
        }
        
        if glyph == heldGlyph {
            if isControl {
                keyBgColor = colorTheme.controlPressedBackground
            } else {
                keyBgColor = colorTheme.keyPressedBackground
            }
            keyTextColor = colorTheme.keyPressedText
        }
        Self._printChanges()
        
        return VStack(spacing: 0) {
            Canvas(
                opaque: false,
                colorMode: .linear,
                rendersAsynchronously: false
            ) { context, size in
                // Fill the canvas with a white background
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
                    
                    if inputState == InputState.normal && !isControl && (abs(value.translation.width) > 5 || abs(value.translation.height) > 5) {
                        dragPosition = value.location.applying(.init(translationX: -canvasFrame.minX, y: -canvasFrame.minY))
                        let potDragX = floor(dragPosition.x / canvasFrame.width * CGFloat(CANVAS_WIDTH) - 3)
                        let potDragY = floor(dragPosition.y / canvasFrame.height * CGFloat(CANVAS_HEIGHT) - 15)
                        if potDragX.isFinite && potDragY.isFinite && potDragX >= 0 && potDragX < CGFloat(CANVAS_WIDTH) && potDragY >= 0 && potDragY < CGFloat(CANVAS_HEIGHT) {
                            dragX = Int(potDragX)
                            dragY = Int(potDragY)
                        } else {
                            dragX = nil
                            dragY = nil
                        }
                    }
                }
                .onEnded { value in
                    heldGlyph = nil
                    
                    var typedGlyph = glyph
                    
                    switch glyph {
                    case "SHIFT":
                        keyboard = keyboard == Keyboard.uppercase ? Keyboard.lowercase : Keyboard.uppercase
                        capsLock = false
                    case "CAPS":
                        capsLock = !capsLock
                        if capsLock {
                            keyboard = Keyboard.uppercase
                        } else {
                            keyboard = Keyboard.lowercase
                        }
                    case "ENTER", "SMALL_ENTER":
                        if inputState == InputState.normal {
                            newLine()
                        } else if inputState == InputState.settingName {
                            confirmNameChange()
                        }
                    case "BACKSPACE", "SMALL_BACKSPACE":
                        if inputState == InputState.normal {
                            loadSnapshot()
                        } else if inputState == InputState.settingName {
                            removeGlyphFromName()
                        }
                    case "SPACE", "SMALL_SPACE":
                        typedGlyph = " "
                        fallthrough
                    default:
                        if !capsLock && keyboard == Keyboard.uppercase {
                            keyboard = Keyboard.lowercase
                        }
                        if inputState == InputState.normal {
                            type(glyph: typedGlyph, overrideX: dragX, overrideY: dragY)
                        } else if inputState == InputState.settingName {
                            addGlyphToName(glyph: typedGlyph)
                        }
                    }
                    
                    dragPosition = .zero
                    dragX = nil
                    dragY = nil
                    heldGlyph = nil
                }
        )
    }
    
    func newLine() {
        lastGlyphLocation[0] = HORIZONTAL_MARGIN - 1
        lastGlyphLocation[1] += NOTEBOOK_LINE_SPACING
    }
    
    func type(glyph: String, overrideX: Int? = nil, overrideY: Int? = nil, snapshot: Bool? = true) {
        let text = glyph
        let textWidth = (Glyphs.glyphPixels[glyph] ?? Glyphs.glyphPixels["?"]!)[0].count
        var nextX = lastGlyphLocation[0] + 1
        var nextY = lastGlyphLocation[1]
        if (overrideX != nil && overrideY != nil) {
            // Type dragged glyph
            nextX = overrideX!
            nextY = overrideY!
        } else if (nextX + textWidth >= CANVAS_WIDTH - HORIZONTAL_MARGIN) {
            nextX = HORIZONTAL_MARGIN
            nextY += NOTEBOOK_LINE_SPACING
        }
        drawGlyph(x: nextX, y: nextY, glyph: text, snapshot: snapshot ?? true)
        lastGlyphLocation[0] = nextX + textWidth
        lastGlyphLocation[1] = nextY
        if keyboard == Keyboard.uppercase && !capsLock {
            keyboard = Keyboard.lowercase
        }
    }
    
    private func leftControls() -> some View {
        VStack(spacing: 0) {
            leftButton(icon: "PEN", highlight: penType == PenType.pen, top: true, colorOverride: rainbowPen ? COLORS[rainbowPenThemeIndex] : nil)
                .onTapGesture {
                    if penType == PenType.pen {
                        rainbowPen = !rainbowPen
                    } else {
                        penType = PenType.pen
                        rainbowPen = false
                    }
                }
                .onAppear {
                    // Begin rainbow timer
                    Timer.scheduledTimer(withTimeInterval: 0.175, repeats: true) { timer in
                        if rainbowPen && penType == PenType.pen {
                            rainbowPenThemeIndex += 1
                            if rainbowPenThemeIndex >= COLORS.count {
                                rainbowPenThemeIndex = 0
                            }
                        }
                    }
                }
            Spacer().frame(minHeight: 0)
            leftButton(icon: "ERASER", highlight: penType == PenType.eraser)
                .onTapGesture {
                    penType = PenType.eraser
                }
            Spacer().frame(minHeight: 0)
            leftButton(icon: "BIG_PEN", highlight: penSize == PenSize.big)
                .onTapGesture {
                    penSize = PenSize.big
                }
            Spacer().frame(minHeight: 0)
            leftButton(icon: "SMALL_PEN", highlight: penSize == PenSize.small)
                .onTapGesture {
                    penSize = PenSize.small
                }
            Spacer().frame(minHeight: 0)
            leftButton(icon: "ALPHANUMERIC", highlight: keyboard == Keyboard.lowercase || keyboard == Keyboard.uppercase)
                .onTapGesture {
                    keyboard = Keyboard.lowercase
                    capsLock = false
                }
            Spacer().frame(minHeight: 0)
            leftButton(icon: "ACCENT", highlight: keyboard == Keyboard.accent)
                .onTapGesture {
                    keyboard = Keyboard.accent
                    capsLock = false
                }
            Spacer().frame(minHeight: 0)
            leftButton(icon: "SYMBOLS", highlight: keyboard == Keyboard.symbols)
                .onTapGesture {
                    keyboard = Keyboard.symbols
                    capsLock = false
                }
            Spacer().frame(minHeight: 0)
            leftButton(icon: "EMOJI", highlight: keyboard == Keyboard.emoji)
                .onTapGesture {
                    keyboard = Keyboard.emoji
                    capsLock = false
                }
            Spacer().frame(minHeight: 0)
            leftButton(icon: moonPhase, highlight: keyboard == Keyboard.extra, bottom: true)
                .onTapGesture {
                    keyboard = Keyboard.extra
                    capsLock = false
                }
            Spacer().frame(minHeight: 0)
        }
        .frame(maxHeight: .infinity)
        .padding(.top, PIXEL_SIZE)
        .padding(.bottom, 15)
        .layoutPriority(1)
    }
    
    private func leftButton(icon: String, highlight: Bool = false, top: Bool = false, bottom: Bool = false, colorOverride: ColorTheme? = nil) -> some View {
        let colors = colorOverride ?? colorTheme
        let highlightColor = Color.white
        var strokeColor = LEFT_BUTTON_STROKE_COLOR
        var shadowColor = LEFT_BUTTON_SHADOW_COLOR
        var highlightMixColor = LEFT_BUTTON_HIGHLIGHT_MIX_COLOR
        
        if highlight {
            strokeColor = colors.leftStroke
            shadowColor = colors.border
            highlightMixColor = colors.background
        }
        
        let pixels = Glyphs.iconPixels[icon] ?? Glyphs.iconPixels["BLANK"]!
        let width = pixels[0].count
        let height = pixels.count
        
        return VStack(spacing: 0) {
            Canvas(
                opaque: false,
                colorMode: .linear,
                rendersAsynchronously: false
            ) { context, size in
                for y in 0..<height {
                    for x in 0..<width {
                        if pixels[y][x] != 0 {
                            var color = Color.clear
                            if pixels[y][x] == 1 {
                                color = strokeColor
                            } else if pixels[y][x] == 2 {
                                color = highlightColor
                            } else if pixels[y][x] == 3 {
                                color = shadowColor
                            } else if pixels[y][x] == 4 {
                                color = highlightMixColor
                            }
                            context.fill(Path(CGRect(x: x, y: y, width: 1, height: 1)), with: .color(color))
                        }
                    }
                }
            }
            .frame(width: CGFloat(width), height: CGFloat(height))
            .scaleEffect(1.4)
        }
        .frame(width: 22, height: 22)
        .background(highlight ? colors.leftBackground : LEFT_BUTTON_BACKGROUND_COLOR)
        .roundedBorder(radius: 4, borderLineWidth: PIXEL_SIZE, borderColor: highlight ? colors.leftBackground : LEFT_BUTTON_BACKGROUND_COLOR, insetColor: nil, topLeft: top, topRight: false, bottomLeft: bottom, bottomRight: false)
    }
    
    private func rightControls() -> some View {
        VStack (spacing: 0){
            rightButton(icon: "send", highlight: heldButton == "SEND", top: true)
                .gesture(
                    DragGesture(minimumDistance: 0, coordinateSpace: .named("screen"))
                        .onChanged { value in
                            heldButton = "SEND"
                        }
                        .onEnded { value in
                            heldButton = nil
                            if inputState == InputState.normal {
                                send()
                                clear()
                            } else if inputState == InputState.settingName {
                                confirmNameChange()
                            }
                        }
                )
            rightButton(icon: "heart", highlight: heldButton == "SAVE")
                .gesture(
                    DragGesture(minimumDistance: 0, coordinateSpace: .named("screen"))
                        .onChanged { value in
                            heldButton = "SAVE"
                        }
                        .onEnded { value in
                            heldButton = nil
                            if inputState == InputState.normal {
                                if favorites.count == 0 {
                                    favoritesAlertPresented = true
                                }
                                saveFavorite()
                            }
                        }
                )
                .alert(isPresented: $favoritesAlertPresented) {
                    Alert(
                        title: Text("Saved to Favorites"),
                        message: Text("Your current drawing has been saved to your favorites, which are accessible by expanding the app to fullscreen.")
                    )
                }
            rightButton(icon: "clear", highlight: heldButton == "CLEAR", bottom: true)
                .gesture(
                    DragGesture(minimumDistance: 0, coordinateSpace: .named("screen"))
                        .onChanged { value in
                            heldButton = "CLEAR"
                        }
                        .onEnded { value in
                            heldButton = nil
                            if inputState == InputState.normal {
                                takeSnapshot()
                                clear()
                            } else if inputState == InputState.settingName {
                                cancelNameChange()
                            }
                        }
                )
        }
        //        .frame(height: CONTROLS_HEIGHT)
        .frame(maxHeight: .infinity)
    }
    
    private func rightButton(icon: String, highlight: Bool = false, top: Bool = false, bottom: Bool = false) -> some View {
        ZStack {
            Image(icon)
                .resizable()
                .aspectRatio(contentMode: .fit)
                .padding(RIGHT_ICON_PADDING)
        }
        .frame(width: RIGHT_BUTTON_WIDTH)
        .frame(maxHeight: .infinity)
        .background(highlight ? colorTheme.background : RIGHT_BUTTON_COLOR)
        .roundedBorder(radius: CORNER_RADIUS * PIXEL_SIZE, borderLineWidth: PIXEL_SIZE, borderColor: DARK_BORDER_COLOR, insetColor: highlight ? colorTheme.background : KEYBOARD_BACKGROUND_COLOR, topLeft: top, topRight: false, bottomLeft: bottom, bottomRight: false)
        .padding(.bottom, top ? CGFloat(-PIXEL_SIZE) : 0)
        .padding(.top, bottom ? CGFloat(-PIXEL_SIZE) : 0)
    }
    
    private func send() {
        takeSnapshot()
//        let renderer = ImageRenderer(content: board(BoardType.export, grid: grid))
        let renderer = ImageRenderer(content:
                                        BoardView(
                                            type: .export,
                                            grid: $grid,
                                            heldGlyph: $heldGlyph,
                                            dragX: $dragX,
                                            dragY: $dragY,
                                            canvasFrame: $canvasFrame,
                                            colorTheme: $colorTheme,
                                            inputState: $inputState,
                                            drawing: $drawing,
                                            lastTouchLocation: $lastTouchLocation,
                                            name: $name,
                                            penType: $penType,
                                            penSize: $penSize,
                                            penColorIndex: $penColorIndex,
                                            penLength: $penLength,
                                            rainbowPen: $rainbowPen,
                                            takeSnapshot: takeSnapshot,
                                            beginNameChange: beginNameChange
                                        )
                                     )
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
    
//    private func sendAsSticker() {
//        let renderer = ImageRenderer(content: board(BoardType.export, grid: grid))
//        if let image = renderer.uiImage {
//            let url = FileManager.default.temporaryDirectory.appendingPathComponent(UUID().uuidString).appendingPathExtension("png")
//            if let data = image.pngData() {
//                try? data.write(to: url)
//            }
//            conversation.insert(try! MSSticker(contentsOfFileURL: url, localizedDescription: "Sticker")) { error in
//                if let error = error {
//                    print("Failed to insert sticker: \(error.localizedDescription)")
//                }
//            }
//        }
//    }

    
    func clear() {
        for y in 0..<grid.count {
            for x in 0..<grid[y].count {
                grid[y][x] = 0
            }
        }
        lastGlyphLocation = [STARTING_X, STARTING_Y]
    }
    
    func drawGlyph(x: Int, y: Int, glyph: String, snapshot: Bool = true) {
        if snapshot {
            takeSnapshot()
        }
        let pixels = getTypedPixels(x: x, y: y, glyph: glyph)
        for pixel in pixels {
            draw(x: pixel[0], y: pixel[1], value: pixel[2])
        }
    }
    
    func takeSnapshot() {
        print("Taking snapshot...")
        // Cloning arrays in Swift is weird
        let gridClone = grid.map { $0.map { $0 } }
        let lastGlyphLocationClone = lastGlyphLocation.map { $0 }
        snapshots.append(Snapshot(grid: gridClone, lastGlyphLocation: lastGlyphLocationClone))
        if snapshots.count > MAX_SNAPSHOTS {
            snapshots.removeFirst()
        }
        print("Snapshots: \(snapshots.count)")
    }
    
    func loadSnapshot(specific: Snapshot? = nil) {
        print("Loading snapshot...")
        if let snapshot = specific ?? snapshots.popLast() {
            let gridClone = snapshot.grid.map { $0.map { $0 } }
            let lastGlyphLocationClone = snapshot.lastGlyphLocation.map { $0 }
            grid = gridClone
            lastGlyphLocation = lastGlyphLocationClone
            print("Snapshots: \(snapshots.count)")
        } else {
            print("No snapshot to load")
        }
    }
    
    func saveFavorite() {
        if !grid.flatMap({ $0 }).contains(where: { $0 != 0 }) {
            print("Empty grid, not saving favorite")
            return
        }
        if let lastFavorite = favorites.last {
            if grid == lastFavorite.grid {
                print("Duplicate favorite, not saving")
                return
            }
        }
        print("Saving favorite...")
        let gridClone = grid.map { $0.map { $0 } }
        let lastGlyphLocationClone = lastGlyphLocation.map { $0 }
        favorites.append(Snapshot(grid: gridClone, lastGlyphLocation: lastGlyphLocationClone))
        if snapshots.count > MAX_SNAPSHOTS {
            snapshots.removeFirst()
        }
        storeSettings()
    }
    
    func deleteFavorite(favorite: Snapshot) {
        print("Deleting favorite...")

        if let index = favorites.firstIndex(where: { $0.id == favorite.id }) {
            favorites.remove(at: index)
        } else {
            print("Favorite not found")
        }
        storeSettings()
    }
}

func getTypedPixels(x: Int, y: Int, glyph: String) -> [[Int]] {
    let pixels = Glyphs.glyphPixels[glyph] ?? Glyphs.glyphPixels["A"]!
    let adjustments = Glyphs.adjustments[glyph] ?? [0, 0]
    let width = pixels[0].count
    let height = pixels.count
    let yMod = adjustments[1]
    var returnedPixels = Array(repeating: Array(repeating: 0, count: 3), count: width * height)
    var index = 0
    for row in 0..<height {
        for col in 0..<width {
            if pixels[row][col] == 0 {
                continue
            }
            returnedPixels[index][0] = x + col
            returnedPixels[index][1] = y + row - height + yMod
            returnedPixels[index][2] = pixels[row][col]
            index += 1
        }
    }
    return returnedPixels
}

// Extensions

extension View {
    // Helper modifier to conditionally apply a view modifier
    func applyIf<Content: View>(_ condition: Bool, transform: (Self) -> Content) -> some View {
        condition ? AnyView(transform(self)) : AnyView(self)
    }
}

extension View {
    func roundedBorder(radius: CGFloat, borderLineWidth: CGFloat = 1, borderColor: Color = .gray, insetColor: Color? = nil, nameColor: Color? = nil, topLeft: Bool = true, topRight: Bool = true, bottomLeft: Bool = true, bottomRight: Bool = true) -> some View {
        modifier(ModifierRoundedBorder(radius: radius, borderLineWidth: borderLineWidth, borderColor: borderColor, insetColor: insetColor, nameColor: nameColor, topLeft: topLeft, topRight: topRight, bottomLeft: bottomLeft, bottomRight: bottomRight))
    }
}

fileprivate struct ModifierRoundedBorder: ViewModifier {
    var radius: CGFloat
    var borderLineWidth: CGFloat = 1
    var borderColor: Color = .gray
    var insetColor: Color?
    var nameColor: Color?
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
                }
            )
    }
}

extension Color {
    init(hex: String) {
        var hex = hex.trimmingCharacters(in: CharacterSet.alphanumerics.inverted)
        if hex.hasPrefix("#") {
            hex.removeFirst()
        }
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
