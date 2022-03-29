//
//  MetalRenderer.swift
//  SwiftMetalKitView
//
//  Created by Scott Richards on 3/29/22.
//

import Foundation
import MetalKit

class MetalRenderer: NSObject {
    private var device: MTLDevice?
    // The command queue used to pass commands to the device.
    private var commandQueue: MTLCommandQueue?
    
    
    init(metalKitView mtkView: MTKView) {
        super.init()
        device = mtkView.device
        guard let device = device else {
            return
        }
        // Create the command queue
        commandQueue = device.makeCommandQueue()
    }
}

extension MetalRenderer: MTKViewDelegate {
    
    func mtkView(_ view: MTKView, drawableSizeWillChange size: CGSize) {
        
    }
    
    func draw(in view: MTKView) {
        // The render pass descriptor references the texture into which Metal should draw
        guard let commandQueue = commandQueue, let renderPassDescriptor = view.currentRenderPassDescriptor else {
            return
        }
        guard let commandBuffer = commandQueue.makeCommandBuffer() else {
            return
        }
        guard let commandEncoder = commandBuffer.makeRenderCommandEncoder(descriptor: renderPassDescriptor) else {
            return
        }
        commandEncoder.endEncoding()
        // Get the drawable that will be presented at the end of the frame
        let drawable = view.currentDrawable
        // Request that the drawable texture be presented by the windowing system once drawing is done
        if let drawable = drawable {
            commandBuffer.present(drawable)
        }
        commandBuffer.commit()
    }
    
    
}
