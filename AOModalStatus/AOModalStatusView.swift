//
//  AOModalStatusView.swift
//  AOModalStatus
//
//  Created by Hiem Seyha on 12/2/17.
//  Copyright © 2017 Hiem Seyha. All rights reserved.
//

import UIKit

public class PopUpInfo: UIView {

    @IBOutlet weak var statusImage: UIImageView!
    @IBOutlet weak var headLineLabel: UILabel!
    @IBOutlet weak var subheadlabel: UILabel!
    
    
    let nibName = "AOModalStatusView"
    var contentView: UIView!
    
    var timer: Timer?
    
    
    public override func didMoveToSuperview() {

        self.contentView.transform = CGAffineTransform(scaleX: 0.5, y: 0.5)
        
        CustomizeAnimation(implementation: {
            self.contentView.alpha = 1
            self.contentView.transform = CGAffineTransform.identity
        }, completion: {})
       
    }
    
    private func CustomizeAnimation(implementation: @escaping ()->() , completion: @escaping () ->()) {
        
        UIView.animate(withDuration: 0.15, animations: {
            
            implementation()
            
        }) { _ in
            
            self.timer = Timer.scheduledTimer(
                timeInterval: TimeInterval(3.0),
                target: self,
                selector: #selector(self.removeSelf),
                userInfo: nil,
                repeats: false)
            
           completion()
        }
    }
    
    public override func layoutSubviews() {
        self.layoutIfNeeded()
        self.contentView.layer.masksToBounds = true
        self.contentView.clipsToBounds = true
        self.contentView.layer.cornerRadius = 10
    }
    
    @objc func removeSelf() {
        
        UIView.animate(withDuration: 0.15, animations: {
            
            self.contentView.transform = CGAffineTransform(scaleX: 0.5, y: 0.5)
            self.contentView.alpha = 0
            
        }) { _  in
            
            self.removeFromSuperview()
        }
        
        
    }
    
    override public init(frame: CGRect) {
        super.init(frame: frame)
        
        setupView()
    }
    
    required public init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        setupView()
    }
    
    public func set(with image: UIImage) {
        self.statusImage.image = image
    }
    
    public func set(headline text: String) {
        self.headLineLabel.text = text
    }
    
    public func set(subheading text: String) {
        self.subheadlabel.text = text
    }
    
    func setupView() {
        let bundle = Bundle(for: type(of: self))
        let nib = UINib(nibName: nibName, bundle: bundle)
        self.contentView = nib.instantiate(withOwner: self, options: nil).first as! UIView
        addSubview(contentView)
        
        contentView.center = self.center
        contentView.autoresizingMask = []
        contentView.translatesAutoresizingMaskIntoConstraints = true
        
        headLineLabel.text = ""
        subheadlabel.text = ""
    }
}
