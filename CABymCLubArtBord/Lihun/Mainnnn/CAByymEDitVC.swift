//
//  CAByymEDitVC.swift
//  CABymCLubArtBord
//
//  Created by JOJO on 2021/6/24.
//

import UIKit
import NoticeObserveKit
import Photos
import YPImagePicker
import DeviceKit


class CAByymEDitVC: UIViewController, UINavigationControllerDelegate {
    private var pool = Notice.ObserverPool()

    let backBtn = UIButton(type: .custom)
    let topCoinLabel = UILabel()
    
    let canvasBgView = UIView()
    let selectPhotoBtn = UIButton(type: .custom)
    let canvasBgImgV = UIImageView()
    let canvasPhotoImgV = UIImageView()
    let canvasBorderImgV = UIImageView()
    let canvasStickerImgV = UIImageView()
    let canvasTickImgV = UIImageView()
    let downloadBtn = UIButton(type: .custom)
    
    let tickBtn = UIButton(type: .custom)
    let stickerBtn = UIButton(type: .custom)
    let bgColorBorderBtn = UIButton(type: .custom)
    
    let bgBorderBar = TOolBGcolorAndBorderView()
    let stickerBar = TOolSTcikerEmojiView()
    let blueTickBar = TOolBlueTickView()
    let coinAlertView = CABymCoinAlertView()
    
    
    var borderWidthBili: CGFloat = 0
    var cornerBili: CGFloat = 0
    
    var isShowEmoji: Bool = false
    var isShowBlueTick: Bool = false
    var isVipBgColor: Bool = false
    var isVipBorder: Bool = false
    var isVipSticker: Bool = false
    var shouldCostCoin: Bool = false
    override func viewDidLoad() {
        super.viewDidLoad()
        setupView()
        setupContentView()
        setupCoinAlertView() 
        addNotificationObserver()
        
        setupDefaultStatus()
    }
    
    func addNotificationObserver() {
        NotificationCenter.default.nok.observe(name: .pi_noti_coinChange) {[weak self] _ in
            guard let `self` = self else {return}
            DispatchQueue.main.async {
                self.topCoinLabel.text = "\(CAymBCartCoinManager.default.coinCount)"
            }
        }
        .invalidated(by: pool)
    }
    
