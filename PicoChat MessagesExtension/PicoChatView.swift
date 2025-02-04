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
    "normal": Sizing(scale: 1.5 * UIScreen.main.bounds.width / 393, keyboardOverride: nil, topMargin: 15, bottomMargin: 20, rightIconPadding: 8, keyCanvasScale: 1.4),
    "small": Sizing(scale: 1.15, keyboardOverride: 280, topMargin: 15, bottomMargin: 3, rightIconPadding: 5, keyCanvasScale: 1.3)
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
    @ObservedObject var conversationWrapper: ConversationWrapper
    
    @Binding var touching: Bool
    
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
    @State private var previousWork: Snapshot? = nil
    
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
        storePreviousWork()
    }
    
    func captureWork() {
        print("Capturing work")
        let snapshot = Snapshot(grid: grid.map { $0 }, lastGlyphLocation: [lastGlyphLocation[0], lastGlyphLocation[1]])
        previousWork = snapshot
        storePreviousWork()
    }
    
    func storePreviousWork() {
        let encodedPreviousWork = try? JSONEncoder().encode(previousWork)
        if let encodedPreviousWork = encodedPreviousWork {
            UserDefaults.standard.set(encodedPreviousWork, forKey: "previousWork")
        } else {
            print("Failed to encode previousWork")
        }
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
        loadPreviousWork()
    }
    
    func loadPreviousWork() {
        if let encodedPreviousWork = UserDefaults.standard.data(forKey: "previousWork") {
            if let decodedPreviousWork = try? JSONDecoder().decode(Snapshot.self, from: encodedPreviousWork) {
                previousWork = decodedPreviousWork
                loadSnapshot(specific: decodedPreviousWork)
                print("Loaded previous work")
            } else {
                print("Failed to decode previousWork")
            }
        }
    }
        
    var body: some View {
        let modalPadding: CGFloat = 7
        
        // Whole view
        ZStack {
            let _ = Self._printChanges()

            let layout = landscapeMode ? AnyLayout(HStackLayout(spacing: 0)) : AnyLayout(VStackLayout(spacing: 0))
            layout {
                // Favorites in landscape
                if landscapeMode {
                    favoritesView()
                }
                
                // App
                HStack(spacing: 0) {
                    Spacer()
                        .frame(minWidth: 0)
                    
                    // Left buttons
                    leftControls()
                    
                    Spacer()
                        .frame(minWidth: 0)
                    
                    // Canvas and Keyboard Modal
                    VStack(spacing: 0) {
                        // Canvas
                        VStack {
                            // Interactive canvas
                            board(BoardType.interactive, grid: $grid)
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
                            ).equatable()
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
        .padding(.bottom, 20)
        .layoutPriority(1)
    }
    
    func favoritesView() -> some View {
        List {
            // Favorites
            ForEach(favorites.reversed()) { favorite in
                HStack(spacing: 0) {
                    Spacer()
                        .frame(minWidth: 0)
                    board(BoardType.capture, grid: Binding.constant(favorite.grid))
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
    
    private func board(_ boardType: BoardType, grid: Binding<[[Int]]>) -> BoardView {
        return BoardView(
            type: boardType,
            grid: grid,
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
            touching: $touching,
            takeSnapshot: takeSnapshot,
            beginNameChange: beginNameChange,
            captureWork: captureWork
        )
    }
    
    func draw(x: Int, y: Int, value: Int) {
        if (x >= 0 && x < CANVAS_WIDTH && y >= 0 && y < CANVAS_HEIGHT) {
            grid[y][x] = value;
        }
    }
    
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
                rendersAsynchronously: true
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
        let renderer = ImageRenderer(content: board(BoardType.export, grid: $grid))
        renderer.scale = 5
        if let image = renderer.uiImage {
            let url = FileManager.default.temporaryDirectory.appendingPathComponent(UUID().uuidString).appendingPathExtension("png")
            if let data = image.pngData() {
                try? data.write(to: url)
            }
            conversationWrapper.conversation.insertAttachment(url, withAlternateFilename: "Image.png") { error in
                if let error = error {
                    print("Failed to insert image: \(error.localizedDescription)")
                }
            }
        }
    }
    
    func clear() {
        for y in 0..<grid.count {
            for x in 0..<grid[y].count {
                grid[y][x] = 0
            }
        }
        lastGlyphLocation = [STARTING_X, STARTING_Y]
        captureWork()
    }
    
    func drawGlyph(x: Int, y: Int, glyph: String, snapshot: Bool = true) {
        if snapshot {
            takeSnapshot()
        }
        let pixels = getTypedPixels(x: x, y: y, glyph: glyph)
        for pixel in pixels {
            draw(x: pixel[0], y: pixel[1], value: pixel[2])
        }
        if snapshot {
            captureWork()
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
            captureWork()
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
