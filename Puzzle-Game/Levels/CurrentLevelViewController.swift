//
//  CurrentLevelViewController.swift
//  Puzzle-Game
//
//  Created by Vlad Lytvynets on 23.02.2023.
//

import Foundation
import UIKit

class CurrentLevelViewController: UIViewController, UICollectionViewDelegate, UICollectionViewDataSource {
    
    let shadows = CustomizeShadows()
    
    var currentLevelArray = [LevelModel]()
    var numberOfLevel: Int = 0
    var runCount = 12
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
    
    
    //MARK: Init
    init(lvlArray: [LevelModel], numberOfLevel: Int, imageLevel: UIImage, time: Int) {
        super.init(nibName: nil, bundle: nil)
        self.currentLevelArray = lvlArray
        self.numberOfLevel = numberOfLevel
        self.imageLevel = imageLevel
        self.runCount = time
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
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
        
        currentlevelLabel.text = "LVL-\(numberOfLevel)"
        backgroundTimeLabel.image = UIImage(named: "Rectangle 3")
        backgroundLevelLabel.image = UIImage(named: "Rectangle 3")
        timer = Timer.scheduledTimer(timeInterval: 1.0, target: self, selector: #selector(fireTimer), userInfo: nil, repeats: true)
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
        shadowSettings()
        borderImageLayout()
        referenceImageLayout()
        labelsLayout()
        
        timerLabel.font = UIFont(name: "Marker felt", size: view.frame.height * 0.04)
        currentlevelLabel.font = UIFont(name: "Marker felt", size: view.frame.height * 0.04)
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
            let vc = LevelEndScreen()
            vc.result = .win
            self.present(vc, animated: true)
        }
    }
    
    
    func collectionView(_ collectionView: UICollectionView, canMoveItemAt indexPath: IndexPath) -> Bool {
        return true
    }
    
    
    private func shadowSettings() {
        shadows.makeShadowForOne(object: timerLabel, borderWidth: nil, borderColor: nil, shadowColor: #colorLiteral(red: 0.954411447, green: 0.2074526548, blue: 0.7778509259, alpha: 1), shadowRadius: 2.0, Opacity: 2.0)
        
        shadows.makeShadowForOne(object: currentlevelLabel, borderWidth: nil, borderColor: nil, shadowColor: #colorLiteral(red: 0.954411447, green: 0.2074526548, blue: 0.7778509259, alpha: 1), shadowRadius: 2.0, Opacity: 2.0)
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
            backgroundTimeLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -15),
            backgroundTimeLabel.centerYAnchor.constraint(equalTo: backButton.centerYAnchor),
            backgroundTimeLabel.widthAnchor.constraint(equalTo: view.widthAnchor, multiplier: 1/3.5),
            backgroundTimeLabel.heightAnchor.constraint(equalTo: view.heightAnchor, multiplier: 1/18),
            timerLabel.centerXAnchor.constraint(equalTo: backgroundTimeLabel.centerXAnchor),
            timerLabel.centerYAnchor.constraint(equalTo: backgroundTimeLabel.centerYAnchor)
        ])
    }
    
    
    private func borderImageLayout() {
        NSLayoutConstraint.activate([
            borderImage.topAnchor.constraint(equalTo: levelsCollectionView.topAnchor, constant: -12),
            borderImage.bottomAnchor.constraint(equalTo: levelsCollectionView.bottomAnchor, constant: 12),
            borderImage.leadingAnchor.constraint(equalTo: levelsCollectionView.leadingAnchor, constant: -5),
            borderImage.trailingAnchor.constraint(equalTo: levelsCollectionView.trailingAnchor, constant: 5),
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
    
    
    //MARK: - Actions
    @objc func fireTimer(timer: Timer) {
        if(self.runCount > 0){
            let minutes = String(runCount / 60)
            let seconds = String(runCount % 60)
            timerLabel.text = "0" + minutes + ":" + seconds
            runCount -= 1
        }
        
        if runCount <= 0 {
            let vc = LevelEndScreen()
            vc.result = .luse
            //  vc.modalPresentationStyle = .fullScreen
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
    
}
