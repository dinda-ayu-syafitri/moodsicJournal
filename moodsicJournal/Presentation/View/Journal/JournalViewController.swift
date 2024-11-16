//
//  JournalViewController.swift
//  moodsicJournal
//
//  Created by Dinda Ayu Syafitri on 23/05/24.
//
import PencilKit
import UIKit

class JournalViewController: UIViewController {
    lazy var canvas: PKCanvasView = {
        let view = PKCanvasView()
        view.drawingPolicy = .anyInput
        view.minimumZoomScale = 1
        view.maximumZoomScale = 1
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()

    lazy var toolPicker: PKToolPicker = {
        let toolPicker = PKToolPicker()
        toolPicker.addObserver(self)
        return toolPicker
    }()

    var journalData = Data()
    var journalChanged: (Data) -> Void = { _ in }

    override func viewDidLoad() {
        super.viewDidLoad()
        view.addSubview(canvas)

        NSLayoutConstraint.activate([
            canvas.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            canvas.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            canvas.topAnchor.constraint(equalTo: view.topAnchor),
            canvas.bottomAnchor.constraint(equalTo: view.bottomAnchor),
        ])
        toolPicker.setVisible(true, forFirstResponder: canvas)
        toolPicker.addObserver(canvas)
        canvas.delegate = self
        canvas.becomeFirstResponder()
        if let drawing = try? PKDrawing(data: journalData) {
            canvas.drawing = drawing
        }
    }
}

extension JournalViewController: PKToolPickerObserver, PKCanvasViewDelegate {
    func canvasViewDrawingDidChange(_ canvasView: PKCanvasView) {
        journalChanged(canvasView.drawing.dataRepresentation())
    }
}

// extension PKDrawing {
//    func toImage(size: CGSize) -> UIImage {
//        let format = UIGraphicsImageRendererFormat()
//        format.scale = UIScreen.main.scale
//        let renderer = UIGraphicsImageRenderer(size: size, format: format)
//
//        let image = renderer.image { context in
//            UIColor.white.setFill()  // Set the background color (optional)
//            context.fill(CGRect(origin: .zero, size: size))
//
//            // Use the draw method of PKDrawing to render the drawing
//            self.image(from: CGRect(origin: .zero, size: size), scale: UIScreen.main.scale).draw(in: CGRect(origin: .zero, size: size))
//        }
//        return image
//    }
// }

// extension PKDrawing {
//    func toImage(size: CGSize) -> UIImage {
//        let format = UIGraphicsImageRendererFormat()
//        format.scale = UIScreen.main.scale
//        let renderer = UIGraphicsImageRenderer(size: size, format: format)
//
//        let image = renderer.image { context in
//            // Scale and render the drawing to fit within the size provided
//            let drawingBounds = self.bounds
//            let scale = min(size.width / drawingBounds.width, size.height / drawingBounds.height)
//
//            context.cgContext.scaleBy(x: scale, y: scale)
//            context.cgContext.translateBy(x: -drawingBounds.minX, y: -drawingBounds.minY)
//
//            UIColor.white.setFill()  // Set background color if needed
//            context.fill(CGRect(origin: .zero, size: size))
//
//            // Render the PKDrawing onto the scaled context
//            self.image(from: CGRect(origin: .zero, size: size), scale: UIScreen.main.scale).draw(in: CGRect(origin: CGPoint(x: -drawingBounds.minX, y: -drawingBounds.minY), size: size))
//        }
//        return image
//    }
// }

// extension PKDrawing {
//    /// Convert PKDrawing to UIImage with the given size
//    func toImage(size: CGSize) -> UIImage {
//        // Call the PKDrawing's built-in `image(from:scale:)` method directly
//        return self.image(from: CGRect(origin: .zero, size: size), scale: UIScreen.main.scale)
//    }
// }

extension PKDrawing {
    func toImage(size: CGSize) -> UIImage {
        let canvasBounds = CGRect(origin: .zero, size: size)

        // Create a graphics context
        UIGraphicsBeginImageContextWithOptions(size, false, 0.0)

        // Clear the background
        UIColor.clear.setFill()
        UIRectFill(canvasBounds)

        // Draw the PKDrawing in the context
        self.image(from: canvasBounds, scale: UIScreen.main.scale).draw(in: canvasBounds)

        // Get the rendered image
        let image = UIGraphicsGetImageFromCurrentImageContext()

        // End the image context
        UIGraphicsEndImageContext()

        return image ?? UIImage()
    }
}
