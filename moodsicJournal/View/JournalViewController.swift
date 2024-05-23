//
//  JournalViewController.swift
//  moodsicJournal
//
//  Created by Dinda Ayu Syafitri on 23/05/24.
//
import PencilKit
import UIKit

class JournalViewController:UIViewController {
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
    var journalChanged: (Data) -> Void = {_ in}

    override func viewDidLoad() {
        super.viewDidLoad()
        view.addSubview(canvas)
        NSLayoutConstraint.activate([
            canvas.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            canvas.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            canvas.topAnchor.constraint(equalTo: view.topAnchor),
            canvas.bottomAnchor.constraint(equalTo: view.bottomAnchor)])
        toolPicker.setVisible(true, forFirstResponder: canvas)
        toolPicker.addObserver(canvas)
        canvas.delegate = self
        canvas.becomeFirstResponder()
        if let drawing = try? PKDrawing(data: journalData){
            canvas.drawing = drawing
        }
    }
}

extension JournalViewController:PKToolPickerObserver, PKCanvasViewDelegate{
    func canvasViewDrawingDidChange(_ canvasView: PKCanvasView) {
        journalChanged(canvasView.drawing.dataRepresentation())
    }
}
