import AVFoundation

class SoundManager {
    private var backgroundPlayer:AVAudioPlayer!
    private var sounds: AVAudioPlayer!
    static let shared = SoundManager()
   
    private init(){}
    
    func backgroundGameSound(selector: Bool){
      guard let path = Bundle.main.path(forResource: "backgroundMusic", ofType : "mp3") else {return}
      let url = URL(fileURLWithPath : path)
      backgroundPlayer = try? AVAudioPlayer(contentsOf: url)
      backgroundPlayer.prepareToPlay()
      if selector{
        backgroundPlayer.play()
        backgroundPlayer.numberOfLoops = -1
      } else {
        backgroundPlayer.pause()
      }
    }
    
    func coinSound(selector: Bool) {
        if selector == true {
            guard let path = Bundle.main.path(forResource: "coin", ofType : "mp3") else {return}
            let url = URL(fileURLWithPath : path)
            sounds = try? AVAudioPlayer(contentsOf: url)
            sounds.prepareToPlay()
            sounds.play()
        }
    }
    
    
    func buttonSound(selector: Bool) {
        if selector == true {
            guard let path = Bundle.main.path(forResource: "ball", ofType : "mp3") else {return}
            let url = URL(fileURLWithPath : path)
            sounds = try? AVAudioPlayer(contentsOf: url)
            sounds.prepareToPlay()
            sounds.play()
        }
    }
}



