//
//  LevelEndScreen.swift
//  Puzzle-Game
//
//  Created by Vlad Lytvynets on 24.02.2023.
//

import Foundation
import UIKit

class LevelEndScreen: UIViewController {
    
    enum Result {
        case win
        case luse
    }
    
    let shadows = CustomizeShadows()
    var result: Result = .win
    var time = 0
    var bestTime = 0
    var roundWon = 0
    
    
    //MARK: Labels
    lazy private var resultLabel: UILabel = {
        let label = UILabel()
        label.text = "result"
        label.textColor = .white
        label.numberOfLines = 0
        label.textAlignment = .center
        label.font = UIFont(name: "Knewave-Regular", size: 30)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    
    lazy private var timetLabel: UILabel = {
        let label = UILabel()
        label.text = "TIME: 00:00"
        label.textColor = .white
        label.textAlignment = .center
        label.font = UIFont(name: "Knewave-Regular", size: 30)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    lazy private var bestTimetLabel: UILabel = {
        let label = UILabel()
        label.text = "BEST TIME: 00:00"
        label.textColor = .white
        label.textAlignment = .center
        label.font = UIFont(name: "Knewave-Regular", size: 30)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    
    //MARK: images
    lazy var resultImageView: UIImageView = {
        let imageView = UIImageView(frame: .zero)
        imageView.image = UIImage(named: "imageEndScreen")
        imageView.contentMode = .scaleAspectFit
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()
    
    
    lazy var timeImageView: UIImageView = {
        let imageView = UIImageView(frame: .zero)
        imageView.image = UIImage(named: "Rectangle 5")
        imageView.contentMode = .scaleAspectFit
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()
    
    lazy var bestImageView: UIImageView = {
        let imageView = UIImageView(frame: .zero)
        imageView.image = UIImage(named: "Rectangle 5")
        imageView.contentMode = .scaleAspectFit
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()
    
    
    //MARK: - Buttons
    lazy private var nextButton: UIButton = {
        let button = UIButton(type: .custom)
        button.setImage(UIImage(named: "Group 3"), for: .normal)
        button.translatesAutoresizingMaskIntoConstraints = false
        button.addTarget(self, action: #selector(nextRoundButtonAction), for: .touchUpInside)
        return button
    }()
    
    lazy private var homeButton: UIButton = {
        let button = UIButton(type: .custom)
        button.setImage(UIImage(named: "Group 5"), for: .normal)
        button.translatesAutoresizingMaskIntoConstraints = false
        button.addTarget(self, action: #selector(homeButtonAction), for: .touchUpInside)
        return button
    }()
    
    lazy private var repeatButton: UIButton = {
        let button = UIButton(type: .custom)
        button.setImage(UIImage(named: "Group 4"), for: .normal)
        button.translatesAutoresizingMaskIntoConstraints = false
        button.addTarget(self, action: #selector(repeatButtonAction), for: .touchUpInside)
        return button
    }()
    
    
    //MARK: - viewDidLoad
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .black.withAlphaComponent(0.8)
        view.addSubview(resultImageView)
        view.addSubview(resultLabel)
        view.addSubview(timeImageView)
        view.addSubview(bestImageView)
        view.addSubview(timetLabel)
        view.addSubview(bestTimetLabel)
        view.addSubview(nextButton)
        view.addSubview(homeButton)
        view.addSubview(repeatButton)
        bestTime = UserDefaults.standard.integer(forKey: "BestTime")
        bestTimeObserver()
        layoutSettings()
        fontSettings()
        
        switch result {
        case .win:
            resultImageView.image = UIImage(named: "imageEndScreen2")
            resultLabel.text = "LEVEL \n COMPLETED"
            timeConvert()
            bestTimeConvert()
            bestImageView.isHidden = false
            bestTimetLabel.isHidden = false
            
        case .luse:
            resultImageView.image = UIImage(named: "imageEndScreen")
            resultLabel.text = "LEVEL \n FAILED"
            timeConvert()
            bestImageView.isHidden = true
            bestTimetLabel.isHidden = true
            nextButton.tintColor = .gray
            nextButton.isEnabled = false
        }
    }
    
    
    init(time: Int, roundWon: Int ) {
        super.init(nibName: nil, bundle: nil)
        self.time = time
        self.roundWon = roundWon
    }
    
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    private func timeConvert() {
        if(self.time > 0){
            let minutes = String(time / 60)
            let seconds = String(time % 60)
            timetLabel.text = "TIME: " + "0" + minutes + ":" + seconds
        }
    }
    
    
    private func bestTimeConvert() {
        if(self.bestTime > 0){
            let minutes = String(bestTime / 60)
            let seconds = String(bestTime % 60)
            bestTimetLabel.text = "BEST TIME: " + "0" + minutes + ":" + seconds
        }
    }
    
    
    private func bestTimeObserver() {
        guard result == .win else { return }
        if bestTime <= 0 {
            bestTime = time
            UserDefaults.standard.set(time, forKey: "BestTime")
        }else if bestTime > time {
            bestTime = time
            UserDefaults.standard.set(time, forKey: "BestTime")
        }else {
            bestTime = UserDefaults.standard.integer(forKey: "BestTime")
        }
    }
    
    
    private func fontSettings() {
        timetLabel.attributedText = NSAttributedString(string: "TIME: 00:00", attributes: [
            .strokeColor: #colorLiteral(red: 0.954411447, green: 0.2074526548, blue: 0.7778509259, alpha: 1),
            .foregroundColor: #colorLiteral(red: 1, green: 1, blue: 1, alpha: 1),
            .strokeWidth: 8,
            .font: UIFont(name: "Knewave-Regular", size: view.frame.height * 0.03)!
        ])
        
        bestTimetLabel.attributedText = NSAttributedString(string: "BEST TIME: 00:00", attributes: [
            .strokeColor: #colorLiteral(red: 0.954411447, green: 0.2074526548, blue: 0.7778509259, alpha: 1),
            .foregroundColor: #colorLiteral(red: 1, green: 1, blue: 1, alpha: 1),
            .strokeWidth: 8,
            .font: UIFont(name: "Knewave-Regular", size: view.frame.height * 0.03)!
        ])
        
        resultLabel.attributedText = NSAttributedString(string: " ", attributes: [
            .strokeColor: #colorLiteral(red: 0.954411447, green: 0.2074526548, blue: 0.7778509259, alpha: 1),
            .foregroundColor: #colorLiteral(red: 1, green: 1, blue: 1, alpha: 1),
            .strokeWidth: -11,
            .font: UIFont(name: "Knewave-Regular", size: view.frame.height * 0.06)!
        ])
    }
    
    
    //MARK: - Layout
    private func layoutSettings() {
        NSLayoutConstraint.activate([
            resultImageView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            resultImageView.topAnchor.constraint(equalTo: view.topAnchor, constant: 20),
            resultImageView.widthAnchor.constraint(equalTo: view.widthAnchor, multiplier: 2/3),
            resultLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            resultLabel.topAnchor.constraint(equalTo: resultImageView.bottomAnchor, constant: -100),
            resultLabel.widthAnchor.constraint(equalTo: view.widthAnchor, multiplier: 3/3),
            resultLabel.heightAnchor.constraint(equalTo: view.heightAnchor, multiplier: 1/5),
            timeImageView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            timeImageView.topAnchor.constraint(equalTo: resultLabel.bottomAnchor, constant: 5),
            timeImageView.widthAnchor.constraint(equalTo: view.widthAnchor, multiplier: 2/3),
            timetLabel.centerXAnchor.constraint(equalTo: timeImageView.centerXAnchor),
            timetLabel.centerYAnchor.constraint(equalTo: timeImageView.centerYAnchor),
            timetLabel.widthAnchor.constraint(equalTo: view.widthAnchor, multiplier: 2/3),
            bestImageView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            bestImageView.topAnchor.constraint(equalTo: timeImageView.bottomAnchor, constant: 2),
            bestImageView.widthAnchor.constraint(equalTo: view.widthAnchor, multiplier: 2/3),
            bestTimetLabel.centerXAnchor.constraint(equalTo: bestImageView.centerXAnchor),
            bestTimetLabel.centerYAnchor.constraint(equalTo: bestImageView.centerYAnchor),
            bestTimetLabel.widthAnchor.constraint(equalTo: view.widthAnchor, multiplier: 2/3),
            homeButton.topAnchor.constraint(equalTo: bestImageView.bottomAnchor, constant: 10),
            homeButton.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 40),
            repeatButton.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            repeatButton.topAnchor.constraint(equalTo: bestImageView.bottomAnchor, constant: 5),
            nextButton.topAnchor.constraint(equalTo: bestImageView.bottomAnchor, constant: 10),
            nextButton.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -40),
        ])
    }
    
    
    private func shadowsSettings() {
        shadows.makeShadowForOne(object: timetLabel,
                                 borderWidth: nil,
                                 borderColor: nil,
                                 shadowColor: #colorLiteral(red: 0.954411447, green: 0.2074526548, blue: 0.7778509259, alpha: 1),
                                 shadowRadius: 2.0,
                                 Opacity: 2.0)
        shadows.makeShadowForOne(object: bestTimetLabel,
                                 borderWidth: nil,
                                 borderColor: nil,
                                 shadowColor: #colorLiteral(red: 0.954411447, green: 0.2074526548, blue: 0.7778509259, alpha: 1),
                                 shadowRadius: 2.0,
                                 Opacity: 2.0)
    }
    
    
    
    //MARK: - Actions
    @objc func repeatButtonAction() {
        dismiss(animated: true)
    }
    
    
    @objc func nextRoundButtonAction() {
        switch roundWon {
        case 0:
            print("0")
        case 1:
            let vc = CurrentLevelViewController()
            vc.currentLevel = .lvl2
            vc.modalPresentationStyle = .fullScreen
            self.present(vc, animated: true)
        case 2:
            let vc = CurrentLevelViewController()
            vc.currentLevel = .lvl3
            vc.modalPresentationStyle = .fullScreen
            self.present(vc, animated: true)
        case 3:
            let vc = CurrentLevelViewController()
            vc.currentLevel = .lvl4
            vc.modalPresentationStyle = .fullScreen
            self.present(vc, animated: true)
        case 4:
            print("5")
        case 5:
            print("6")
        case 6:
            print("7")
        case 7:
            print("8")
        case 8:
            print("9")
        case 9:
            print("10")
        case 10:
            print("11")
        case 11:
            print("12")
        case 12:
            print("1")
        default:
            print("0")
        }
    }
    
    
    @objc func homeButtonAction() {
        let vc = MainViewController()
        vc.modalPresentationStyle = .fullScreen
        vc.modalTransitionStyle = .flipHorizontal
        self.present(vc, animated: true)
    }
    
}
