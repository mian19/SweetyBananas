
import UIKit

class GameViewController: UIViewController {
    var currentLevel: Int? =  MemoryManager.shared().read(forKey: "maxAccessedLevel") as? Int ?? 1
    var homeButton = UIButton()
    var frameView = UIImageView()
    var isSetted = false
    var timerLabel: UILabel = {
        let label = UILabel()
        label.text = ""
        label.font = UIFont(name: "Baloo-Regular", size: 20)
        label.textAlignment = .center
        label.textColor = .white
        label.translatesAutoresizingMaskIntoConstraints = false
        label.backgroundColor = UIColor(patternImage: UIImage(named: "walllet")!)
        return label
    }()
    
    var titleL: UILabel = {
        let customFont = UIFont(name: "Baloo-Regular", size: 18)
        let label = UILabel()
        label.font = customFont
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textAlignment = .center
        label.textColor = .white
        return label
    }()
    
    var arrayForShuffle: [UIImageView] = []
    var arrayOfCenters: [CGPoint] = []
    var arrayOfCentersToCheckEndGame: [CGPoint] = []
    var wid: CGFloat!
    var hei: CGFloat!
    var emptyPoint: CGPoint!
    var tapCenter: CGPoint!
    var tapLeft: CGPoint!
    var tapRight: CGPoint!
    var tapTop: CGPoint!
    var tapBottom: CGPoint!
    var isLeft, isRight, isTop, isBottom: Bool!
    
    var elapsedTime: TimeInterval = 100
    var interval = 1.0
    var isPlaying = true
    var timer: Timer!
    
    var pauseButton = UIButton()
    var againButton = UIButton()
    var starButton = UIButton()
    override func viewDidLoad() {
        super.viewDidLoad()
        setBackground(imName: "background")
        setViews()
        self.navigationController?.interactivePopGestureRecognizer?.isEnabled = false
        titleL.text = "Level \(currentLevel ?? 1)"
        titleL.textAlignment = .right
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        self.startGame()
        shuffleImages()
        view.layoutIfNeeded()
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        if let timer = timer { timer.invalidate() }
    }

