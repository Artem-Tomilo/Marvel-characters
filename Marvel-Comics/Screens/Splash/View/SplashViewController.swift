//
//  SplashViewController.swift
//  Marvel-Comics
//
//  Created by Артем Томило on 7.02.23.
//

import UIKit

class SplashViewController: UIViewController {
    
    var presenter: SplashPresenter?
    private let activityIndicator = ActivityIndicator()
    private let image = UIImageView()
    private let leftTitle = UILabel()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        startingUISettings()
        configureUI()
    }
    
    private func startingUISettings() {
        view.backgroundColor = .white
        view.addSubview(image)
        image.image = UIImage(named: "marvel")
        image.snp.makeConstraints { make in
            make.height.equalTo(150)
            make.centerY.centerX.equalToSuperview()
        }
        image.contentMode = .scaleAspectFit
    }
    
    private func configureUI() {
        DispatchQueue.main.asyncAfter(deadline: .now() + .milliseconds(300)) {
            self.image.snp.removeConstraints()
            self.image.snp.makeConstraints { make in
                make.height.equalTo(150)
                make.centerX.equalToSuperview()
                make.top.equalTo(self.view.snp.bottom)
            }
            self.view.setNeedsLayout()
            UIView.animate(withDuration: 0.5) {
                self.view.layoutIfNeeded()
                self.configureNavigationBar()
            }
        }
    }
    
    private func configureNavigationBar() {
        self.navigationController?.navigationBar.barStyle = .black
        let navBar = self.navigationController?.navigationBar
        navBar?.isTranslucent = false
        navBar?.barTintColor = .red
        
        UIView.animate(withDuration: 0.3) {
            self.leftTitle.font = UIFont(name: "BadaBoomBB", size: 25)
            self.leftTitle.text = "Marvel"
            self.leftTitle.textColor = .white
            self.navigationItem.leftBarButtonItem = UIBarButtonItem(customView: self.leftTitle)
        } completion: {_ in
            DispatchQueue.main.asyncAfter(deadline: .now() + .milliseconds(300)) {
                guard let presenter = self.presenter else { return }
                self.activityIndicator.displayIndicator(view: self.view)
                self.activityIndicator.startAnimating()
                presenter.moveToNextScreen()
            }
        }
    }
}
