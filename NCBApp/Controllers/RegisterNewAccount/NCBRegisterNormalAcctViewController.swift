//
//  NCBRegisterNormalAcctViewController.swift
//  NCBApp
//
//  Created by ADMIN on 8/14/19.
//  Copyright © 2019 tvo. All rights reserved.
//

import Foundation
protocol NCBRegisterNormalAcctViewControllerDelegate {
    func faceId()
    func optConfirm()
    func close()
}

class NCBRegisterNormalAcctViewController: NCBBaseViewController {
    var delegate: NCBRegisterNormalAcctViewControllerDelegate?
    
    // MARK: - Outlets
    
    @IBOutlet weak var titleLbl: UILabel! {
        didSet {
            titleLbl.text = "Xác nhận mở thẻ"
            titleLbl.font = semiboldFont(size: 14.0)
        }
    }
    
    @IBOutlet weak var lineView: UIView! {
        didSet {
            
        }
    }
    
    @IBOutlet weak var faceIdView: UIView! {
        didSet {
            let gesture = UITapGestureRecognizer(target: self, action:  #selector(self.faceId))
            faceIdView.addGestureRecognizer(gesture)
        }
    }
    
    @IBOutlet weak var describeLbl: UILabel! {
        didSet {
            describeLbl.font = regularFont(size: 14.0)
            
        }
    }
    
    @IBOutlet weak var closeBtn: UIButton! {
        didSet {
        }
    }
    
    @IBOutlet weak var optConfirmBtn: NCBCommonButton! {
        didSet {
            optConfirmBtn.setTitle("Xác thực OTP", for: .normal)
        }
    }
    
    @IBOutlet weak var faceIdTitleLbl: UILabel! {
        didSet {
            faceIdTitleLbl.text = "Xác thực bằng FaceID"
            faceIdTitleLbl.font =  regularFont(size: 12.0)
        }
    }
    @IBOutlet weak var faceImg: UIImageView! {
        didSet {
            
        }
    }
    
    // MARK: - Func
    @IBAction func optConfirm(_ sender: Any) {
        delegate?.optConfirm()
    }
    
    @IBAction func close(_ sender: Any) {
        delegate?.close()
    }
    
    @objc func faceId(sender : UITapGestureRecognizer) {
        delegate?.faceId()
    }
    
    
    
    func drawGradient (_ container: UIView!,fristColor:UIColor!,secondColor:UIColor!, horizontal: Bool){
        let gradient: CAGradientLayer = CAGradientLayer()
        gradient.colors = [fristColor.cgColor, secondColor.cgColor]
        if (horizontal  == true) {
            // Hoizontal - commenting these two lines will make the gradient veritcal
            gradient.startPoint = CGPoint(x: 0.0, y: 1.0)
            gradient.endPoint = CGPoint(x: 1.0, y: 1.0)
        }
        // gradient.locations = [0.0 , 1.0]
        gradient.frame = CGRect(x: 0.0, y: 0.0, width: container.frame.size.width, height: container.frame.size.height)
        container.layer.insertSublayer(gradient, at: 0)
        
    }
    
    // MARK: - Properties
    
    var product:NCBRegisterNewServiceProductModel!
    var presenter: NCBRegisterNewAcctPresenter?
    fileprivate let touchMe = BiometricIDAuth()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }
    
    func setupData(data:NCBRegisterNewServiceProductModel) {
        product = data
    }
    
}

extension NCBRegisterNormalAcctViewController {
    override func setupView() {
        super.setupView()
        let nameProduct = product.name ?? ""
        describeLbl.text = "Quý khách đang yêu cầu mở "+nameProduct
        
        switch touchMe.biometricType() {
        case .faceID:
            faceIdTitleLbl.text = "Xác thực bằng FaceID"
            faceImg.image =  R.image.ic_faceid()?.withRenderingMode(.alwaysTemplate)
        default:
            faceIdTitleLbl.text = "Xác thực bằng vân tay"
            faceImg.image =  R.image.ic_touchid()?.withRenderingMode(.alwaysTemplate)
        }
        faceImg.tintColor = UIColor(hexString:"0064E1")
    }
    
    override func loadLocalized() {
        super.loadLocalized()
    }
    
    
}
