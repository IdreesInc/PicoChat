//
//  SwiftUIView.swift
//  PicoChat
//
//  Created by Idrees Hassan on 1/13/25.
//


import SwiftUI
import Messages

struct SwiftUIView: View {
    
    // 2D array of numbers, 85 rows by 234 columns
    @State private var grid: [[Int]] = Array(repeating: Array(repeating: 0, count: 234), count: 85)
    @State private var lastTouchLocation: CGPoint? = nil
    let conversation: MSConversation
    
    var body: some View {
        VStack {
            Text("Hello, iMessage!")
                .font(.largeTitle)
                .padding()
            Canvas(
                opaque: true,
                colorMode: .linear,
                rendersAsynchronously: false
            ) { context, size in
                // Fill the canvas with a white background
                context.fill(Path(CGRect(origin: .zero, size: size)), with: .color(Color(.sRGB, red: 230/255, green: 240/255, blue: 1, opacity: 1.0)))
                // Draw each pixel
                for y in 0..<grid.count {
                    for x in 0..<grid[y].count {
                        if grid[y][x] == 1 {
                            context.fill(Path(CGRect(x: x, y: y, width: 1, height: 1)), with: .color(.black))
                        }
                    }
                }
            }
            .frame(width: 234, height: 85)
            .gesture(
                DragGesture(minimumDistance: 0, coordinateSpace: .local)
                    .onChanged({ value in
                        // Print the location of the drag gesture
                        print("Drag location: \(value.location)")
                        if value.location.x >= 0 && value.location.x < 234 && value.location.y >= 0 && value.location.y < 85 {
                            grid[Int(value.location.y)][Int(value.location.x)] = 1
                        }
                        if (lastTouchLocation != nil) {
                            // Draw a line between the last touch location and the current touch location
                            let from = lastTouchLocation!
                            let to = value.location
                            let dx = to.x - from.x
                            let dy = to.y - from.y
                            let steps = max(abs(dx), abs(dy))
                            for i in 0..<Int(steps) {
                                let x = from.x + CGFloat(i) / CGFloat(steps) * dx
                                let y = from.y + CGFloat(i) / CGFloat(steps) * dy
                                if x >= 0 && x < 234 && y >= 0 && y < 85 {
                                    grid[Int(y)][Int(x)] = 1
                                }
                            }
                        }
                        lastTouchLocation = value.location
                    })
                    .onEnded({ value in
                        lastTouchLocation = nil
                    })
            )
            
            Button("Tap me!") {
                print("Button tapped!")
                createDynamicSticker(text: "hiya", size: CGSize(width: 1618, height: 618)) { url in
                    conversation.insertAttachment(url!, withAlternateFilename: "Image.png") { error in
                        if let error = error {
                            print("Failed to insert sticker: \(error.localizedDescription)")
                        } else {
                            print("Sticker inserted successfully")
                        }
                    }
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

