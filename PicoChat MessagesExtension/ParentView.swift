//
//  ParentView.swift
//  PicoChat
//
//  Created by Idrees Hassan on 1/31/25.
//

import SwiftUI
import Messages

enum StylusOrientation {
    case right
    case left
    case disabled
}
    

struct ParentView: View {
    
    @ObservedObject var presentationStyleWrapper: PresentationStyleWrapper
    @ObservedObject var conversationWrapper: ConversationWrapper
    
    @State var stylusOrientation = StylusOrientation.right
    @State var touching: Bool = false
    @State var touchX: CGFloat = 0
    @State var touchY: CGFloat = 0
    @State var timeOfLastUpdate: Date = Date()
    
    var body: some View {
        ZStack {
            OverlayView(touchX: $touchX, touchY: $touchY, touching: $touching, stylusOrientation: $stylusOrientation)
                .zIndex(20)
            PicoChatView(presentationStyleWrapper: presentationStyleWrapper, conversationWrapper: conversationWrapper, touching: $touching)
                .applyIf(stylusOrientation != StylusOrientation.disabled) { view in
                    view.simultaneousGesture(
                        DragGesture(minimumDistance: 0, coordinateSpace: .named("screen"))
                            .onChanged { value in
                                if Date().timeIntervalSince(timeOfLastUpdate) < 1.0 / 60.0 {
                                    return
                                }
                                timeOfLastUpdate = Date()
                                touchX = value.location.x
                                touchY = value.location.y
                            }
                            .onEnded { _ in
                            }
                    )
                }
        }
        .edgesIgnoringSafeArea(.all)
        .frame(maxWidth: .infinity, maxHeight: .infinity)
        .onAppear {
            // Check if the device is an iPad
            if UIDevice.current.userInterfaceIdiom == .pad {
                stylusOrientation = .disabled
            }
        }
    }
}

