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
        
    }

    override var representedObject: Any? {
        didSet {
        // Update the view, if already loaded.
        }
    }


}

