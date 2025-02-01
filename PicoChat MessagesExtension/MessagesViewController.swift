//
//  MessagesViewController.swift
//  imessage-sandbox MessagesExtension
//
//  Created by Idrees Hassan on 1/13/25.
//

import UIKit
import Messages
import SwiftUI

@objc(MessagesViewController)
class MessagesViewController: MSMessagesAppViewController {
    
    private var presentationStyleWrapper = PresentationStyleWrapper()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
//        // Check if there's an active conversation
//        guard let conversation = activeConversation else {
//            print("No active conversation available")
//            return
//        }
//
//        // Create the SwiftUI view and pass the active conversation
//        let child = UIHostingController(rootView: SwiftUIView(conversation: conversation))
//
//        // Add the hosting controller's view to the current view hierarchy
//        self.view.addSubview(child.view)
//
//        // Enable Auto Layout for the hosting controller's view
//        child.view.translatesAutoresizingMaskIntoConstraints = false
//
//        // Set up constraints to make the SwiftUI view fill the entire screen
//        NSLayoutConstraint.activate([
//            child.view.topAnchor.constraint(equalTo: view.topAnchor),
//            child.view.bottomAnchor.constraint(equalTo: view.bottomAnchor),
//            child.view.leadingAnchor.constraint(equalTo: view.leadingAnchor),
//            child.view.trailingAnchor.constraint(equalTo: view.trailingAnchor)
//        ])
    }
    
    // MARK: - Conversation Handling
    
    override func willBecomeActive(with conversation: MSConversation) {
        super.willBecomeActive(with: conversation)
        
        // The conversation is guaranteed to be active here
        let child = UIHostingController(rootView: PicoChatView(presentationStyleWrapper: presentationStyleWrapper, conversation: conversation))

        // Add the hosting controller's view
        self.view.addSubview(child.view)
        child.view.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            child.view.topAnchor.constraint(equalTo: view.topAnchor),
            child.view.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            child.view.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            child.view.trailingAnchor.constraint(equalTo: view.trailingAnchor)
        ])
    }

    
    override func didResignActive(with conversation: MSConversation) {
        // Called when the extension is about to move from the active to inactive state.
        // This will happen when the user dismisses the extension, changes to a different
        // conversation or quits Messages.
        
        // Use this method to release shared resources, save user data, invalidate timers,
        // and store enough state information to restore your extension to its current state
        // in case it is terminated later.
    }
   
    override func didReceive(_ message: MSMessage, conversation: MSConversation) {
        // Called when a message arrives that was generated by another instance of this
        // extension on a remote device.
        
        // Use this method to trigger UI updates in response to the message.
    }
    
    override func didStartSending(_ message: MSMessage, conversation: MSConversation) {
        // Called when the user taps the send button.
    }
    
    override func didCancelSending(_ message: MSMessage, conversation: MSConversation) {
        // Called when the user deletes the message without sending it.
    
        // Use this to clean up state related to the deleted message.
    }
    
    override func willTransition(to presentationStyle: MSMessagesAppPresentationStyle) {
        // Called before the extension transitions to a new presentation style.
    
        // Use this method to prepare for the change in presentation style.
    }
    
    override func didTransition(to presentationStyle: MSMessagesAppPresentationStyle) {
        // Called after the extension transitions to a new presentation style.

        // Use this method to finalize any behaviors associated with the change in presentation style.
        
        presentationStyleWrapper.presentationStyle = presentationStyle
    }

}
