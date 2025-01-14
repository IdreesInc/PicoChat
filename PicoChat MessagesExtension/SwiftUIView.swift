//
//  SwiftUIView.swift
//  PicoChat
//
//  Created by Idrees Hassan on 1/13/25.
//


import SwiftUI
import Messages

struct SwiftUIView: View {
    
    let conversation: MSConversation
    
    var body: some View {
        VStack {
            Text("Hello, iMessage!")
                .font(.largeTitle)
                .padding()
            Button("Tap me!") {
                print("Button tapped!")
                createDynamicSticker(text: "hiya", size: CGSize(width: 1618, height: 618)) { url in
                    let sticker = createSticker(fileURL: url!, localizedDescription: "Dynamic sticker")
                    conversation.insertAttachment(url!, withAlternateFilename: "Image.png") { error in
                        if let error = error {
                            print("Failed to insert sticker: \(error.localizedDescription)")
                        } else {
                            print("Sticker inserted successfully")
                        }
                    }
                    
//                    // Configure the layout for the message
//                    let layout = MSMessageTemplateLayout()
//                    layout.caption = ""
//                    layout.subcaption = ""
//                    layout.image = UIImage(systemName: "message.fill") // Replace with your custom image if needed
//
//                    // Create the message with the layout
//                    let message = MSMessage()
//                    message.layout = layout
//                    message.url = URL(string: "https://example.com") // Optional: Include a URL with the message
//
//                    conversation.insert(message) { error in
//                        if let error = error {
//                            print("Failed to insert message: \(error.localizedDescription)")
//                        }
//                    }
                }
            }
            .padding()
            .background(Color.blue)
            .foregroundColor(.white)
            .cornerRadius(10)
        }
    }
}

func createSticker(fileURL: URL, localizedDescription: String) -> MSSticker? {
    do {
        return try MSSticker(contentsOfFileURL: fileURL, localizedDescription: localizedDescription)
    } catch {
        print("Error creating sticker: \(error)")
        return nil
    }
}


func createDynamicSticker(text: String, size: CGSize, completion: @escaping (URL?) -> Void) {
    // Define file URL for the sticker
    let fileURL = FileManager.default.temporaryDirectory.appendingPathComponent(UUID().uuidString).appendingPathExtension("png")
    
    // Create a graphics context
    UIGraphicsBeginImageContext(size)
    guard let context = UIGraphicsGetCurrentContext() else {
        completion(nil)
        return
    }
    
    // Draw background
    UIColor.systemBlue.setFill()
    context.fill(CGRect(origin: .zero, size: size))
    
    // Draw text
    let textAttributes: [NSAttributedString.Key: Any] = [
        .font: UIFont.boldSystemFont(ofSize: 36),
        .foregroundColor: UIColor.white
    ]
    let textRect = CGRect(x: 0, y: 0, width: size.width, height: size.height)
    let textString = NSString(string: text)
    textString.draw(in: textRect, withAttributes: textAttributes)
    
    // Get the image and write to file
    if let image = UIGraphicsGetImageFromCurrentImageContext() {
        do {
            try image.pngData()?.write(to: fileURL)
            completion(fileURL)
        } catch {
            print("Error writing image to file: \(error)")
            completion(nil)
        }
    }
    UIGraphicsEndImageContext()
}

