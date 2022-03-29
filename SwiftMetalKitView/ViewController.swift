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
    @IBOutlet weak var borderView: NSView!
    
    var redRenderer: MetalRenderer?
    var greenRenderer: MetalRenderer?
    var blueRenderer: MetalRenderer?
    var grayRenderer: MetalRenderer?
    var cyanRenderer: MetalRenderer?
    var magentaRenderer: MetalRenderer?
    var yellowRenderer: MetalRenderer?
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.wantsLayer = true
        borderView.wantsLayer = true
        borderView.layer?.borderColor = NSColor(hexString: "#FFC701")?.cgColor
        borderView.layer?.borderWidth = 15
        redRenderer = colorView(view: redView, color: MTLClearColorMake(1.0, 0.0, 0.0, 1.0))
        greenRenderer = colorView(view: greenView, color: MTLClearColorMake(0.0, 1.0, 0.0, 1.0))
        blueRenderer = colorView(view: blueView, color: MTLClearColorMake(0.0, 0.0, 1.0, 1.0))
        grayRenderer = colorView(view: grayView, color: MTLClearColorMake(0.5, 0.5, 0.5, 1.0))
        cyanRenderer = colorView(view: cyanView, color: MTLClearColorMake(0.0, 1.0, 1.0, 1.0))
        magentaRenderer = colorView(view: magentaView, color: MTLClearColorMake(1.0, 0.0, 1.0, 1.0))
        yellowRenderer = colorView(view: yellowView, color: MTLClearColorMake(1.0, 1.0, 0.0, 1.0))
    }

    override var representedObject: Any? {
        didSet {
        // Update the view, if already loaded.
        }
    }
    
    func colorView(view: NSView, color: MTLClearColor) -> MetalRenderer? {
        if let metalView = view as? MTKView {
            metalView.enableSetNeedsDisplay = true
            metalView.device = MTLCreateSystemDefaultDevice()
            metalView.clearColor = color
            metalView.colorspace = nil // This is the secret to get the Color Space to be correct
            let renderer = MetalRenderer(metalKitView: metalView)

            // Initialize the renderer with the view size.
            renderer.mtkView(metalView, drawableSizeWillChange: metalView.drawableSize)
            metalView.delegate = renderer
            return renderer
        }
        return nil
    }


}

