//
//  HowToPlayViewController.swift
//  ForestPuzzle
//
//  Created by foxtree on 6.05.23.
//

import UIKit

class RulesViewController: UIViewController {

    var crossButton = UIButton()
    var woodView = UIImageView()
    var titleL: UILabel = {
        let customFont = UIFont(name: "Baloo-Regular", size: 40)
        let label = UILabel()
        label.font = customFont
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = "Rules"
        label.textAlignment = .center
        label.textColor = .white
        return label
    }()
    
    var textView: UITextView = {
         let textView = UITextView()
         textView.isEditable  = false
        textView.translatesAutoresizingMaskIntoConstraints = false
         textView.font = UIFont(name: "Baloo-Regular", size: 15)
         textView.textColor = .white
         textView.backgroundColor = .clear
        textView.text = """
 Objective: Puzzle games typically have a specific objective that players need to achieve. It could involve solving a pattern, arranging objects, or clearing a certain number of blocks.
 Gameplay: Puzzle games often require players to manipulate objects or pieces within the game to solve the puzzle. This could involve dragging and dropping, rotating, or swapping pieces to create a desired arrangement.
 Challenges: Puzzle games may introduce challenges or obstacles that players need to overcome. This could include limited moves or time, special rules for matching objects, or specific requirements for solving puzzles.
 Progression: Puzzle games often have multiple levels or stages, with increasing difficulty as players advance. Each level presents a new puzzle or challenge to solve.
 Strategy: Puzzle games often require strategic thinking and planning. Players may need to consider the effects of their moves or anticipate future obstacles to achieve the best outcome.
 Feedback and Scoring: Puzzle games usually provide feedback on player actions, such as indicating whether a move was successful or providing hints when requested. They may also keep track of scores, such as the time taken to complete a puzzle or the number of moves used.
 """
         textView.showsVerticalScrollIndicator = false
         return textView
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
        view.addSubview(textView)

        NSLayoutConstraint.activate([
            crossButton.widthAnchor.constraint(equalToConstant: 56),
            crossButton.heightAnchor.constraint(equalToConstant: 56),
            crossButton.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 20),
            crossButton.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: -20),
            woodView.widthAnchor.constraint(equalToConstant: 334.adjustWidth()),
            woodView.heightAnchor.constraint(equalToConstant: 560),
            woodView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            woodView.centerYAnchor.constraint(equalTo: view.centerYAnchor),
            textView.topAnchor.constraint(equalTo: woodView.topAnchor, constant: 30),
            textView.leadingAnchor.constraint(equalTo: woodView.leadingAnchor, constant: 10),
            textView.trailingAnchor.constraint(equalTo: woodView.trailingAnchor, constant: -10),
            textView.bottomAnchor.constraint(equalTo: woodView.bottomAnchor, constant: -30),
            titleL.widthAnchor.constraint(equalToConstant: 157),
            titleL.heightAnchor.constraint(equalToConstant: 60),
            titleL.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            titleL.bottomAnchor.constraint(equalTo: woodView.topAnchor, constant: -30)

        ])
        
        
    }
    
  
    
    //MARK: - Acctions
    
    @objc func toBack() {
        self.navigationController?.popViewController(animated: true)
    }
    



}
