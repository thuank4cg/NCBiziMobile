//
//  NCBQRFirstTypeAnimatedTransferViewController.swift
//  NCBApp
//
//  Created by Lê Sơn on 6/10/19.
//  Copyright © 2019 tvo. All rights reserved.
//

import UIKit

class NCBQRFirstTypeAnimatedTransferViewController: NCBBaseViewController {

    // MARK: - Outlets
    @IBOutlet weak var sourceAccountLbl: UILabel! {
        didSet {
            sourceAccountLbl.text = "Tài khoản nguồn"
            sourceAccountLbl.font = regularFont(size: 15.0)
        }
    }
    @IBOutlet weak var sourceAccountTxtF: NCBCommonTextField!
    @IBOutlet weak var accountNameLbl: UILabel! {
        didSet {
            accountNameLbl.text = "Tên tài khoản"
            accountNameLbl.font = regularFont(size: 15.0)
        }
    }
    @IBOutlet weak var accountNameDetailLbl: UILabel!
    
    @IBOutlet weak var amountLbl: UILabel! {
        didSet {
            amountLbl.text = "Số dư"
            amountLbl.font = regularFont(size: 15.0)
        }
    }
    
    @IBOutlet weak var amountDetailLbl: UILabel!
    
    @IBOutlet weak var dealInfoHeaderLbl: UILabel! {
        didSet {
            dealInfoHeaderLbl.text = "THÔNG TIN ĐƠN HÀNG"
            dealInfoHeaderLbl.font = regularFont(size: 15.0)
        }
    }
    
    @IBOutlet weak var destinationAcountLbl: UILabel! {
        didSet {
            destinationAcountLbl.text = "Thanh toán cho"
            destinationAcountLbl.font = regularFont(size: 15.0)
        }
    }
    
    @IBOutlet weak var destinationAccountDetailLbl: UILabel!
    
    @IBOutlet weak var sellerCodeLbl: UILabel! {
        didSet {
            sellerCodeLbl.text = "Mã điểm bán"
            sellerCodeLbl.font = regularFont(size: 15.0)
        }
    }
    
    @IBOutlet weak var sellerCodeDetailLbl: UILabel!
    
    @IBOutlet weak var sellerLbl: UILabel! {
        didSet {
            sellerLbl.text = "Điểm bán"
            sellerLbl.font = regularFont(size: 15.0)
        }
    }
    
    @IBOutlet weak var sellerDetailLbl: UILabel!
    
    @IBOutlet weak var dealCodeLbl: UILabel! {
        didSet {
            sourceAccountLbl.text = "Tài khoản nguồn"
            sourceAccountLbl.font = regularFont(size: 15.0)
        }
    }
    
    @IBOutlet weak var dealCodeDetailLbl: UILabel!
    
    @IBOutlet weak var redeempCodeTxtF: NCBCommonTextField! {
        didSet {
            sourceAccountLbl.text = "Tài khoản nguồn"
            sourceAccountLbl.font = regularFont(size: 15.0)
        }
    }
    
    @IBOutlet weak var contentTxtV: NCBCommonTextView! {
        didSet {
            contentTxtV.placeholderString = "Nội dung"
        }
    }
    
    @IBOutlet weak var confirmBtn: NCBCommonButton! {
        didSet {
            confirmBtn.setTitle("TIẾP TỤC", for: .normal)
        }
    }
    
    // MARK: - Variables
    var qrFirstTypeModel: NCBQRCodeFirstTypeAnimatedScanModel? {
        didSet {
            setData()
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
    
    func setData() {
        if let _qrFirstTypeModel = qrFirstTypeModel {
            destinationAccountDetailLbl.text = _qrFirstTypeModel.merchantName
            sellerCodeDetailLbl.text = _qrFirstTypeModel.merchantCode
            sellerDetailLbl.text = _qrFirstTypeModel.TID
            amountDetailLbl.text = _qrFirstTypeModel.amount
            dealCodeDetailLbl.text = _qrFirstTypeModel.dealCode
        }
    }
    
}
