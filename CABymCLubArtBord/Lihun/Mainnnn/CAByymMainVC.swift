//
//  CAByymMainVC.swift
//  CABymCLubArtBord
//
//  Created by JOJO on 2021/6/23.
//

import UIKit
import NoticeObserveKit
import Photos

class CAByymMainVC: UIViewController {
    private var pool = Notice.ObserverPool()
    let topCoinLabel = UILabel()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        setupVie()
        
        showLoginVC()
        
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        topCoinLabel.text = "\(CAymBCartCoinManager.default.coinCount)"
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        topCoinLabel.text = "\(CAymBCartCoinManager.default.coinCount)"
    }
    
    func showLoginVC() {
           if LoginMNG.currentLoginUser() == nil {
            let loginVC = LoginMNG.shared.obtainVC()
            loginVC.modalTransitionStyle = .crossDissolve
            loginVC.modalPresentationStyle = .fullScreen
            
            self.present(loginVC, animated: true) {
            }
        }
    }

    func setupVie() {
        view.backgroundColor = UIColor(hexString: "#E0F1FF")
        view.clipsToBounds = true
        
        let settingBtn = UIButton(type: .custom)
        view.addSubview(settingBtn)
        settingBtn.setImage(UIImage(named: "home_ic_setting"), for: .normal)
        settingBtn.snp.makeConstraints {
            $0.left.equalTo(10)
            $0.width.height.equalTo(44)
            $0.top.equalTo(view.safeAreaLayoutGuide.snp.top).offset(10)
        }
        settingBtn.addTarget(self, action: #selector(settingBtnClick(sender:)), for: .touchUpInside)
        
        //
        let coinImageV = UIImageView()
        coinImageV.image = UIImage(named: "ic_store")
        coinImageV.contentMode = .scaleAspectFit
        view.addSubview(coinImageV)
        coinImageV.snp.makeConstraints {
            $0.centerY.equalTo(settingBtn)
            $0.right.equalTo(-18)
            $0.width.equalTo(76/2)
            $0.height.equalTo(80/2)
        }
        //
        topCoinLabel.textAlignment = .right
        topCoinLabel.text = "\(CAymBCartCoinManager.default.coinCount)"
        topCoinLabel.textColor = UIColor(hexString: "#292929")
        topCoinLabel.font = UIFont(name: "Poppins-Bold", size: 18)
        view.addSubview(topCoinLabel)
        topCoinLabel.snp.makeConstraints {
            $0.centerY.equalTo(settingBtn)
            $0.right.equalTo(coinImageV.snp.left).offset(-10)
            $0.height.greaterThanOrEqualTo(35)
            $0.width.greaterThanOrEqualTo(25)
        }
        //
        let coinBtn = UIButton(type: .custom)
        view.addSubview(coinBtn)
        coinBtn.setImage(UIImage(named: ""), for: .normal)
        coinBtn.snp.makeConstraints {
            $0.left.equalTo(topCoinLabel)
            $0.right.top.bottom.equalTo(coinImageV)
        }
        coinBtn.addTarget(self, action: #selector(coinBtnClick(sender:)), for: .touchUpInside)
        
        //
        let createNowBtn = UIButton(type: .custom)
        view.addSubview(createNowBtn)
        createNowBtn.addTarget(self, action: #selector(createNowBtnClick(sender:)), for: .touchUpInside)
        createNowBtn.setBackgroundImage(UIImage(named: "button_download"), for: .normal)
        createNowBtn.setTitle("Create Now", for: .normal)
        createNowBtn.titleEdgeInsets = UIEdgeInsets(top: -3, left: 0, bottom: 0, right: 0)
        createNowBtn.titleLabel?.font = UIFont(name: "Poppins-Bold", size: 22)
        createNowBtn.snp.makeConstraints {
            $0.centerX.equalToSuperview()
            $0.width.equalTo(366)
            $0.height.equalTo(84)
            $0.bottom.equalTo(view.safeAreaLayoutGuide.snp.bottom).offset(-10)
        }
        //
        let contentImgV = UIImageView(image: UIImage(named: "home_img"))
        contentImgV.contentMode = .scaleAspectFit
        view.addSubview(contentImgV)
        contentImgV.snp.makeConstraints {
            $0.top.equalTo(settingBtn.snp.bottom).offset(18)
            $0.left.equalTo(12)
            $0.right.equalTo(-12)
            $0.bottom.equalTo(createNowBtn.snp.top).offset(-24)
        }
        
    }
    
    
    
    @objc func settingBtnClick(sender: UIButton) {
        self.navigationController?.pushViewController(CASeTTingVC())
    }
    @objc func coinBtnClick(sender: UIButton) {
        self.navigationController?.pushViewController(CAStoREViewC())
    }
    @objc func createNowBtnClick(sender: UIButton) {
        checkAlbumAuthorization()
        
    }
    

}

extension CAByymMainVC: UIImagePickerControllerDelegate {
    
    func checkAlbumAuthorization() {
        
        if UIImagePickerController.isSourceTypeAvailable(.photoLibrary) {
            PHPhotoLibrary.requestAuthorization(for: .readWrite) { status in
                switch status {
                case .authorized:
                    DispatchQueue.main.async {
                        self.showNextEdit()
                    }
                case .limited:
                    DispatchQueue.main.async {
                        self.showNextEdit()
                    }
                case .notDetermined:
                    if status == PHAuthorizationStatus.authorized {
                        DispatchQueue.main.async {
                            self.showNextEdit()
                        }
                    } else if status == PHAuthorizationStatus.limited {
                        DispatchQueue.main.async {
                            self.showNextEdit() 
                        }
                    }
                case .denied:
                    DispatchQueue.main.async {
                        [weak self] in
                        guard let `self` = self else {return}
                        let alert = UIAlertController(title: "Oops", message: "You have declined access to photos, please active it in Settings>Privacy>Photos.", preferredStyle: .alert)
                        let confirmAction = UIAlertAction(title: "Ok", style: .default, handler: { (goSettingAction) in
                            DispatchQueue.main.async {
                                let url = URL(string: UIApplication.openSettingsURLString)!
                                UIApplication.shared.open(url, options: [:])
                            }
                        })
                        let cancelAction = UIAlertAction(title: "Cancel", style: .cancel)
                        alert.addAction(confirmAction)
                        alert.addAction(cancelAction)
                        
                        self.present(alert, animated: true)
                    }
                    
                case .restricted:
                    DispatchQueue.main.async {
                        [weak self] in
                        guard let `self` = self else {return}
                        let alert = UIAlertController(title: "Oops", message: "You have declined access to photos, please active it in Settings>Privacy>Photos.", preferredStyle: .alert)
                        let confirmAction = UIAlertAction(title: "Ok", style: .default, handler: { (goSettingAction) in
                            DispatchQueue.main.async {
                                let url = URL(string: UIApplication.openSettingsURLString)!
                                UIApplication.shared.open(url, options: [:])
                            }
                        })
                        let cancelAction = UIAlertAction(title: "Cancel", style: .cancel)
                        alert.addAction(confirmAction)
                        alert.addAction(cancelAction)
                        
                        self.present(alert, animated: true)
                    }
                default: break
                }
            }
        }
    }
     
    func showNextEdit() {
        self.navigationController?.pushViewController(CAByymEDitVC())
    }
    
}
