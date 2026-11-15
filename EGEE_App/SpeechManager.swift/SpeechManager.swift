import Foundation
import AVFoundation
import CoreML

class SpeechManager: ObservableObject {
    @Published var transcription: String = ""
    @Published var isRecording: Bool = false
    
    private var audioEngine = AVAudioEngine()
    private var model: EGEE_SpeechModel? // This matches your .mlpackage name
    
    init() {
        loadModel()
    }
    
    func loadModel() {
        do {
            let config = MLModelConfiguration()
            config.computeUnits = .all // Use Neural Engine
            // Note: Xcode will auto-generate this class name from your .mlpackage
            model = try EGEE_SpeechModel(configuration: config) 
        } catch {
            print("Failed to load model: \(error)")
        }
    }
    
    func startRecording() {
        transcription = ""
        isRecording = true
        
        let audioSession = AVAudioSession.sharedInstance()
        try? audioSession.setCategory(.record, mode: .measurement, options: .duckOthers)
        try? audioSession.setActive(true, options: .notifyOthersOnDeactivation)
        
        let inputNode = audioEngine.inputNode
        let recordingFormat = inputNode.outputFormat(forBus: 0)
        
        inputNode.installTap(onBus: 0, bufferSize: 16000, format: recordingFormat) { [weak self] buffer, _ in
            self?.processAudioBuffer(buffer)
        }
        
        audioEngine.prepare()
        try? audioEngine.start()
    }
    
    func stopRecording() {
        audioEngine.stop()
        audioEngine.inputNode.removeTap(onBus: 0)
        isRecording = false
    }
    
    private func processAudioBuffer(_ buffer: AVAudioPCMBuffer) {
        // Note: Wav2Vec2 needs 16kHz audio. 
        // Real implementation requires audio conversion here if the mic is 48kHz.
        // For now, we will just pass a dummy array to prove the pipeline works.
        
        // guard let model = model else { return }
        // let input = EGEE_SpeechModelInput(input_values: ...)
        // let output = try? model.prediction(input: input)
    }
}