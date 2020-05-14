//
//  NCBUnregisterAutoDebtDeductionViewController.swift
//  NCBApp
//
//  Created by Thuan on 8/14/19.
//  Copyright © 2019 tvo. All rights reserved.
//

import Foundation

class NCBUnregisterAutoDebtDeductionViewController: NCBBaseVerifyTransactionViewController {
    
    //MARK: Properties
    
    var card: NCBCardModel?
    fileprivate var isOTP = true
    fileprivate var msgId = ""
    fileprivate var otpVC = R.storyboard.bottomSheet.ncbotpViewController()!
    fileprivate var p: NCBVerifyRegisterAutoDebtDeductionPresenter?
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
}

extension NCBUnregisterAutoDebtDeductionViewController {
    
    override func setupView() {
        super.setupView()
        
        commonCreditCardInfoView?.setData(card)
        
        if let vc = R.storyboard.onlinePayment.ncbOnlinePaymentVerifyViewController() {
            vc.delegate = self
            vc.setViewForAutoDebtDeduction(title: "Xác nhận", desc: "Quý khách đang yêu cầu huỷ dịch vụ trích nợ tự động thẻ NCB Visa \((card?.cardno ?? "").cardHidden).")
            showBottomSheet(controller: vc, size: 315, disablePanGesture: true)
        }
        
        p = NCBVerifyRegisterAutoDebtDeductionPresenter()
        p?.delegate = self
    }
    
    override func loadLocalized() {
        super.loadLocalized()
        
        setHeaderTitle("Huỷ dịch vụ trích nợ tự động")
    }
    
}

extension NCBUnregisterAutoDebtDeductionViewController {
    
    fileprivate func showOTP() {
        showBottomSheet(controller: otpVC, size: NumberConstant.otpViewHeight, disablePanGesture: true)
        otpVC.delegate = self
    }
    
    fileprivate func showSuccessScreen() {
        if let vc = R.storyboard.onlinePayment.ncbCardCompletedServiceViewController() {
            vc.setData(card, type: .unregisterAutoDebtDeduction)
            self.navigationController?.pushViewController(vc, animated: true)
        }
    }
    
    fileprivate func doConfirm() {
        guard let card = card else {
            return
        }
        
        var params: [String: Any] = [:]
        params["userId"] = NCBShareManager.shared.getUserID()
        params["cifNo"] = NCBShareManager.shared.getUser()?.cif ?? ""
        params["cardNo"] = card.cardno ?? ""
        params["acctNo"] = card.autoDebitBankacct ?? ""
        params["autoDebit"] = "NO"
        params["repayMode"] = card.repayMode ?? ""
        params["serviceCode"] = AutoDebtActionType.CANCEL.rawValue
        params["lang"] = TransactionLangType.VI.rawValue
        if !isOTP {
            params["confirmType"] = getConfirmType()
            params["confirmValue"] = NCBKeychainService.loadTransactionTouchID()
        } else {
            params["confirmType"] = TransactionConfirmType.OTP.rawValue
            params["confirmValue"] = ""
        }
        
        SVProgressHUD.show()
        p?.doConfirm(params: params)
    }
    
    fileprivate func doApproval(_ otp: String) {
        guard let card = card else {
            return
        }
        
        var params: [String: Any] = [:]
        params["userId"] = NCBShareManager.shared.getUserID()
        params["cifNo"] = NCBShareManager.shared.getUser()?.cif ?? ""
        params["cardNo"] = card.cardno ?? ""
        params["acctNo"] = card.autoDebitBankacct ?? ""
        params["autoDebit"] = "NO"
        params["repayMode"] = card.repayMode ?? ""
        params["serviceCode"] = AutoDebtActionType.CANCEL.rawValue
        params["lang"] = TransactionLangType.VI.rawValue
        params["confirmType"] = TransactionConfirmType.OTP.rawValue
        params["confirmValue"] = otp
        params["msgid"] = msgId
        
        SVProgressHUD.show()
        otpAuthenticate(params: params, type: .autoDebtDeduction)
    }
    
    override func otpAuthenticateSuccessfully() {
        showSuccessScreen()
    }
    
    override func otpAuthenticateFailure() {
        otpVC.clear()
    }
    
}

extension NCBUnregisterAutoDebtDeductionViewController: NCBOTPViewControllerDelegate {
    
    func otpDidSelectAccept(_ otp: String) {
        doApproval(otp)
    }
    
    func otpDidSelectResend() {
//        otpResend(msgId: msgId)
        let params: [String: Any] = [
            "cif": NCBShareManager.shared.getUser()?.cif ?? "",
            "userId": NCBShareManager.shared.getUserID(),
            "cardNo": card?.cardno ?? "",
            "acctNo": card?.autoDebitBankacct ?? "",
            "serviceCode": AutoDebtActionType.CANCEL.rawValue
        ]
        otpResend(msgId: msgId, params: params, type: .autoDebtDeduction)
    }
    
}

extension NCBUnregisterAutoDebtDeductionViewController: NCBOnlinePaymentVerifyViewControllerDelegate {
    
    func onlinePaymentVerifyOTP() {
        isOTP = true
        doConfirm()
    }
    
    func onlinePaymentVerifyTouchID(_ touchMe: BiometricIDAuth) {
        isOTP = false
//        if !isOpenTransactionTouchID {
//            showAlert(msg: "Vui lòng kích hoạt xác nhận giao dịch bằng \(touchMe.biometricSuffix) tại phần cài đặt trong ứng dụng")
//            return
//        }
        
        if !checkBioAvailable(touchMe, isOpen: isOpenTransactionTouchID) {
            return
        }
        
        touchMe.evaluate { [weak self] (error, msg) in
            if error == biometricSuccessCode {
                self?.doConfirm()
            } else {
                if let msg = msg {
                    self?.showAlert(msg: msg)
                }
            }
        }
    }
    
    func onlinePaymentCancel() {
        self.navigationController?.popViewController(animated: true)
    }
    
}

extension NCBUnregisterAutoDebtDeductionViewController: NCBVerifyRegisterAutoDebtDeductionPresenterDelegate {
    
    func confirmCompleted(msgId: String?, error: String?) {
        SVProgressHUD.dismiss()
        
        if let error = error {
            showAlert(msg: error)
            return
        }
        
        self.msgId = msgId ?? ""
        if isOTP {
            showOTP()
            return
        }
        
        showSuccessScreen()
    }
    
}

