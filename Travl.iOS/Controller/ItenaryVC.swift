//
//  DiscoverDetail.swift
//  Travl.iOS
//
//  Created by Ikmal Azman on 21/08/2021.
//

import UIKit

enum CardState {
    case expanded
    case collapsed
}

class ItenaryVC: UIViewController {
    
    @IBOutlet weak var backgroundImage: UIImageView!
    
    var cardVC : CardView!
    var visualEffectView : UIVisualEffectView!
    var imageURL : URL!
    
    var locationDetails: Location! {
        didSet {
            getItenaries(at: locationDetails.itenaryName)
        }
    }
    var itenaries = [[Days]]()
   
    private var runningAnimations = [UIViewPropertyAnimator]()
    private var animationProgressWhenInterupted : CGFloat = 0
    private var cardVisible = false
    
    private var cardHandleAreaHeight : CGFloat {
        get {
            return deviceHeight * 0.12
        }
    }
    
    private var deviceHeight : CGFloat {
        get {
            return UIScreen.main.bounds.height
        }
    }
    private var cardHeight : CGFloat {
        get {
            return (deviceHeight/2) * 1.6
        }
    }
    private var nextState : CardState {
        if cardVisible == true {
            return .collapsed
        } else {
            return .expanded
        }
    }
    //MARK:- Life Cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        setupCard()
        setupView()
    }
    
    @IBAction func saveButtonPressed(_ sender: UIButton) {
        // Saved Itenary In Core Data
    }
    
    func getItenaries(at itenaries : String = "Melaka"){
        NetworkManager.shared.getItenaries(for: itenaries) { [weak self] itenary in
            switch itenary {
            
            case .success(let itenary):
                print(itenary)
                self?.itenaries.append(contentsOf: itenary)
                print(itenaries.count)
            case .failure(let error):
                print(error.rawValue)
            }
        }
    }
    
}

//MARK:- Private methods
extension ItenaryVC {
    private func setupView() {
        backgroundImage.downloaded(from: imageURL)
        backgroundImage.contentMode = .scaleAspectFill
    }
    
    private func setupCard() {
        
        visualEffectView = UIVisualEffectView()
        visualEffectView.frame = self.view.frame
        self.view.addSubview(visualEffectView)
        
        cardVC = CardView(nibName: R.nib.cardView.name, bundle: nil)
        self.addChild(cardVC)
        self.view.addSubview(cardVC.view)
        
        cardVC.view.frame = CGRect(x: 0, y: self.view.frame.height - cardHandleAreaHeight, width: self.view.bounds.width, height: cardHeight)
        cardVC.view.clipsToBounds = true
        
        let tapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(self.handleCardTap(recognizer:)))
        let panGestureRecognizer = UIPanGestureRecognizer(target: self, action: #selector(self.handleCardPan(recognizer:)))
        
        cardVC.handlerArea.addGestureRecognizer(tapGestureRecognizer)
        cardVC.handlerArea.addGestureRecognizer(panGestureRecognizer)
        
        // Assign self as data source, delegate at cardView
        cardVC.tableView.delegate = self
        cardVC.tableView.dataSource = self
        
        cardVC.cityLabel.text = locationDetails.locationName
        cardVC.sloganLabel.text = locationDetails.slogan
        
        
            
    }
    
    
}

//MARK:- DataSource
extension ItenaryVC : UITableViewDataSource {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        1
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 10
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = cardVC.tableView.dequeueReusableCell(withIdentifier: R.nib.itenaryCell.identifier, for: indexPath) as! ItenaryCell
        cell.headerLabel.text = "Testing"
     //cell.textLabel?.text = "hello"
        return cell
    }
    
}

//MARK:- Delegate
extension ItenaryVC : UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
    }
}

//MARK:- Handler Methods

extension ItenaryVC {
    
    @objc  func handleCardTap(recognizer : UITapGestureRecognizer) {
        //Determine tap gesture state
        switch recognizer.state {
        
        case .ended:
            animateTranstionIfNeeded(state: nextState, duration: 0.9)
        default:
            break
        }
    }
    
