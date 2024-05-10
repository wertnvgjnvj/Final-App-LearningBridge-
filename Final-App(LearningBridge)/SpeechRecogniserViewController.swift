import UIKit
import Speech
import AVFoundation

class SpeechRecogniserViewController: UIViewController, SFSpeechRecognizerDelegate {
    
    @IBOutlet weak var textView: UITextView!
    @IBOutlet weak var recordButton: UIButton!
    
    private let speechRecognizer = SFSpeechRecognizer(locale: Locale(identifier: "en-US"))!
    private var recognitionRequest: SFSpeechAudioBufferRecognitionRequest?
    private var recognitionTask: SFSpeechRecognitionTask?
    private let audioEngine = AVAudioEngine()
    
    private var fluctuationTimer: Timer?
    private let fluctuationFrequency: Double = 10.0 // Adjust as needed
    private var fluctuationAmplitude: Float = 0.1 // Adjust as needed
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        recordButton.isEnabled = false
        speechRecognizer.delegate = self
        SFSpeechRecognizer.requestAuthorization { authStatus in
            OperationQueue.main.addOperation {
                self.recordButton.isEnabled = authStatus == .authorized
            }
        }
    }
    
    @IBAction func recordButtonTapped(_ sender: UIButton) {
        if audioEngine.isRunning {
            stopRecording()
        } else {
            startRecording()
        }
    }
    
    func startRecording() {
        if recognitionTask != nil {
            recognitionTask?.cancel()
            recognitionTask = nil
        }
        
        let audioSession = AVAudioSession.sharedInstance()
        do {
            try audioSession.setCategory(.record, mode: .default, options: .duckOthers)
            try audioSession.setActive(true, options: .notifyOthersOnDeactivation)
            
            let inputNode = audioEngine.inputNode
            recognitionRequest = SFSpeechAudioBufferRecognitionRequest()
            
            guard let recognitionRequest = recognitionRequest else { fatalError("Unable to create recognition request") }
            recognitionRequest.shouldReportPartialResults = true
            
            recognitionTask = speechRecognizer.recognitionTask(with: recognitionRequest) { result, error in
                var isFinal = false
                if let result = result {
                    self.textView.text = result.bestTranscription.formattedString
                    isFinal = result.isFinal
                }
                
                if error != nil || isFinal {
                    self.audioEngine.stop()
                    inputNode.removeTap(onBus: 0)
                    self.recognitionRequest = nil
                    self.recognitionTask = nil
                    self.recordButton.isEnabled = true
                    self.recordButton.setTitle("Start Recording", for: .normal) // Set title to start recording
                }
            }
            
            let recordingFormat = inputNode.outputFormat(forBus: 0)
            inputNode.installTap(onBus: 0, bufferSize: 1024, format: recordingFormat) { buffer, _ in
                // Apply amplitude modulation to the audio buffer
                let modulatedBuffer = self.applyAmplitudeModulation(to: buffer)
                self.recognitionRequest?.append(modulatedBuffer)
            }
            
            audioEngine.prepare()
            try audioEngine.start()
            
            // Start fluctuation timer
            fluctuationTimer = Timer.scheduledTimer(withTimeInterval: 1.0 / fluctuationFrequency, repeats: true) { _ in
                self.fluctuationAmplitude = self.calculateFluctuationAmplitude()
            }
            
            // Set button title to stop recording
            recordButton.setTitle("Stop Recording", for: .normal)
        } catch {
            print("Error starting recording: \(error)")
        }
    }
    
    func stopRecording() {
        audioEngine.stop()
        audioEngine.inputNode.removeTap(onBus: 0)
        recognitionRequest?.endAudio()
        recognitionRequest = nil
        recognitionTask?.cancel()
        recognitionTask = nil
        recordButton.isEnabled = true
        
        // Stop fluctuation timer
        fluctuationTimer?.invalidate()
        fluctuationTimer = nil
        
        // Set button title to start recording
        recordButton.setTitle("Start Recording", for: .normal)
    }
    
    func applyAmplitudeModulation(to buffer: AVAudioPCMBuffer) -> AVAudioPCMBuffer {
        // Get buffer's audio data
        let audioBuffer = buffer.audioBufferList.pointee.mBuffers
        let frameLength = UInt32(buffer.frameLength)
        let channels = Int(audioBuffer.mNumberChannels)
        
        // Apply modulation to each sample in the buffer
        for ch in 0..<channels {
            let channelData = UnsafeMutableBufferPointer<Float>(start: audioBuffer.mData?.assumingMemoryBound(to: Float.self).advanced(by: ch), count: Int(frameLength))
            
            for i in 0..<Int(frameLength) {
                // Apply modulation factor to each sample
                channelData[i] *= fluctuationAmplitude
            }
        }
        
        return buffer
    }
    
    func calculateFluctuationAmplitude() -> Float {
        let currentTime = CFAbsoluteTimeGetCurrent()
        let fluctuationValue = sin(2 * .pi * fluctuationFrequency * currentTime)
        return Float(fluctuationValue)
    }
    
    func speechRecognizer(_ speechRecognizer: SFSpeechRecognizer, availabilityDidChange available: Bool) {
        recordButton.isEnabled = available
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let extractedVC = segue.destination as? ExtractedTextViewController {
            extractedVC.recordedText = textView.text
        }
    }
    
    @IBAction func unwindToSR(unwindSegue: UIStoryboardSegue) {
        
    }
}
