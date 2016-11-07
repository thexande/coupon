//
//  SpeechSearchViewController.swift
//  coupon
//
//  Created by Alexander Murphy on 11/6/16.
//  Copyright © 2016 Alexander Murphy. All rights reserved.
//

import UIKit
import Speech

class SpeechSearchViewController: UIViewController, SFSpeechRecognizerDelegate {
   // Interface Outlets
    @IBOutlet weak var searchButtonImage: UIImageView!
    @IBOutlet weak var searchButton: UIButton!
    @IBOutlet weak var textView: UILabel!
    // Class vars
    private var speechRecognizer: SFSpeechRecognizer!
    private let defaultLocale = Locale(identifier: "en-US")
    private var recognitionRequest: SFSpeechAudioBufferRecognitionRequest!
    private var recognitionTask: SFSpeechRecognitionTask!
    private let audioEngine = AVAudioEngine()
    private var userSpeechString: String?
    
    // Interface Actions
    @IBAction func searchButtonTouchUpInside(_ sender: Any) {
        let generator = UINotificationFeedbackGenerator()
        generator.notificationOccurred(.success)
        
        if audioEngine.isRunning {
            audioEngine.stop()
            recognitionRequest?.endAudio()
            searchButtonImage.image = UIImage(named: "touch_up")
        }
    }
    
    @IBAction func searchButtonTouchDown(_ sender: Any) {
        searchButtonImage.image = UIImage(named: "touch_down")
        try! startRecording()
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
        prepareRecognizer(locale: defaultLocale)
    }
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        SFSpeechRecognizer.requestAuthorization { authStatus in
            /*
             The callback may not be called on the main thread. Add an
             operation to the main queue to update the record button's state.
             */
            OperationQueue.main.addOperation {
                switch authStatus {
                case .authorized:
                    self.searchButton.isEnabled = true
                    
                case .denied:
                    self.searchButton.isEnabled = false
                    self.searchButton.setTitle("User denied access to speech recognition", for: .disabled)
                    
                case .restricted:
                    self.searchButton.isEnabled = false
                    self.searchButton.setTitle("Speech recognition restricted on this device", for: .disabled)
                    
                case .notDetermined:
                    self.searchButton.isEnabled = false
                    self.searchButton.setTitle("Speech recognition not yet authorized", for: .disabled)
                }
            }
        }
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if (segue.identifier == "showResults") {
            let destination = segue.destination as! UINavigationController
            let retailerVC = destination.topViewController as! RetailersMasterViewController
            retailerVC.recieveVoiceText(voice: self.userSpeechString!.trimmingCharacters(in: .whitespaces))
        }
    }
    
    // [START speech recognition helper methods]
    private func prepareRecognizer(locale: Locale) {
        speechRecognizer = SFSpeechRecognizer(locale: locale)!
        speechRecognizer.delegate = self
    }
    private func startRecording() throws {
        
        // Cancel the previous task if it's running.
        if let recognitionTask = recognitionTask {
            recognitionTask.cancel()
            self.recognitionTask = nil
        }
        
        let audioSession = AVAudioSession.sharedInstance()
        try audioSession.setCategory(AVAudioSessionCategoryRecord)
        try audioSession.setMode(AVAudioSessionModeMeasurement)
        try audioSession.setActive(true, with: .notifyOthersOnDeactivation)
        
        recognitionRequest = SFSpeechAudioBufferRecognitionRequest()
        
        guard let inputNode = audioEngine.inputNode else { fatalError("Audio engine has no input node") }
        guard let recognitionRequest = recognitionRequest else { fatalError("Unable to created a SFSpeechAudioBufferRecognitionRequest object") }
        
        // Configure request so that results are returned before audio recording is finished
        recognitionRequest.shouldReportPartialResults = true
        
        // A recognition task represents a speech recognition session.
        // We keep a reference to the task so that it can be cancelled.
        recognitionTask = speechRecognizer.recognitionTask(with: recognitionRequest) { result, error in
            var isFinal = false
            
            if let result = result {
                self.textView.text = result.bestTranscription.formattedString.uppercased()
                self.userSpeechString = result.bestTranscription.formattedString.uppercased()
                isFinal = result.isFinal
                
                if(isFinal == true) {
                    // segue back to retailers with speech data
                    self.performSegue(withIdentifier: "showResults", sender: self)
                }
            }
            if error != nil || isFinal {
                self.audioEngine.stop()
                inputNode.removeTap(onBus: 0)
                self.recognitionRequest = nil
                self.recognitionTask = nil
            }
        }
        
        let recordingFormat = inputNode.outputFormat(forBus: 0)
        inputNode.installTap(onBus: 0, bufferSize: 1024, format: recordingFormat) { (buffer: AVAudioPCMBuffer, when: AVAudioTime) in
            self.recognitionRequest?.append(buffer)
        }
        
        audioEngine.prepare()
        
        try audioEngine.start()
        
        textView.text = "..."
    }
}