    @objc  func handleCardPan(recognizer : UIPanGestureRecognizer) {
        // Determine pan gesture state
        switch recognizer.state {
        
        case .began:
            startInteractiveTransition(state: nextState, duration: 0.9)
            print(itenaries)
        case .changed :
            // Check current translation of the recognizer, allow to calculate the complete fraction
            let translation = recognizer.translation(in: self.cardVC.handlerArea)
            var  fractionComplete = translation.y / cardHeight
            // Check if cardVisible, if visible we only need fraction complete or else we want the - fraction complete to pass the correct valur for updateInteractiveTransition()
            fractionComplete = cardVisible ? fractionComplete : -fractionComplete
            updateInteractiveTransition(fractionCompleted: fractionComplete)
            
        case .ended :
            continueInteractiveTransition()
            
        default:
            break
        }
    }
}

//MARK:- Animation Methods
extension ItenaryVC {
    
    /// Real animation part, being call when every time animation needed or to check if animation need
    func animateTranstionIfNeeded(state : CardState, duration : TimeInterval) {
  
        if runningAnimations.isEmpty {
            // Animate the transition
            /// Create frame animator, with animation block closure
            let frameAnimator = UIViewPropertyAnimator(duration: duration, dampingRatio: 1) {
                switch state {
                case .expanded :
                   
                    self.cardVC.view.frame.origin.y = self.view.frame.height - self.cardHeight
                case .collapsed :
                    self.cardVC.view.frame.origin.y = self.view.frame.height - self.cardHandleAreaHeight
                }
            }
            
            frameAnimator.addCompletion { _ in
                self.cardVisible = !self.cardVisible
                self.runningAnimations.removeAll()
            }

            frameAnimator.startAnimation()
            runningAnimations.append(frameAnimator)
            
            /// Add cornerRadius animator
            let cornerRadiusAnimator = UIViewPropertyAnimator(duration: duration, curve: .linear) {
                switch state {
                case .expanded :
                    self.cardVC.view.layer.cornerRadius = 10
                case .collapsed:
                    self.cardVC.view.layer.cornerRadius = 0
                }
            }
            
      
            cornerRadiusAnimator.startAnimation()
            runningAnimations.append(cornerRadiusAnimator)
            
            /// Add blur animator
            let blurAnimator = UIViewPropertyAnimator(duration: duration, dampingRatio: 1) {
                switch state {
                case .expanded :
                    // Add the blur effect
                    self.visualEffectView.effect = UIBlurEffect(style: .systemThinMaterialDark)
                    self.visualEffectView.alpha = 0.5
                case .collapsed:
                    self.visualEffectView.effect = nil
                }
            }

            blurAnimator.startAnimation()
            runningAnimations.append(blurAnimator)
            
        }
    }
    
    // Define transition function
    /// Check if we have running animations
    func startInteractiveTransition(state : CardState , duration : TimeInterval) {
        if runningAnimations.isEmpty {
            animateTranstionIfNeeded(state: state, duration: duration)
        }
        
        // Looping all animation to perform from runningAnimation array
        for animator in runningAnimations {
            // Pause the animation, set the animation speed to 0, to make interactive possible
            animator.pauseAnimation()
            // Set the property with animator with percentage of animation
            animationProgressWhenInterupted = animator.fractionComplete
        }
        
    }
    
    /// Update all animator to make the animation in the same state when removing finger across screen
    func updateInteractiveTransition (fractionCompleted : CGFloat) {
        // Update fractionComplete of actual animation of all the animations
        for animator in runningAnimations {
            // Use each animator to set the fraction completed property with fraction complete have in paremeters
            animator.fractionComplete = fractionCompleted + animationProgressWhenInterupted
            
        }
    }
    
    func continueInteractiveTransition () {
        // Iterate all animation in  runningAnimation array
        for animator in runningAnimations {
            // Use each animator to continue animations, allow to use the remaining time left in animation set in handler
            animator.continueAnimation(withTimingParameters: nil, durationFactor: 0)
        }
    }
}
