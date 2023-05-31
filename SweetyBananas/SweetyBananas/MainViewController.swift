
import Foundation
import UIKit
import AVFoundation


class MainViewController: UIViewController {
    
   
    var backgroundMusicPlayer: AVAudioPlayer?
    let buttonTitles = ["Play", "Levels", "Achivements"]
    let normalBackgroundImage = "menuButton"
    let selectedBackgroundImage = "selectedMenuButton"
    let customFontName = "Baloo-Regular"
    let customFontSize: CGFloat = 40
    let settingsButton = UIButton(type: .custom)
    let infoButton = UIButton(type: .custom)
    lazy var stackView: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .vertical
        stackView.alignment = .fill
        stackView.distribution = .fillEqually
        stackView.spacing = 10
        return stackView
    }()
    
    override func viewDidLoad () {
        super.viewDidLoad()
       
       let isOn = MemoryManager.shared().read(forKey: "music") as? Bool ?? true
        if isOn {
            playMusic()
        }
        setupViews()
    }
    
    private func setupViews() {
        setBackground(imName: "launchImg")
        
        settingsButton.setImage(UIImage(named: "settings"), for: .normal)
        settingsButton.translatesAutoresizingMaskIntoConstraints = false
        
        view.addSubview(settingsButton)
        settingsButton.tag = 4
        settingsButton.addTarget(self, action: #selector(buttonTapped(_:)), for: .touchUpInside)
        infoButton.setImage(UIImage(named: "info"), for: .normal)
        infoButton.translatesAutoresizingMaskIntoConstraints = false
        infoButton.tag = 3
        view.addSubview(infoButton)
      
        infoButton.addTarget(self, action: #selector(buttonTapped(_:)), for: .touchUpInside)
        for i in 0..<buttonTitles.count {
            let button = UIButton()
            button.tag = i
            button.setTitle(buttonTitles[i], for: .normal)
            
            button.titleLabel?.font = UIFont(name: customFontName, size: customFontSize)
            button.setBackgroundImage(UIImage(named: normalBackgroundImage), for: .normal)
            button.setTitleColor(.white , for: .highlighted)
            button.setTitleColor(UIColor.white, for: .normal)
            button.setBackgroundImage(UIImage(named: selectedBackgroundImage), for: .highlighted)
            button.addTarget(self, action: #selector(buttonTapped(_:)), for: .touchUpInside)
            
            stackView.addArrangedSubview(button)
        }
        
        view.addSubview(stackView)
        stackView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([

            stackView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 40),
            stackView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -40),
            stackView.centerYAnchor.constraint(equalTo: view.centerYAnchor),
                        settingsButton.widthAnchor.constraint(equalToConstant: view.frame.width/2 - 50),
                        settingsButton.heightAnchor.constraint(equalToConstant: 84),
                        settingsButton.topAnchor.constraint(equalTo: stackView.bottomAnchor, constant: 20),
                        settingsButton.trailingAnchor.constraint(equalTo: stackView.trailingAnchor),
            infoButton.widthAnchor.constraint(equalToConstant: view.frame.width/2 - 50),
            infoButton.heightAnchor.constraint(equalToConstant: 84),
            infoButton.topAnchor.constraint(equalTo: stackView.bottomAnchor, constant: 20),
            infoButton.leadingAnchor.constraint(equalTo: stackView.leadingAnchor)
        ])
        
    }
    
    func playMusic() {
       
        let path = Bundle.main.path(forResource: "back", ofType: "mp3")!
        let url = URL(fileURLWithPath: path)
        do {
            backgroundMusicPlayer = try AVAudioPlayer(contentsOf: url)
            backgroundMusicPlayer?.numberOfLoops = -1 // infinite loop
            backgroundMusicPlayer?.play()
        } catch {
            // handle error
        }
   
    }
    
   func stopMusic() {
        backgroundMusicPlayer?.stop()
   

    }
    
    //MARK: - Actions
    
    @objc func buttonTapped(_ sender: UIButton) {
        let  isOnVibro = MemoryManager.shared().read(forKey: "vibro") as? Bool ?? true
        if isOnVibro {
            AudioServicesPlaySystemSound(kSystemSoundID_Vibrate)
          
        }

        
        
        let  isOnSound = MemoryManager.shared().read(forKey: "sounds") as? Bool ?? true
        // Create a system sound ID for the sound file
        if isOnSound {
            guard let soundUrl = Bundle.main.url(forResource: "tap", withExtension: "wav") else {
                return
            }
            var soundId: SystemSoundID = 0
            AudioServicesCreateSystemSoundID(soundUrl as CFURL, &soundId)
            
            // Play the sound
            AudioServicesPlaySystemSound(soundId)
        }
        
        switch sender.tag {
        case 0:
            print("")
            let vc = GameViewController()
          
                let currentLevel = MemoryManager.shared().read(forKey: "maxAccessedLevel") as? Int ?? 1
                vc.currentLevel = currentLevel
            
                
            
           
            self.navigationController?.pushViewController(vc, animated: true)
        case 1:
            print("")
            let vc = OpendLevels()
           
            self.navigationController?.pushViewController(vc, animated: true)
        case 2:
            print("")
            let vc = RecordsViewController()
           
            self.navigationController?.pushViewController(vc, animated: true)
           // coordinator?.toLevel()
        case 3:
            print("")
            let vc = RulesViewController()
           
            self.navigationController?.pushViewController(vc, animated: true)
        default:
            let vc = ConfigsViewController()
            vc.delegate = self
            self.navigationController?.pushViewController(vc, animated: true)
            print("")
          //  coordinator?.toSettings(vC: self)
        }
        
    }
}

extension UIViewController {
    
    func setBackground(imName: String) {
        let backgroundImage = UIImage(named: imName)

        let backgroundImageView = UIImageView(image: backgroundImage)
        backgroundImageView.contentMode = .scaleAspectFill // or .scaleAspectFit
        view.insertSubview(backgroundImageView, at: 0)
        backgroundImageView.frame = view.frame
        backgroundImageView.clipsToBounds = true
    }
}