    func setViews() {
        homeButton.setImage(UIImage(named: "homeButton"), for: .normal)
        homeButton.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(homeButton)
        homeButton.addTarget(self, action: #selector(toBack), for: .touchUpInside)
        
        pauseButton.setImage(UIImage(named: "pauseButton"), for: .normal)
        pauseButton.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(pauseButton)
        pauseButton.addTarget(self, action: #selector(playPauseButtonTapped), for: .touchUpInside)
        
        againButton.setImage(UIImage(named: "againButton"), for: .normal)
        againButton.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(againButton)
        againButton.addTarget(self, action: #selector(resetButtonTapped), for: .touchUpInside)
        
        starButton.setImage(UIImage(named: "starButton"), for: .normal)
        starButton.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(starButton)
        starButton.addTarget(self, action: #selector(showImage), for: .touchDown)
        starButton.addTarget(self, action: #selector(showImageOld), for: .touchUpInside)
        
        view.addSubview(titleL)
        view.addSubview(timerLabel)
        timerLabel.text = "     100"
        frameView.translatesAutoresizingMaskIntoConstraints = false
        frameView.image = UIImage(named: "frame")
        view.addSubview(frameView)
        
        NSLayoutConstraint.activate([
            homeButton.widthAnchor.constraint(equalToConstant: 56),
            homeButton.heightAnchor.constraint(equalToConstant: 56),
            homeButton.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 20),
            homeButton.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: -20),
            timerLabel.widthAnchor.constraint(equalToConstant: 111),
            timerLabel.heightAnchor.constraint(equalToConstant: 48),
            timerLabel.centerYAnchor.constraint(equalTo: homeButton.centerYAnchor),
            timerLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 28),
            titleL.widthAnchor.constraint(equalToConstant: 100),
            titleL.heightAnchor.constraint(equalToConstant: 25),
            titleL.trailingAnchor.constraint(equalTo: homeButton.leadingAnchor, constant: -10),
            titleL.centerYAnchor.constraint(equalTo: homeButton.centerYAnchor),
            frameView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 33),
            frameView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -33),
            frameView.topAnchor.constraint(equalTo: titleL.bottomAnchor, constant: 40),
            frameView.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -108),
            againButton.widthAnchor.constraint(equalToConstant: 74),
            againButton.heightAnchor.constraint(equalToConstant: 74),
            againButton.topAnchor.constraint(equalTo: frameView.bottomAnchor, constant: 9),
            againButton.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            pauseButton.widthAnchor.constraint(equalToConstant: 56),
            pauseButton.heightAnchor.constraint(equalToConstant: 56),
            pauseButton.topAnchor.constraint(equalTo: frameView.bottomAnchor, constant: 20),
            pauseButton.trailingAnchor.constraint(equalTo: againButton.leadingAnchor, constant: -15),
            starButton.widthAnchor.constraint(equalToConstant: 56),
            starButton.heightAnchor.constraint(equalToConstant: 56),
            starButton.topAnchor.constraint(equalTo: frameView.bottomAnchor, constant: 20),
            starButton.leadingAnchor.constraint(equalTo: againButton.trailingAnchor, constant: 15),
            
        ])
    }
    
 
    func startGame() {
        titleL.text = "Level \(currentLevel ?? 1)"

        wid = round(frameView.frame.width / 3)
        hei = round(frameView.frame.height / 3)
        var xCenter = round(frameView.frame.origin.x)  + round(wid / 2)
        var yCenter = round(frameView.frame.origin.y) + round(hei / 2)
        var curIm = 1

        for _ in 0...2 {
            for _ in 0...2 {
                let imageView = UIImageView(image: UIImage(named: "\(currentLevel ?? 1)_\(curIm)"))
                imageView.frame = CGRect(x: 0, y: 0, width: wid, height: hei)
                imageView.isUserInteractionEnabled = true
                let currentCenter = CGPoint(x: xCenter, y: yCenter)
                    imageView.center = currentCenter
                arrayOfCenters.append(currentCenter)
                print(imageView.center)
                    self.view.addSubview(imageView)
                arrayForShuffle.append(imageView)
                view.bringSubviewToFront(frameView)
                    xCenter += wid
                
                curIm += 1
                print(curIm)
            }
            
            xCenter = frameView.frame.origin.x  + round(wid / 2)
            yCenter += hei
        }
        
        arrayForShuffle[8].removeFromSuperview()
        arrayForShuffle.remove(at: 8)
        startTimer()
        
    }
    
    func shuffleImages() {
        var newCenters: [CGPoint] = arrayOfCenters
        arrayForShuffle.forEach {imView in
            let rand = Int.random(in: 0...newCenters.count - 1)
            let randomCenter = newCenters[rand]
            
            imView.center = randomCenter
            arrayOfCentersToCheckEndGame.append(randomCenter)
            newCenters.remove(at: rand)
        }
        
        emptyPoint = newCenters.first
        
    }
    
    
    //MARK: - Acctions
    
    @objc func toBack() {
        if let timer = timer {
            timer.invalidate()
        }
        self.navigationController?.popToRootViewController(animated: true)
    }
    
    @objc func showImage() {
        frameView.image = UIImage(named: "\(currentLevel ?? 1)_10")
    }
    
    @objc func showImageOld() {
        frameView.image = UIImage(named: "frame")
    }
    
    override func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) {
        super.touchesEnded(touches, with: event)
        
        // Loop through all the touches and get their corresponding views
        for touch in touches {
            let touchLocation = touch.location(in: self.view)
            if let touchedView = self.view.hitTest(touchLocation, with: event) {
                tapCenter = touchedView.center
                tapLeft = CGPoint(x: tapCenter.x - wid, y: tapCenter.y)
                tapRight = CGPoint(x: tapCenter.x + wid, y: tapCenter.y )
                tapTop = CGPoint(x: tapCenter.x, y: tapCenter.y + hei)
                tapBottom = CGPoint(x: tapCenter.x, y: tapCenter.y - hei )
                isLeft = emptyPoint == tapLeft
                isRight = emptyPoint == tapRight
                isTop = emptyPoint == tapTop
                isBottom = emptyPoint == tapBottom
                
                if (isLeft || isRight || isBottom || isTop) {
                    UIView.animate(withDuration: 0.2){
                        touchedView.center = self.emptyPoint
                        self.emptyPoint = self.tapCenter
                        self.isLeft = false
                        self.isRight = false
                        self.isTop = false
                        self.isBottom = false
                    }
                }
                arrayOfCentersToCheckEndGame = []
                arrayForShuffle.forEach{
                    arrayOfCentersToCheckEndGame.append($0.center)
                }
                arrayOfCentersToCheckEndGame.append(emptyPoint)
                print(arrayOfCenters)
                print(arrayOfCentersToCheckEndGame)
                if arrayOfCenters == arrayOfCentersToCheckEndGame {
                    let alertController = UIAlertController(title: "You are win", message: "coins received: \(Int(elapsedTime))", preferredStyle: .alert)

                    let okAction = UIAlertAction(title: "OK", style: .default) { (_) in
                       var currentCash = MemoryManager.shared().read(forKey: "coins") as? Int ?? 0
                        currentCash += Int(self.elapsedTime)
                        MemoryManager.shared().save(currentCash, forKey: "coins")
                        
                        MemoryManager.shared().save(((self.currentLevel ?? 1) + 1), forKey: "maxAccessedLevel")
                        self.navigationController?.popToRootViewController(animated: true)
                    }

                    alertController.addAction(okAction)

                    self.present(alertController, animated: true, completion: nil)
                }
                
            }
        }
    }
    
    //MARK: - work with timer
    @objc func playPauseButtonTapped(_ sender: UIButton) {
          if isPlaying {
              pauseTimer()
          } else {
              startTimer()
          }
      }

    @objc func resetButtonTapped(_ sender: UIButton) {
          resetTimer()
      }
    
    func startTimer() {
        isPlaying = true
        interval = 1.0
        timer = Timer.scheduledTimer(withTimeInterval: interval, repeats: true) { [weak self] timer in

            if self!.elapsedTime != 0.0 {
                self?.elapsedTime -= self!.interval
                DispatchQueue.main.async {
                    self?.timerLabel.text = "     \(Int(self!.elapsedTime) )"
                }
            } else {
                let alertController = UIAlertController(title: "Game Over", message: "Try again later!", preferredStyle: .alert)

                let okAction = UIAlertAction(title: "OK", style: .default) { (_) in
                    self?.navigationController?.popToRootViewController(animated: true)
                }

                alertController.addAction(okAction)

                self?.present(alertController, animated: true, completion: nil)
            }
        }
        }
    
    func pauseTimer() {
        timer.invalidate()
        timer = nil
        interval = 0.0
        
        isPlaying = false
    }
    
    func resetTimer() {
        if let timer = timer {
            timer.invalidate()
        }
        timerLabel.text = "    100"
   
       // isPlaying = false
        elapsedTime = 100
        startTimer()
        shuffleImages()


    }

}
