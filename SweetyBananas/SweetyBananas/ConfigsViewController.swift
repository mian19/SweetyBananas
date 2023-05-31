
import UIKit
import AVFoundation

class ConfigsViewController: UIViewController {
    var crossButton = UIButton()
    var woodView = UIImageView()
    var backgroundMusicPlayer: AVAudioPlayer?
    weak var delegate: MainViewController?
    var titleL: UILabel = {
        let customFont = UIFont(name: "Baloo-Regular", size: 40)
        let label = UILabel()
        label.font = customFont
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = "Settings"
        label.textAlignment = .center
        label.textColor = .white
        return label
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setBackground(imName: "background") 
        setViews()
    }
    
    private func setViews() {
        crossButton.setImage(UIImage(named: "cross"), for: .normal)
        crossButton.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(crossButton)
       
        crossButton.addTarget(self, action: #selector(toBack), for: .touchUpInside)
        
        woodView.translatesAutoresizingMaskIntoConstraints = false
        woodView.image = UIImage(named: "infoBack")
        view.addSubview(woodView)
        view.addSubview(titleL)
        NSLayoutConstraint.activate([
            crossButton.widthAnchor.constraint(equalToConstant: 56),
            crossButton.heightAnchor.constraint(equalToConstant: 56),
            crossButton.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 20),
            crossButton.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: -20),
            woodView.widthAnchor.constraint(equalToConstant: 334.adjustWidth()),
            woodView.heightAnchor.constraint(equalToConstant: 216),
            woodView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            woodView.centerYAnchor.constraint(equalTo: view.centerYAnchor),
            titleL.widthAnchor.constraint(equalToConstant: 157),
            titleL.heightAnchor.constraint(equalToConstant: 60),
            titleL.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            titleL.bottomAnchor.constraint(equalTo: woodView.topAnchor, constant: -30)

        ])
        
        setStacks()
        
    }
    
    func setStacks() {
        // Create the label views
        let label1 = UILabel()
        label1.font = UIFont(name: "Baloo-Regular", size: 24)
        label1.text = "Music"
        label1.textColor = .white
        label1.textAlignment = .left

        let label2 = UILabel()
        label2.font = UIFont(name: "Baloo-Regular", size: 24)
        label2.text = "Sounds"
        label2.textColor = .white
        label2.textAlignment = .left
        let label3 = UILabel()
        label3.font = UIFont(name: "Baloo-Regular", size: 24)
        label3.text = "Vibration"
        label3.textColor = .white
        label3.textAlignment = .left
        // Create the button views
        let button1 = UIButton()
        let isMusic = MemoryManager.shared().read(forKey: "music") as? Bool ?? true
        button1.setImage(UIImage(named: isMusic ? "optionsOn" : "optionsOff"), for: .normal)
        button1.tag = 1
        button1.adjustsImageWhenHighlighted = false
        button1.addTarget(self, action: #selector(onSettingButton), for: .touchUpInside)

        let button2 = UIButton()
        let isSounds = MemoryManager.shared().read(forKey: "sounds") as? Bool ?? true
        button2.setImage(UIImage(named: isSounds ? "optionsOn" : "optionsOff"), for: .normal)
        button2.tag = 2
        button2.adjustsImageWhenHighlighted = false
        button2.addTarget(self, action: #selector(onSettingButton), for: .touchUpInside)

        let button3 = UIButton()
        let isVibro = MemoryManager.shared().read(forKey: "vibro") as? Bool ?? true
        button3.setImage(UIImage(named: isVibro ? "optionsOn" : "optionsOff"), for: .normal)
        button3.tag = 3
        button3.adjustsImageWhenHighlighted = false
        button3.addTarget(self, action: #selector(onSettingButton), for: .touchUpInside)

        // Create the stack views
        let labelStackView = UIStackView(arrangedSubviews: [label1, label2, label3])
        labelStackView.axis = .vertical
        labelStackView.alignment = .leading
        labelStackView.spacing = 14

        let buttonStackView = UIStackView(arrangedSubviews: [button1, button2, button3])
        buttonStackView.axis = .vertical
        buttonStackView.alignment = .trailing
        buttonStackView.spacing = 20

        view.addSubview(buttonStackView)
        view.addSubview(labelStackView)

        buttonStackView.translatesAutoresizingMaskIntoConstraints = false
        buttonStackView.topAnchor.constraint(equalTo: woodView.topAnchor, constant: 30).isActive = true
        buttonStackView.trailingAnchor.constraint(equalTo: woodView.centerXAnchor, constant: -40).isActive = true
        labelStackView.translatesAutoresizingMaskIntoConstraints = false
        labelStackView.topAnchor.constraint(equalTo: woodView.topAnchor, constant: 30).isActive = true
        labelStackView.leadingAnchor.constraint(equalTo: buttonStackView.trailingAnchor, constant: 10).isActive = true

    }
    
    private func playMusic() {
        delegate?.playMusic()
     
    }
    
    private func stopMusic() {
        delegate?.stopMusic()
    }
    
    //MARK: - Acctions
    
    @objc func toBack() {
        self.navigationController?.popViewController(animated: true)
    }
    
    @objc func onSettingButton(_ sender: UIButton) {
        var isOn = true
        var key = ""
        switch sender.tag {
        case 1:
            key = "music"
            isOn = MemoryManager.shared().read(forKey: key) as? Bool ?? true
            
            if !isOn {
                playMusic()
            } else {
                stopMusic()
            }
        case 2:
            key = "sounds"
            isOn = MemoryManager.shared().read(forKey: key) as? Bool ?? true
        case 3:
            key = "vibro"
            isOn = MemoryManager.shared().read(forKey: key) as? Bool ?? true
        default:
            break
        }
        sender.setImage(UIImage(named: !isOn ? "optionsOn" : "optionsOff"), for: .normal)
        MemoryManager.shared().save(!isOn, forKey: key)
    }


}