    func setupView() {
        view.backgroundColor = UIColor(hexString: "#E0F1FF")
        view.clipsToBounds = true
        
        //
        view.addSubview(backBtn)
        backBtn.addTarget(self, action: #selector(backBtnClick(sender:)), for: .touchUpInside)
        backBtn.setImage(UIImage(named: "ic_back"), for: .normal)
        backBtn.snp.makeConstraints {
            $0.top.equalTo(view.safeAreaLayoutGuide.snp.top).offset(5)
            $0.left.equalTo(10)
            $0.width.height.equalTo(44)
        }
        //
        let coinImageV = UIImageView()
        coinImageV.image = UIImage(named: "ic_store")
        coinImageV.contentMode = .scaleAspectFit
        view.addSubview(coinImageV)
        coinImageV.snp.makeConstraints {
            $0.centerY.equalTo(backBtn)
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
            $0.centerY.equalTo(backBtn)
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
        
        
    }
    
    func setupContentView() {
        let contentBgView = UIView()
        contentBgView.backgroundColor = .clear
        view.addSubview(contentBgView)
        contentBgView.snp.makeConstraints {
            $0.top.equalTo(backBtn.snp.bottom).offset(5)
            $0.left.right.equalToSuperview()
            $0.bottom.equalTo(view.safeAreaLayoutGuide.snp.bottom).offset(-390)
        }
        //
        var leftOffset: CGFloat = 20
        
        if Device.current.diagonal == 4.7 || Device.current.diagonal > 7 {
            leftOffset = 38
        }
        let canvasBgWidth: CGFloat = UIScreen.main.bounds.width - (leftOffset * 2) - 66 - 24
        canvasBgView.backgroundColor = UIColor.clear
        contentBgView.addSubview(canvasBgView)
        canvasBgView.snp.makeConstraints {
            $0.width.height.equalTo(canvasBgWidth)
            $0.centerY.equalTo(contentBgView)
            $0.left.equalTo(leftOffset)
        }
        
        //
        
        canvasBgImgV.frame = CGRect(x: 0, y: 0, width: canvasBgWidth, height: canvasBgWidth)
        canvasBgImgV.clipsToBounds = true
        canvasBgImgV.backgroundColor = .white
        canvasBgImgV.contentMode = .scaleAspectFill
        canvasBgView.addSubview(canvasBgImgV)
        //
        selectPhotoBtn.setImage(UIImage(named: "ic_select"), for: .normal)
        selectPhotoBtn.backgroundColor = .clear
        selectPhotoBtn.clipsToBounds = true
        canvasBgView.addSubview(selectPhotoBtn)
        selectPhotoBtn.snp.makeConstraints {
            $0.center.equalToSuperview()
            $0.left.top.equalToSuperview()
        }
        selectPhotoBtn.addTarget(self, action: #selector(selectPhotoBtnClick(sender:)), for: .touchUpInside)
        //
        
        canvasPhotoImgV.frame = CGRect(x: 0, y: 0, width: canvasBgWidth, height: canvasBgWidth)
        canvasPhotoImgV.clipsToBounds = true
        canvasBgView.addSubview(canvasPhotoImgV)
        canvasPhotoImgV.contentMode = .scaleAspectFill
        
        //
        
        canvasBorderImgV.frame = CGRect(x: 0, y: 0, width: canvasBgWidth, height: canvasBgWidth)
        canvasBorderImgV.clipsToBounds = true
        canvasBgView.addSubview(canvasBorderImgV)
        canvasBorderImgV.contentMode = .scaleAspectFill
        
        //
        
        canvasStickerImgV.frame = CGRect(x: 0, y: canvasBgWidth * (2.0/3.0), width: canvasBgWidth/3, height: canvasBgWidth/3)
        canvasStickerImgV.clipsToBounds = true
        canvasBgView.addSubview(canvasStickerImgV)
        canvasStickerImgV.contentMode = .scaleAspectFit
        //
        let tickPadding: CGFloat = 10
        
        canvasTickImgV.frame = CGRect(x: canvasBgWidth - 31 - tickPadding, y: tickPadding, width: 31, height: 31)
        canvasTickImgV.clipsToBounds = true
        canvasBgView.addSubview(canvasTickImgV)
        canvasTickImgV.contentMode = .scaleAspectFit
        //

        contentBgView.addSubview(bgColorBorderBtn)
        bgColorBorderBtn.snp.makeConstraints {
            $0.top.equalTo(canvasBgView)
            $0.left.equalTo(canvasBgView.snp.right).offset(24)
            $0.width.height.equalTo(66)
        }
        bgColorBorderBtn.setImage(UIImage(named: "ic_background_unselect"), for: .normal)
        bgColorBorderBtn.setImage(UIImage(named: "ic_background_select"), for: .selected)
        bgColorBorderBtn.addTarget(self, action: #selector(bgColorBorderBtnClick(sender:)), for: .touchUpInside)
        //

        contentBgView.addSubview(stickerBtn)
        stickerBtn.snp.makeConstraints {
            $0.centerY.equalTo(canvasBgView)
            $0.left.equalTo(canvasBgView.snp.right).offset(24)
            $0.width.height.equalTo(66)
        }
        stickerBtn.setImage(UIImage(named: "ic_emoji_unselect"), for: .normal)
        stickerBtn.setImage(UIImage(named: "ic_emoji_select"), for: .selected)
        stickerBtn.addTarget(self, action: #selector(stickerBtnClick(sender:)), for: .touchUpInside)
        
        
        //
        
        contentBgView.addSubview(tickBtn)
        tickBtn.snp.makeConstraints {
            $0.bottom.equalTo(canvasBgView)
            $0.left.equalTo(canvasBgView.snp.right).offset(24)
            $0.width.height.equalTo(66)
        }
        tickBtn.setImage(UIImage(named: "ic_bluetick_unselect"), for: .normal)
        tickBtn.setImage(UIImage(named: "ic_bluetick_select"), for: .selected)
        tickBtn.addTarget(self, action: #selector(tickBtnClick(sender:)), for: .touchUpInside)
        
        
        view.addSubview(downloadBtn)
        downloadBtn.titleEdgeInsets = UIEdgeInsets(top: -3, left: 0, bottom: 0, right: 0)
        downloadBtn.addTarget(self, action: #selector(downloadBtnClick(sender:)), for: .touchUpInside)
        downloadBtn.setBackgroundImage(UIImage(named: "button_download"), for: .normal)
        downloadBtn.setTitle("Download", for: .normal)
        downloadBtn.titleLabel?.font = UIFont(name: "Poppins-Bold", size: 22)
        downloadBtn.snp.makeConstraints {
            $0.centerX.equalToSuperview()
            $0.width.equalTo(366)
            $0.height.equalTo(84)
            $0.bottom.equalTo(view.safeAreaLayoutGuide.snp.bottom).offset(-10)
        }
        //
        let toolBgView = UIView()
        view.addSubview(toolBgView)
        toolBgView.backgroundColor = .clear
        toolBgView.snp.makeConstraints {
            $0.left.right.equalToSuperview()
            $0.bottom.equalTo(downloadBtn.snp.top).offset(-5)
            $0.top.equalTo(contentBgView.snp.bottom).offset(5)
        }
        //

        toolBgView.addSubview(bgBorderBar)
        bgBorderBar.snp.makeConstraints {
            $0.left.right.top.bottom.equalToSuperview()
        }
        bgBorderBar.bordderWidthStrengthBlock = {
            [weak self] value in
            guard let `self` = self else {return}
            DispatchQueue.main.async {
                self.updateCanvasBorderWidth(widthBili: value)
            }
        }
        bgBorderBar.cornerStrengthBlock = {
            [weak self] value in
            guard let `self` = self else {return}
            DispatchQueue.main.async {
                self.updateCanvasCorner(cornerBili: value)
            }
        }
        bgBorderBar.bgColorClickBlock = {
            [weak self] item in
            guard let `self` = self else {return}
            DispatchQueue.main.async {
                self.isVipBgColor = item.isPro
                self.updateCanvasBgColor(colorStr: item.bigName)
            }
        }
        bgBorderBar.bgBorderClickBlock = {
            [weak self] item in
            guard let `self` = self else {return}
            DispatchQueue.main.async {
                self.isVipBorder = item.isPro
                self.updateCanvasBorder(imageStr: item.bigName)
            }
        }
        //

        toolBgView.addSubview(stickerBar)
        stickerBar.snp.makeConstraints {
            $0.left.right.top.bottom.equalToSuperview()
        }
        stickerBar.showEmojiClickBlock = {
            [weak self] isShow in
            guard let `self` = self else {return}
            DispatchQueue.main.async {
                self.updateEmojiShowStatus(isShow: isShow)
            }
        }
        stickerBar.stickerClickBlock = {
            [weak self] item in
            guard let `self` = self else {return}
            DispatchQueue.main.async {
                self.isVipSticker = item.isPro
                self.updateSticker(imageStr: item.bigName)
            }
        }
        //
        
        toolBgView.addSubview(blueTickBar)
        blueTickBar.snp.makeConstraints {
            $0.left.right.top.bottom.equalToSuperview()
        }
        blueTickBar.showTickClickBlock = {
            [weak self] isShow in
            guard let `self` = self else {return}
            
            DispatchQueue.main.async {
                self.updateTickShowStatus(isShow: isShow)
            }
        }
    }
    
    func setupCoinAlertView() {
        
        coinAlertView.alpha = 0
        view.addSubview(coinAlertView)
        coinAlertView.snp.makeConstraints {
            $0.left.right.bottom.top.equalToSuperview()
        }
        coinAlertView.okBtnClickBlock = {
            [weak self] in
            guard let `self` = self else {return}
            
            if CAymBCartCoinManager.default.coinCount >= CAymBCartCoinManager.default.coinCostCount {
                DispatchQueue.main.async {
                    self.shouldCostCoin = true
                    self.processingPhotoToSave()
                    
                }
            } else {
                DispatchQueue.main.async {
                    self.showAlert(title: "", message: "Not enough coins, please buy first.", buttonTitles: ["OK"], highlightedButtonIndex: 0) { i in
                        DispatchQueue.main.async {
                            [weak self] in
                            guard let `self` = self else {return}
                            self.navigationController?.pushViewController(CAStoREViewC())
                        }
                    }
                }
            }
            UIView.animate(withDuration: 0.25) {
                self.coinAlertView.alpha = 0
            }
        }
        coinAlertView.cancelBtnClickBlock = {
            [weak self] in
            guard let `self` = self else {return}
            UIView.animate(withDuration: 0.25) {
                self.coinAlertView.alpha = 0
            }
        }
    }
    
    func setupDefaultStatus() {
//        canvasBgImgV.image = UIImage(named: "border_1")
//        canvasPhotoImgV.image = UIImage(named: "login_background")
//        canvasBorderImgV.image = UIImage(named: "border_15")
//        canvasStickerImgV.image = UIImage(named: "emoji_1")
        canvasTickImgV.image = UIImage(named: "ic_bluetick")
        
        
        bgColorBorderBtnClick(sender: bgColorBorderBtn)
        updateCanvasBorderWidth(widthBili: 0.3)
        bgBorderBar.bordderWidthSlider.value = 0.3
        updateCanvasCorner(cornerBili: 0.3)
        bgBorderBar.cornerSlider.value = 0.3
        updateTickShowStatus(isShow: false)
        blueTickBar.emojiSwitch.isOn = false
        stickerBar.emojiSwitch.isOn = false
        updateEmojiShowStatus(isShow: false)
        canvasStickerImgV.image = UIImage(named: "emoji_1")
    }
    
}

extension CAByymEDitVC {
    @objc func backBtnClick(sender: UIButton) {
        if self.navigationController != nil {
            self.navigationController?.popViewController()
        } else {
            self.dismiss(animated: true, completion: nil)
        }
    }
    @objc func downloadBtnClick(sender: UIButton) {
        downloadAction()
    }
    @objc func coinBtnClick(sender: UIButton) {
        self.navigationController?.pushViewController(CAStoREViewC())
    }
    @objc func selectPhotoBtnClick(sender: UIButton) {
        checkAlbumAuthorization()
    }
    
    
    @objc func bgColorBorderBtnClick(sender: UIButton) {
        bgColorBorderBtn.isSelected = true
        stickerBtn.isSelected = false
        tickBtn.isSelected = false
        //
        bgBorderBar.isHidden = false
        stickerBar.isHidden = true
        blueTickBar.isHidden = true
    }
    @objc func stickerBtnClick(sender: UIButton) {
        stickerBtn.isSelected = true
        bgColorBorderBtn.isSelected = false
        tickBtn.isSelected = false
        //
        bgBorderBar.isHidden = true
        stickerBar.isHidden = false
        blueTickBar.isHidden = true
    }
    @objc func tickBtnClick(sender: UIButton) {
        tickBtn.isSelected = true
        stickerBtn.isSelected = false
        bgColorBorderBtn.isSelected = false
        //
        bgBorderBar.isHidden = true
        stickerBar.isHidden = true
        blueTickBar.isHidden = false
    }
    
}
extension CAByymEDitVC {
    func updateCanvasPhotoImg(image: UIImage) {
        canvasPhotoImgV.image = image
        bgBorderBar.updateContentStatus(photo: image)
    }
    func updateCanvasBgColor(colorStr: String) {
        if colorStr.contains("#") {
            canvasBgImgV.image = nil
            canvasBgImgV.backgroundColor = UIColor(hexString: colorStr)
        } else {
            canvasBgImgV.image = UIImage(named: colorStr)
        }
    }
    func updateCanvasBorder(imageStr: String) {
        if imageStr == "" {
            canvasBorderImgV.image = nil
        } else {
            canvasBorderImgV.image = UIImage(named: imageStr)
        }
    }
    
    
    
    func updateSticker(imageStr: String) {
        if imageStr == "" {
            canvasStickerImgV.image = nil
        } else {
            canvasStickerImgV.image = UIImage(named: imageStr)
        }
        updateEmojiShowStatus(isShow: true)
        stickerBar.updateSwitchStatus(isOn: true)
    }
    
    func updateCanvasBorderWidth(widthBili: CGFloat) {
        borderWidthBili = widthBili
//        0-0.4
        
        let offset = (canvasBgImgV.bounds.size.width * widthBili) / 2
        let width = canvasBgImgV.bounds.size.width * (1 - widthBili)
        canvasPhotoImgV.frame = CGRect(x: offset, y: offset, width: width, height: width)
        
        selectPhotoBtn.cornerRadius = (canvasBgImgV.bounds.size.width / 2) * cornerBili
        canvasBgImgV.cornerRadius = (canvasBgImgV.bounds.size.width / 2) * cornerBili
        canvasPhotoImgV.cornerRadius = (canvasPhotoImgV.bounds.size.width / 2) * cornerBili
    }
    func updateCanvasCorner(cornerBili: CGFloat) {
        self.cornerBili = cornerBili
        selectPhotoBtn.cornerRadius = (canvasBgImgV.bounds.size.width / 2) * cornerBili
        canvasBgImgV.cornerRadius = (canvasBgImgV.bounds.size.width / 2) * cornerBili
        canvasPhotoImgV.cornerRadius = (canvasPhotoImgV.bounds.size.width / 2) * cornerBili
    }
    func updateEmojiShowStatus(isShow: Bool) {
        isShowEmoji = isShow
        canvasStickerImgV.isHidden = !isShow
    }
    func updateTickShowStatus(isShow: Bool) {
        isShowBlueTick = isShow
        canvasTickImgV.isHidden = !isShow
    }
    
}

extension CAByymEDitVC {
    func downloadAction() {
  
        
        var isVipEmoji = false
        if isShowEmoji && isVipSticker {
            isVipEmoji = true
        }
        if isVipBorder || isVipBgColor || isVipEmoji {
            // show coin alert
            UIView.animate(withDuration: 0.35) {
                self.coinAlertView.alpha = 1
            }
        } else {
            // free
            shouldCostCoin = false
            processingPhotoToSave()
        }
    }
    
    func processingPhotoToSave() {
        selectPhotoBtn.isHidden = true
        if let resultImg = self.canvasBgView.screenshot {
            self.saveToAlbumPhotoAction(images: [resultImg])
            selectPhotoBtn.isHidden = false
        }
    }
}

extension CAByymEDitVC: UIImagePickerControllerDelegate {
    
    func checkAlbumAuthorization() {
        
        if UIImagePickerController.isSourceTypeAvailable(.photoLibrary) {
            PHPhotoLibrary.requestAuthorization(for: .readWrite) { status in
                switch status {
                case .authorized:
                    DispatchQueue.main.async {
                        self.presentPhotoPickerController()
                    }
                case .limited:
                    DispatchQueue.main.async {
                        self.presentLimitedPhotoPickerController()
                    }
                case .notDetermined:
                    if status == PHAuthorizationStatus.authorized {
                        DispatchQueue.main.async {
                            self.presentPhotoPickerController()
                        }
                    } else if status == PHAuthorizationStatus.limited {
                        DispatchQueue.main.async {
                            self.presentLimitedPhotoPickerController()
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
    
    func presentLimitedPhotoPickerController() {
        var config = YPImagePickerConfiguration()
        config.library.maxNumberOfItems = 1
        config.screens = [.library]
        config.library.defaultMultipleSelection = false
        config.library.skipSelectionsGallery = true
        config.showsPhotoFilters = false
        config.library.preselectedItems = nil
        let picker = YPImagePicker(configuration: config)
        picker.didFinishPicking { [unowned picker] items, cancelled in
            var imgs: [UIImage] = []
            for item in items {
                switch item {
                case .photo(let photo):
                    if let img = photo.image.scaled(toWidth: 1200) {
                        imgs.append(img)
                    }
                    print(photo)
                case .video(let video):
                    print(video)
                }
            }
            picker.dismiss(animated: true, completion: nil)
            if !cancelled {
                if let image = imgs.first {
                    self.showEditVC(image: image)
                }
            }
        }
        
        present(picker, animated: true, completion: nil)
    }
    
     
 
    func presentPhotoPickerController() {
        let myPickerController = UIImagePickerController()
        myPickerController.allowsEditing = false
        myPickerController.delegate = self
        myPickerController.sourceType = .photoLibrary
        self.present(myPickerController, animated: true, completion: nil)

    }
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        dismiss(animated: true, completion: nil)
        if let image = info[UIImagePickerController.InfoKey.editedImage] as? UIImage {
            self.showEditVC(image: image)
        } else if let image = info[UIImagePickerController.InfoKey.originalImage] as? UIImage {
            self.showEditVC(image: image)
        }

    }
//
    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        dismiss(animated: true, completion: nil)
    }
    
    func showEditVC(image: UIImage) {
        updateCanvasPhotoImg(image: image)
    }

    
}

extension CAByymEDitVC {
    func saveToAlbumPhotoAction(images: [UIImage]) {
        DispatchQueue.main.async(execute: {
            PHPhotoLibrary.shared().performChanges({
                [weak self] in
                guard let `self` = self else {return}
                for img in images {
                    PHAssetChangeRequest.creationRequestForAsset(from: img)
                }
            }) { (finish, error) in
                if finish {
                    DispatchQueue.main.async {
                        [weak self] in
                        guard let `self` = self else {return}
                        self.showSaveSuccessAlert()
                        if self.shouldCostCoin {
                            CAymBCartCoinManager.default.costCoin(coin: CAymBCartCoinManager.default.coinCostCount)
                        }
                    }
                } else {
                    DispatchQueue.main.async {
                        [weak self] in
                        guard let `self` = self else {return}
                        if error != nil {
                            let auth = PHPhotoLibrary.authorizationStatus()
                            if auth != .authorized {
                                self.showDenideAlert()
                            }
                        }
                    }
                }
            }
        })
    }
    
    func showSaveSuccessAlert() {
        HUD.success("Photo save successful.")
    }
    
    func showDenideAlert() {
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
    }
    
}
