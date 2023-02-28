//
//  CurrentLevelViewController.swift
//  Puzzle-Game
//
//  Created by Vlad Lytvynets on 23.02.2023.
//

import Foundation
import UIKit

enum CurrentLevel {
    case lvl1, lvl2, lvl3, lvl4, lvl5, lvl6, lvl7, lvl8, lvl9, lvl10, lvl11, lvl12
}

class CurrentLevelViewController: UIViewController, UICollectionViewDelegate, UICollectionViewDataSource {
    
    let shadows = CustomizeShadows()
    var currentLevelArray = [LevelModel]()
    var currentLevel: CurrentLevel = .lvl1
    var numberOfLevel: Int = 0
    var runCount = 12
    var startTime = 0
    var imageLevel = UIImage()
    var timer: Timer?
    
    
    lazy private var referenceImage: UIImageView = {
        let image = UIImageView()
        image.contentMode = .scaleAspectFill
        image.layer.cornerRadius = 15
        image.translatesAutoresizingMaskIntoConstraints = false
        return image
    }()
    
    lazy private var backgroundTimeLabel: UIImageView = {
        let image = UIImageView()
        image.contentMode = .scaleToFill
        image.translatesAutoresizingMaskIntoConstraints = false
        return image
    }()
    
    lazy private var backgroundLevelLabel: UIImageView = {
        let image = UIImageView()
        image.contentMode = .scaleToFill
        image.translatesAutoresizingMaskIntoConstraints = false
        return image
    }()
    
    lazy private var borderImage: UIImageView = {
        let image = UIImageView()
        image.translatesAutoresizingMaskIntoConstraints = false
        image.contentMode = .scaleToFill
        return image
    }()
    
    lazy private var borderReferenceImage: UIImageView = {
        let image = UIImageView()
        image.translatesAutoresizingMaskIntoConstraints = false
        image.contentMode = .scaleAspectFill
        return image
    }()
    
