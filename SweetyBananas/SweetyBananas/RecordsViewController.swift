
import UIKit

class RecordsViewController: UIViewController {
   
    let buttonSize: CGFloat = 96.adjustWidth()
    var crossButton = UIButton()
    var coins = MemoryManager.shared().read(forKey: "coins") as? Int ?? 0
    var titleL: UILabel = {
        let customFont = UIFont(name: "Baloo-Regular", size: 40)
        let label = UILabel()
        label.font = customFont
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = "Achievements"
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
            titleL.widthAnchor.constraint(equalToConstant: 300),
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
                
                // Create the three buttons for the first stack view
                for i in 1...3 {
                    let button = createButton(tag: i)
                    firstStackView.addArrangedSubview(button)
                }
                
                // Create the second vertical stack view
                let secondStackView = UIStackView()
                secondStackView.axis = .horizontal
                secondStackView.spacing = 10
                secondStackView.alignment = .center
                
                // Create the four buttons for the second stack view
                for i in 4...6 {
                    let button = createButton(tag: i)
                    secondStackView.addArrangedSubview(button)
                }
                
                // Create the third vertical stack view
                let thirdStackView = UIStackView()
                thirdStackView.axis = .horizontal
                thirdStackView.spacing = 10
                thirdStackView.alignment = .center
                
                // Create the three buttons for the third stack view
                for i in 7...9 {
                    let button = createButton(tag: i)
                    thirdStackView.addArrangedSubview(button)
                }
        
        // Create the third vertical stack view
        let fourStackView = UIStackView()
        fourStackView.axis = .horizontal
        fourStackView.spacing = 10
        fourStackView.alignment = .center
        
        for i in 10...12 {
            let button = createButton(tag: i)
            fourStackView.addArrangedSubview(button)
        }
        // Create the three buttons for the third stack view
    
        
                
                // Create a horizontal stack view to hold the three vertical stack views
                let verticalStackView = UIStackView()
                verticalStackView.axis = .vertical
                verticalStackView.spacing = 20
                verticalStackView.alignment = .center
                
                verticalStackView.addArrangedSubview(firstStackView)
                verticalStackView.addArrangedSubview(secondStackView)
                verticalStackView.addArrangedSubview(thirdStackView)
        verticalStackView.addArrangedSubview(fourStackView)
                
                // Add the horizontal stack view to the main view
                view.addSubview(verticalStackView)
                
                // Set the constraints for the horizontal stack view
                verticalStackView.translatesAutoresizingMaskIntoConstraints = false
                verticalStackView.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
                verticalStackView.topAnchor.constraint(equalTo: titleL.bottomAnchor, constant: 24).isActive = true
        verticalStackView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 28).isActive = true
        verticalStackView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -28).isActive = true
        
            
    }
    
    func createButton(tag: Int) -> UIButton {

            let button = UIButton()
            button.tag = tag
        button.frame = CGRect(origin: .zero, size: CGSize(width: 96.adjustWidth(), height: 96.adjustWidth()))
            button.backgroundColor = .clear
        if coins >= tag * 50 {
          
            button.setBackgroundImage(UIImage(named: "a_\(tag)"), for: .normal)
        } else {
            button.setBackgroundImage(UIImage(named: "lockedLevel"), for: .normal)
            button.isUserInteractionEnabled = false
        }
            button.contentHorizontalAlignment = .center
            button.contentVerticalAlignment = .center
            button.imageView?.contentMode = .scaleAspectFit
            return button
        

     }
    
    //MARK: - Acctions
    
    @objc func toBack() {
        self.navigationController?.popViewController(animated: true)
    }

}
