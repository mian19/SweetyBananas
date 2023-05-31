
import UIKit

class OpendLevels: UIViewController {
    
    let buttonSize: CGFloat = 96.adjustWidth()
    var crossButton = UIButton()
    var maxAccessedLevel = 1
    var titleL: UILabel = {
        let customFont = UIFont(name: "Baloo-Regular", size: 40)
        let label = UILabel()
        label.font = customFont
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = "Select a level"
        label.textAlignment = .center
        label.textColor = .white
        return label
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setBackground(imName: "background")
        setViews()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        maxAccessedLevel = MemoryManager.shared().read(forKey: "maxAccessedLevel") as? Int ?? 1
        setStacks()
    }
    
    func setViews() {
        crossButton.setImage(UIImage(named: "cross"), for: .normal)
        crossButton.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(crossButton)
        view.addSubview(titleL)
        crossButton.addTarget(self, action: #selector(toBack), for: .touchUpInside)
        
        NSLayoutConstraint.activate([
            crossButton.widthAnchor.constraint(equalToConstant: 56),
            crossButton.heightAnchor.constraint(equalToConstant: 56),
            crossButton.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 20),
            crossButton.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: -20),
            titleL.widthAnchor.constraint(equalToConstant: 280),
            titleL.heightAnchor.constraint(equalToConstant: 60),
            titleL.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            titleL.topAnchor.constraint(equalTo: crossButton.bottomAnchor, constant: 28)

        ])
    }
    
    func setStacks() {
                let firstStackView = UIStackView()
                firstStackView.axis = .horizontal
                firstStackView.spacing = 10
                firstStackView.alignment = .center
                
                for i in 1...3 {
                    let button = generateButton(tag: i)
                    firstStackView.addArrangedSubview(button)
                }
                
                let secondStackView = UIStackView()
                secondStackView.axis = .horizontal
                secondStackView.spacing = 10
                secondStackView.alignment = .center
                
                for i in 4...6 {
                    let button = generateButton(tag: i)
                    secondStackView.addArrangedSubview(button)
                }
                
                let thirdStackView = UIStackView()
                thirdStackView.axis = .horizontal
                thirdStackView.spacing = 10
                thirdStackView.alignment = .center
                
                for i in 7...9 {
                    let button = generateButton(tag: i)
                    thirdStackView.addArrangedSubview(button)
                }
        
        let fourStackView = UIStackView()
        fourStackView.axis = .horizontal
        fourStackView.spacing = 10
        fourStackView.alignment = .center
               
            let button = generateButton(tag: 10)
            fourStackView.addArrangedSubview(button)
        
                
                let verticalStackView = UIStackView()
                verticalStackView.axis = .vertical
                verticalStackView.spacing = 20
                verticalStackView.alignment = .center
                
                verticalStackView.addArrangedSubview(firstStackView)
                verticalStackView.addArrangedSubview(secondStackView)
                verticalStackView.addArrangedSubview(thirdStackView)
        verticalStackView.addArrangedSubview(fourStackView)
                
                view.addSubview(verticalStackView)
                
                verticalStackView.translatesAutoresizingMaskIntoConstraints = false
                verticalStackView.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
                verticalStackView.topAnchor.constraint(equalTo: titleL.bottomAnchor, constant: 24).isActive = true
        verticalStackView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 28).isActive = true
        verticalStackView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -28).isActive = true
        
            
    }
    
    func generateButton(tag: Int) -> UIButton {

            let button = UIButton()
            button.tag = tag
        button.frame = CGRect(origin: .zero, size: CGSize(width: 96.adjustWidth(), height: 96.adjustWidth()))
            button.backgroundColor = .clear
        if tag <= maxAccessedLevel {
            button.setTitle("\(tag)", for: .normal)
            button.titleLabel?.font = UIFont(name: "Baloo-Regular", size: 48)
            button.setTitleColor(.white, for: .normal)
            button.setTitleColor(.gray, for: .highlighted)
            button.setBackgroundImage(UIImage(named: "level"), for: .normal)
            button.addTarget(self, action: #selector(toPlayLevel), for: .touchUpInside)
        } else {
            button.setBackgroundImage(UIImage(named: "lockedLevel"), for: .normal)
            button.isUserInteractionEnabled = false
        }
            button.contentHorizontalAlignment = .center
            button.contentVerticalAlignment = .center
            button.imageView?.contentMode = .scaleAspectFit
            return button
        

     }

    
    @objc func toBack() {
        self.navigationController?.popViewController(animated: true)
    }
    
    @objc func toPlayLevel(_ sender: UIButton) {
        let vc = GameViewController()
        let level = sender.tag
        if level == 100 {
            let currentLevel = MemoryManager.shared().read(forKey: "maxAccessedLevel") as? Int ?? 1
            vc.currentLevel = currentLevel
        } else {
            vc.currentLevel = level
        }
        self.navigationController?.pushViewController(vc, animated: true)
    }

}
