//
//  ViewController.swift
//  SwiftMetalKitView
//
//  Created by Scott Richards on 3/29/22.
//

import Cocoa
import Metal
import MetalKit

class ViewController: NSViewController {
    var renderer: MetalRenderer?
    @IBOutlet weak var containerView: NSView!
    @IBOutlet weak var redView: NSView!
    @IBOutlet weak var greenView: NSView!
    @IBOutlet weak var blueView: NSView!
    @IBOutlet weak var grayView: NSView!
    @IBOutlet weak var cyanView: NSView!
    @IBOutlet weak var magentaView: NSView!
    @IBOutlet weak var yellowView: NSView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.wantsLayer = true
        if let metalView = self.view as? MTKView {
            metalView.enableSetNeedsDisplay = true
            metalView.device = MTLCreateSystemDefaultDevice()
            metalView.clearColor = MTLClearColorMake(1.0, 0.0, 0.0, 1.0)
            metalView.colorspace = nil // This is the secret to get the Color Space to be correct
            renderer = MetalRenderer(metalKitView: metalView)

            guard let renderer = renderer else {
                return
            }

            // Initialize the renderer with the view size.
            renderer.mtkView(metalView, drawableSizeWillChange: metalView.drawableSize)
            metalView.delegate = renderer
        }
        colorView(view: greenView, color: MTLClearColorMake(0.0, 1.0, 0.0, 1.0))
        colorView(view: blueView, color: MTLClearColorMake(0.0, 0.0, 1.0, 1.0))
        colorView(view: cyanView, color: MTLClearColorMake(0.0, 1.0, 1.0, 1.0))
        colorView(view: magentaView, color: MTLClearColorMake(1.0, 0.0, 1.0, 1.0))
        colorView(view: yellowView, color: MTLClearColorMake(1.0, 1.0, 0.0, 1.0))

    }

    override var representedObject: Any? {
        didSet {
        // Update the view, if already loaded.
        }
    }
    
    func colorView(view: NSView, color: MTLClearColor) {
        if let metalView = view as? MTKView {
            metalView.enableSetNeedsDisplay = true
            metalView.device = MTLCreateSystemDefaultDevice()
            metalView.clearColor = color
            metalView.colorspace = nil // This is the secret to get the Color Space to be correct
            renderer = MetalRenderer(metalKitView: metalView)

            guard let renderer = renderer else {
                return
            }

            // Initialize the renderer with the view size.
            renderer.mtkView(metalView, drawableSizeWillChange: metalView.drawableSize)
            metalView.delegate = renderer
        }
    }


}