    private let levelsCollectionView: UICollectionView = {
        let viewLayout = UICollectionViewFlowLayout()
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: viewLayout)
        collectionView.backgroundColor = .clear
        collectionView.layer.cornerRadius = 50
        return collectionView
    }()
    
    lazy private var backButton: UIButton = {
        let button = UIButton(type: .custom)
        button.setImage(UIImage(named: "Group 1"), for: .normal)
        button.addTarget(self, action: #selector(backButtonAction), for: .touchUpInside)
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    
    lazy private var reloadButton: UIButton = {
        let button = UIButton(type: .custom)
        button.setImage(UIImage(named: "Group 2"), for: .normal)
        button.translatesAutoresizingMaskIntoConstraints = false
        button.addTarget(self, action: #selector(reloadButtonAction), for: .touchUpInside)
        return button
    }()
    
    lazy private var currentlevelLabel: UILabel = {
        let label = UILabel()
        label.text = "LVL- 1"
        label.textColor = .white
        label.textAlignment = .center
        label.font = UIFont(name: "Marker felt", size: 34)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    lazy private var timerLabel: UILabel = {
        let label = UILabel()
        label.text = "--:--"
        label.textColor = .white
        label.textAlignment = .center
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    lazy private var backgroundImageView: UIImageView = {
        let imageView = UIImageView(frame: .zero)
        imageView.image = UIImage(named: "image 5")
        imageView.contentMode = .scaleToFill
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.addSubview(backgroundImageView)
        view.addSubview(reloadButton)
        view.addSubview(backButton)
        view.addSubview(backgroundLevelLabel)
        view.addSubview(currentlevelLabel)
        view.addSubview(backgroundTimeLabel)
        view.addSubview(timerLabel)
        view.addSubview(levelsCollectionView)
        view.addSubview(referenceImage)
        view.addSubview(borderImage)
        view.addSubview(borderReferenceImage)
        selectedLevel()
        startTime = runCount
        backgroundTimeLabel.image = UIImage(named: "Rectangle 3")
        backgroundLevelLabel.image = UIImage(named: "Rectangle 3")
        referenceImage.image = imageLevel
        borderImage.image = UIImage(named: "candy frame")
        borderReferenceImage.image = UIImage(named: "candy frame")
        levelsCollectionView.backgroundColor = .white
        currentLevelArray.shuffle()
        
        let gesture = UILongPressGestureRecognizer(target: self, action: #selector(gester))
        levelsCollectionView.addGestureRecognizer(gesture)
        
        collectionViewSettings()
        collectionViewLayout()
        backgroundImageConstraint()
        backButtonConstraint()
        reloadButtonConstraint()
        borderImageLayout()
        referenceImageLayout()
        labelsLayout()
        
        timerLabel.attributedText = NSAttributedString(string: "00:00", attributes: [
            .strokeColor: #colorLiteral(red: 0.954411447, green: 0.2074526548, blue: 0.7778509259, alpha: 1),
            .foregroundColor: #colorLiteral(red: 1, green: 1, blue: 1, alpha: 1),
            .strokeWidth: 8,
            .font: UIFont(name: "Knewave-Regular", size: view.frame.height * 0.03)!
        ])
        
        currentlevelLabel.attributedText = NSAttributedString(string: "LVL-", attributes: [
            .strokeColor: #colorLiteral(red: 0.954411447, green: 0.2074526548, blue: 0.7778509259, alpha: 1),
            .foregroundColor: #colorLiteral(red: 1, green: 1, blue: 1, alpha: 1),
            .strokeWidth: 8,
            .font: UIFont(name: "Knewave-Regular", size: view.frame.height * 0.03)!
        ])
        currentlevelLabel.text = "LVL-\(numberOfLevel)"
        
    }
    
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        print("viewWillAppear")
        runCount = startTime
        timer = Timer.scheduledTimer(timeInterval: 1.0, target: self, selector: #selector(fireTimer), userInfo: nil, repeats: true)
        currentLevelArray.shuffle()
        levelsCollectionView.reloadData()
    }
    
    
    //MARK: - Work with collectionView
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return currentLevelArray.count
    }
    
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "cell", for: indexPath) as! levelsCell
        cell.referenceImage.image = currentLevelArray[indexPath.item].puzzleImage
        cell.backgroundImage.image = nil
        cell.numberOfLevelBackground.image = nil
        cell.numberOfLevelLabel.text = nil
        return cell
    }
    
    
    func collectionView(_ collectionView: UICollectionView, moveItemAt sourceIndexPath: IndexPath, to destinationIndexPath: IndexPath) {
        let item = currentLevelArray.remove(at: sourceIndexPath.row)
        currentLevelArray.insert(item, at: destinationIndexPath.row)
        var score = 0 {
            didSet {
                if score < 0 {
                    score = 0
                }
            }
        }
        for (i, ind) in currentLevelArray.enumerated() {
            if i == ind.puzzleId {
                score += 1
            }else {
                score -= 1
            }
        }
        if score == 16 {
            let vc = LevelEndScreen(time: startTime - runCount, roundWon: numberOfLevel)
            vc.result = .win
            vc.modalPresentationStyle = .fullScreen
            self.present(vc, animated: true)
        }
    }
    
    
    func collectionView(_ collectionView: UICollectionView, canMoveItemAt indexPath: IndexPath) -> Bool {
        return true
    }
    
    
    //MARK: - Layout
    private func collectionViewSettings() {
        let layout = UICollectionViewFlowLayout()
        layout.minimumLineSpacing = 5.0
        layout.minimumInteritemSpacing = 5.0
        layout.itemSize = CGSize(width: view.frame.width / 4.8, height:  view.frame.width / 4.8)
        
        levelsCollectionView.setCollectionViewLayout(layout, animated: true)
        levelsCollectionView.delegate = self
        levelsCollectionView.dataSource = self
        levelsCollectionView.translatesAutoresizingMaskIntoConstraints = false
        levelsCollectionView.register(levelsCell.self, forCellWithReuseIdentifier: "cell")
    }
    
    
    private func referenceImageLayout() {
        NSLayoutConstraint.activate([
            referenceImage.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            referenceImage.topAnchor.constraint(equalTo: levelsCollectionView.bottomAnchor, constant: 60),
            referenceImage.widthAnchor.constraint(equalTo: view.widthAnchor, multiplier: 2/3),
            referenceImage.heightAnchor.constraint(equalTo: view.heightAnchor, multiplier: 1/4),
        ])
    }
    
    
    private func labelsLayout() {
        NSLayoutConstraint.activate([
            backgroundLevelLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            backgroundLevelLabel.centerYAnchor.constraint(equalTo: backButton.centerYAnchor),
            backgroundLevelLabel.widthAnchor.constraint(equalTo: view.widthAnchor, multiplier: 1/3.5),
            backgroundLevelLabel.heightAnchor.constraint(equalTo: view.heightAnchor, multiplier: 1/18),
            currentlevelLabel.centerXAnchor.constraint(equalTo: backgroundLevelLabel.centerXAnchor),
            currentlevelLabel.centerYAnchor.constraint(equalTo: backgroundLevelLabel.centerYAnchor),
            currentlevelLabel.widthAnchor.constraint(equalTo: view.widthAnchor, multiplier: 1/3),
            backgroundTimeLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -15),
            backgroundTimeLabel.centerYAnchor.constraint(equalTo: backButton.centerYAnchor),
            backgroundTimeLabel.widthAnchor.constraint(equalTo: view.widthAnchor, multiplier: 1/3.5),
            backgroundTimeLabel.heightAnchor.constraint(equalTo: view.heightAnchor, multiplier: 1/18),
            timerLabel.centerXAnchor.constraint(equalTo: backgroundTimeLabel.centerXAnchor),
            timerLabel.centerYAnchor.constraint(equalTo: backgroundTimeLabel.centerYAnchor),
            timerLabel.widthAnchor.constraint(equalTo: view.widthAnchor, multiplier: 1/3),
        ])
    }
    
    
    private func borderImageLayout() {
        NSLayoutConstraint.activate([
            borderImage.topAnchor.constraint(equalTo: levelsCollectionView.topAnchor, constant: -13),
            borderImage.bottomAnchor.constraint(equalTo: levelsCollectionView.bottomAnchor, constant: 13),
            borderImage.leadingAnchor.constraint(equalTo: levelsCollectionView.leadingAnchor, constant: -6),
            borderImage.trailingAnchor.constraint(equalTo: levelsCollectionView.trailingAnchor, constant: 6),
        ])
        
        NSLayoutConstraint.activate([
            borderReferenceImage.topAnchor.constraint(equalTo: referenceImage.topAnchor, constant: 0),
            borderReferenceImage.bottomAnchor.constraint(equalTo: referenceImage.bottomAnchor, constant: 0),
            borderReferenceImage.leadingAnchor.constraint(equalTo: referenceImage.leadingAnchor, constant: -6),
            borderReferenceImage.trailingAnchor.constraint(equalTo: referenceImage.trailingAnchor, constant: 6),
        ])
    }
    
    
    private func collectionViewLayout() {
        NSLayoutConstraint.activate([
            levelsCollectionView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 21),
            levelsCollectionView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -21),
            levelsCollectionView.topAnchor.constraint(equalTo: currentlevelLabel.bottomAnchor, constant: 30),
            levelsCollectionView.heightAnchor.constraint(equalTo: view.heightAnchor, multiplier: 4.1/10),
        ])
    }
    
    
    private func backButtonConstraint(){
        NSLayoutConstraint.activate([
            backButton.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: view.frame.height * 0.035),
            backButton.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 15),
            backButton.widthAnchor.constraint(equalToConstant: 40),
            backButton.heightAnchor.constraint(equalToConstant: 40),
        ])
    }
    
    
    private func reloadButtonConstraint(){
        NSLayoutConstraint.activate([
            reloadButton.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: view.frame.height * 0.035),
            reloadButton.leadingAnchor.constraint(equalTo: backButton.trailingAnchor, constant: 15),
            reloadButton.widthAnchor.constraint(equalToConstant: 40),
            reloadButton.heightAnchor.constraint(equalToConstant: 40),
        ])
    }
    
    
    private func backgroundImageConstraint(){
        NSLayoutConstraint.activate([
            backgroundImageView.topAnchor.constraint(equalTo: view.topAnchor),
            backgroundImageView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            backgroundImageView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            backgroundImageView.bottomAnchor.constraint(equalTo: view.bottomAnchor)
        ])
    }
    
    
    private func selectedLevel() {
        switch currentLevel {
        case .lvl1:
            currentLevelArray = lvl1
            numberOfLevel = 1
            imageLevel = UIImage(named: "level1Preview")!
            runCount = 180
        case .lvl2:
            currentLevelArray = lvl2
            numberOfLevel = 2
            imageLevel = UIImage(named: "level2preview")!
            runCount = 170
        case .lvl3:
            currentLevelArray = lvl3
            numberOfLevel = 3
            imageLevel = UIImage(named: "level3Preview")!
            runCount = 160
        case .lvl4:
            currentLevelArray = lvl1
            numberOfLevel = 4
            imageLevel = UIImage(named: "level1Preview")!
            runCount = 10
        case .lvl5:
            currentLevelArray = lvl1
            numberOfLevel = 5
            imageLevel = UIImage(named: "level3Preview")!
            runCount = 160
        case .lvl6:
            currentLevelArray = lvl1
            numberOfLevel = 6
            imageLevel = UIImage(named: "level3Preview")!
            runCount = 160
        case .lvl7:
            currentLevelArray = lvl1
            numberOfLevel = 7
            imageLevel = UIImage(named: "level3Preview")!
            runCount = 160
        case .lvl8:
            currentLevelArray = lvl1
            numberOfLevel = 8
            imageLevel = UIImage(named: "level3Preview")!
            runCount = 160
        case .lvl9:
            currentLevelArray = lvl1
            numberOfLevel = 9
            imageLevel = UIImage(named: "level3Preview")!
            runCount = 160
        case .lvl10:
            currentLevelArray = lvl1
            numberOfLevel = 10
            imageLevel = UIImage(named: "level3Preview")!
            runCount = 160
        case .lvl11:
            currentLevelArray = lvl1
            numberOfLevel = 11
            imageLevel = UIImage(named: "level3Preview")!
            runCount = 160
        case .lvl12:
            currentLevelArray = lvl1
            numberOfLevel = 12
            imageLevel = UIImage(named: "level3Preview")!
            runCount = 160
        }
    }
    
    
    //MARK: - Actions
    @objc func fireTimer(timer: Timer) {
        if(self.runCount > 0){
            let minutes = String(runCount / 60)
            let seconds = String(runCount % 60)
            timerLabel.text = "0" + minutes + ":" + seconds
            runCount -= 1
        }
        
        if runCount <= 0 {
            let vc = LevelEndScreen(time: startTime, roundWon: 0)
            vc.result = .luse
            vc.modalPresentationStyle = .fullScreen
            self.present(vc, animated: true)
            print("You lose")
            timer.invalidate()
        }
    }
    
    
    @objc func gester(_ gesture: UILongPressGestureRecognizer) {
        switch gesture.state {
        case .possible:
            print("possible")
        case .began:
            guard let targetindexPath = levelsCollectionView.indexPathForItem(at: gesture.location(in: levelsCollectionView)) else { return }
            levelsCollectionView.beginInteractiveMovementForItem(at: targetindexPath)
        case .changed:
            levelsCollectionView.updateInteractiveMovementTargetPosition(gesture.location(in: levelsCollectionView))
        case .ended:
            levelsCollectionView.endInteractiveMovement()
        case .cancelled:
            levelsCollectionView.cancelInteractiveMovement()
        case .failed:
            print("failed")
        @unknown default:
            print("Unknown")
        }
    }
    
    
    @objc func backButtonAction() {
        self.dismiss(animated: true)
    }
    
    
    @objc func reloadButtonAction() {
        runCount = startTime
        currentLevelArray.shuffle()
        levelsCollectionView.reloadData()
        
    }
    
    
    //MARK: - Arrays with levels
    var lvl1 = [LevelModel(puzzleId: 0, puzzleImage: UIImage(named: "imageLvl1_1")!),
                LevelModel(puzzleId: 1, puzzleImage: UIImage(named: "imageLvl1_2")!),
                LevelModel(puzzleId: 2, puzzleImage: UIImage(named: "imageLvl1_3")!),
                LevelModel(puzzleId: 3, puzzleImage: UIImage(named: "imageLvl1_4")!),
                LevelModel(puzzleId: 4, puzzleImage: UIImage(named: "imageLvl1_5")!),
                LevelModel(puzzleId: 5, puzzleImage: UIImage(named: "imageLvl1_6")!),
                LevelModel(puzzleId: 6, puzzleImage: UIImage(named: "imageLvl1_7")!),
                LevelModel(puzzleId: 7, puzzleImage: UIImage(named: "imageLvl1_8")!),
                LevelModel(puzzleId: 8, puzzleImage: UIImage(named: "imageLvl1_9")!),
                LevelModel(puzzleId: 9, puzzleImage: UIImage(named: "imageLvl1_10")!),
                LevelModel(puzzleId: 10, puzzleImage: UIImage(named: "imageLvl1_11")!),
                LevelModel(puzzleId: 11, puzzleImage: UIImage(named: "imageLvl1_12")!),
                LevelModel(puzzleId: 12, puzzleImage: UIImage(named: "imageLvl1_13")!),
                LevelModel(puzzleId: 13, puzzleImage: UIImage(named: "imageLvl1_14")!),
                LevelModel(puzzleId: 14, puzzleImage: UIImage(named: "imageLvl1_15")!),
                LevelModel(puzzleId: 15, puzzleImage: UIImage(named: "imageLvl1_16")!),
    ]
    
    
    var lvl2 = [LevelModel(puzzleId: 0, puzzleImage: UIImage(named: "imagelvl2_1")!),
                LevelModel(puzzleId: 1, puzzleImage: UIImage(named: "imagelvl2_2")!),
                LevelModel(puzzleId: 2, puzzleImage: UIImage(named: "imagelvl2_3")!),
                LevelModel(puzzleId: 3, puzzleImage: UIImage(named: "imagelvl2_4")!),
                LevelModel(puzzleId: 4, puzzleImage: UIImage(named: "imagelvl2_5")!),
                LevelModel(puzzleId: 5, puzzleImage: UIImage(named: "imagelvl2_6")!),
                LevelModel(puzzleId: 6, puzzleImage: UIImage(named: "imagelvl2_7")!),
                LevelModel(puzzleId: 7, puzzleImage: UIImage(named: "imagelvl2_8")!),
                LevelModel(puzzleId: 8, puzzleImage: UIImage(named: "imagelvl2_9")!),
                LevelModel(puzzleId: 9, puzzleImage: UIImage(named: "imagelvl2_10")!),
                LevelModel(puzzleId: 10, puzzleImage: UIImage(named: "imagelvl2_11")!),
                LevelModel(puzzleId: 11, puzzleImage: UIImage(named: "imagelvl2_12")!),
                LevelModel(puzzleId: 12, puzzleImage: UIImage(named: "imagelvl2_13")!),
                LevelModel(puzzleId: 13, puzzleImage: UIImage(named: "imagelvl2_14")!),
                LevelModel(puzzleId: 14, puzzleImage: UIImage(named: "imagelvl2_15")!),
                LevelModel(puzzleId: 15, puzzleImage: UIImage(named: "imagelvl2_16")!),
    ]
    
    
    var lvl3 = [LevelModel(puzzleId: 0, puzzleImage: UIImage(named: "imagelvl3_0")!),
                LevelModel(puzzleId: 1, puzzleImage: UIImage(named: "imagelvl3_1")!),
                LevelModel(puzzleId: 2, puzzleImage: UIImage(named: "imagelvl3_2")!),
                LevelModel(puzzleId: 3, puzzleImage: UIImage(named: "imagelvl3_3")!),
                LevelModel(puzzleId: 4, puzzleImage: UIImage(named: "imagelvl3_4")!),
                LevelModel(puzzleId: 5, puzzleImage: UIImage(named: "imagelvl3_5")!),
                LevelModel(puzzleId: 6, puzzleImage: UIImage(named: "imagelvl3_6")!),
                LevelModel(puzzleId: 7, puzzleImage: UIImage(named: "imagelvl3_7")!),
                LevelModel(puzzleId: 8, puzzleImage: UIImage(named: "imagelvl3_8")!),
                LevelModel(puzzleId: 9, puzzleImage: UIImage(named: "imagelvl3_9")!),
                LevelModel(puzzleId: 10, puzzleImage: UIImage(named: "imagelvl3_10")!),
                LevelModel(puzzleId: 11, puzzleImage: UIImage(named: "imagelvl3_11")!),
                LevelModel(puzzleId: 12, puzzleImage: UIImage(named: "imagelvl3_12")!),
                LevelModel(puzzleId: 13, puzzleImage: UIImage(named: "imagelvl3_13")!),
                LevelModel(puzzleId: 14, puzzleImage: UIImage(named: "imagelvl3_14")!),
                LevelModel(puzzleId: 15, puzzleImage: UIImage(named: "imagelvl3_15")!),
    ]
}
