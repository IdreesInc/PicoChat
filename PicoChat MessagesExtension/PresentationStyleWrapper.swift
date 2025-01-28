//
//  PresentationStyleWrapper.swift
//  PicoChat
//
//  Created by Idrees Hassan on 1/27/25.
//

import SwiftUI
import Messages

class PresentationStyleWrapper: ObservableObject {
    @Published var presentationStyle: MSMessagesAppPresentationStyle = .compact
}
