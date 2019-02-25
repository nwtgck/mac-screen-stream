// (base: https://qiita.com/rinov/items/c491782e21b55cd63a22)

import AVFoundation


final class ScreenRecorder: NSObject, AVCaptureVideoDataOutputSampleBufferDelegate {

    private let session = AVCaptureSession()

    // Output type is a file
    private let output = AVCaptureVideoDataOutput()

    // Store destination
    private var savePath: URL {
        // NOT work...
        // return URL(fileURLWithPath: "/dev/stdout")
        // TODO: Not to save as a file. Stream to stdout
        return URL(fileURLWithPath: "screen.mp4")
    }

    override init() {
        super.init()

        // Set high resolution
        // TODO: Hard code
        session.sessionPreset = AVCaptureSession.Preset.high

        // Get main display ID
        let displayID = CGDirectDisplayID(CGMainDisplayID())

        // Set main display as input source
        let input: AVCaptureScreenInput = AVCaptureScreenInput(displayID: displayID)

        // Not capture cursor
        // TODO: Hard code
        input.capturesCursor = false

        // Capture clicks
        // TODO: Hard code
        input.capturesMouseClicks = true

        if session.canAddInput(input) {
            // Add input
            session.addInput(input)
        }

        // (from: https://qiita.com/TakahiroYamamoto/items/e970658a98a4e659cf9e)
        // output.videoSettings = [kCVPixelBufferPixelFormatTypeKey as AnyHashable as! String : Int(kCVPixelFormatType_32BGRA)]
        output.alwaysDiscardsLateVideoFrames = true
        let queue:DispatchQueue = DispatchQueue(label: "myqueue", attributes: .concurrent)
        output.setSampleBufferDelegate(self, queue: queue)

        if session.canAddOutput(output) {
            print("can add output")
            // Add output
            session.addOutput(output)
        }
    }

    // Start recording
    func start() {
        session.startRunning()
        // output.startRecording(to: savePath, recordingDelegate: self)
        // output.setSampleBufferDelegate(self, queue: nil)
    }

    // Stop recording
    func stop() {
        // output.stopRecording()
    }

    func captureOutput(_ output: AVCaptureOutput, didOutput sampleBuffer: CMSampleBuffer, from connection: AVCaptureConnection) {
        print(Date(), ": captureOutput called!")
    }
}


let recorder = ScreenRecorder()

print("Starting...")
recorder.start()

print("Enter to stop")
let _ = readLine(strippingNewline: true)!

// // Sleep for a while
// // TODO: Remove: this is debug purpose
// Thread.sleep(forTimeInterval: 10.0)

// // TODO: Remove
// print("Stop")
// recorder.stop()
