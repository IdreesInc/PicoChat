//
//  Untitled.swift
//  PicoChat
//
//  Created by Idrees Hassan on 1/31/25.
//

import SwiftUI

struct OverlayView: View {
    
    @Binding var touchX: CGFloat
    @Binding var touchY: CGFloat
    @Binding var touching: Bool
    @Binding var stylusOrientation: StylusOrientation
    
    var body: some View {
        if stylusOrientation != .disabled && stylusOrientation != .hidden {
            ZStack {
                let mod: CGFloat = stylusOrientation == .left ? -1 : 1
                let x = touching ? (touchX + 350/2 * mod) : (UIScreen.main.nativeBounds.width * mod)
                let y = touching ? touchY + 350/2 : UIScreen.main.nativeBounds.width
                Image("stylus")
                    .resizable()
                    .frame(width: 350, height: 350)
                    .scaleEffect(x: mod)
                    .zIndex(2)
                    .position(x: x, y: y)
                    .opacity(0.7)
                    .animation(.smooth(duration: touching ? 0.05 : 0.3), value: x)
                    .animation(.smooth(duration: touching ? 0.05 : 0.3), value: y)
            }
            .edgesIgnoringSafeArea(.all)
            .frame(maxWidth: .infinity, maxHeight: .infinity)
            .allowsHitTesting(false)
        }
    }
}
