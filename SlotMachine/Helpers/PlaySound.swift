//
//  PlaySound.swift
//  SlotMachine
//
//  Created by Maya Ghamloush on 18/03/2024.
//

import AVFoundation

var audioPlayer: AVAudioPlayer?
func playSound(sound: String , type: String){
    if let path = Bundle.main.path(forResource: sound, ofType: type){
        do{
            audioPlayer = try AVAudioPlayer(contentsOf: URL(fileURLWithPath: path))
            audioPlayer?.play()
        }catch{
            print("Error")
        }
    }
}
