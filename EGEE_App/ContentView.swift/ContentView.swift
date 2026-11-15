import SwiftUI

struct ContentView: View {
    @StateObject private var speechManager = SpeechManager()
    
    var body: some View {
        VStack(spacing: 20) {
            Text("EG-EE Intelligent Learning")
                .font(.title)
                .bold()
                .multilineTextAlignment(.center)
            
            Text(speechManager.transcription)
                .padding()
                .frame(maxWidth: .infinity, minHeight: 200)
                .background(Color.gray.opacity(0.1))
                .cornerRadius(10)
                .padding()
            
            Button(action: {
                if speechManager.isRecording {
                    speechManager.stopRecording()
                } else {
                    speechManager.startRecording()
                }
            }) {
                Text(speechManager.isRecording ? "Stop Recording" : "Start Recording")
                    .font(.headline)
                    .foregroundColor(.white)
                    .padding()
                    .background(speechManager.isRecording ? Color.red : Color.blue)
                    .cornerRadius(10)
            }
        }
    }
}