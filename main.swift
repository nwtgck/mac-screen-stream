// (base: https://qiita.com/rinov/items/c491782e21b55cd63a22)

import AVFoundation


final class ScreenRecorder: NSObject, AVCaptureFileOutputRecordingDelegate {

    private let session = AVCaptureSession()

    // Output type is a file
    private let output = AVCaptureMovieFileOutput()

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

        if session.canAddOutput(output) {
            print("can add output")
            // Add output
            session.addOutput(output)
        }
    }

    // Start recording
    func start() {
        session.startRunning()
        output.startRecording(to: savePath, recordingDelegate: self)
    }

    // Stop recording
    func stop() {
        output.stopRecording()
    }

    func capture(_ captureOutput: AVCaptureFileOutput!, didFinishRecordingToOutputFileAt outputFileURL: URL!, fromConnections connections: [Any]!, error: Error!) {
        session.stopRunning()
    }

    func fileOutput(_ output: AVCaptureFileOutput, didFinishRecordingTo outputFileURL: URL, from connections: [AVCaptureConnection], error: Error?) {
        print("fileOutput called...")
    }
}


let recorder = ScreenRecorder()

print("Starting...")
recorder.start()

// Sleep for a while
// TODO: Remove: this is debug purpose
Thread.sleep(forTimeInterval: 10.0)

// TODO: Remove
print("Stop")
recorder.stop()
