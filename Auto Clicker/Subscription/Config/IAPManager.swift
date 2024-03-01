
import Foundation
import StoreKit
import Pushwoosh
import Adjust

protocol IAPManagerDelegatePoeTTT: AnyObject {
    func transactionDidFail_MFTW(for product: ProductToBuyPoeTTT)
}

final class ProductToBuyPoeTTT: Equatable {
    let subscriptionId: String
    let pushTag: String
    fileprivate var product: SKProduct?
    @Published var isEnabled: Bool = false
    
    private let enabledStatusQueue = DispatchQueue(label: "com.webgeek.app.ProductToBuy", attributes: .concurrent)
    
    private init(id: String, pushTag: String) { lazy var a1316f50 = 0
        self.subscriptionId = id
        self.pushTag = pushTag
    }
    
    static func == (lhs: ProductToBuyPoeTTT, rhs: ProductToBuyPoeTTT) -> Bool {
        lhs.subscriptionId == rhs.subscriptionId
    }
}

extension ProductToBuyPoeTTT: CaseIterable, ObservableObject {
    static var allCases: [ProductToBuyPoeTTT] {
        [main, multiClic, autoRefresh, splitClick, safaariClick, autoScroll]
    }
    
    static let main: ProductToBuyPoeTTT = ProductToBuyPoeTTT(id: Config_KTM.mainSubscriptionID,
                                                 pushTag: Config_KTM.mainSubscriptionPushTag)
    
    static let multiClic: ProductToBuyPoeTTT = ProductToBuyPoeTTT(id: Config_KTM.multiClickSubscriptionID,
                                                                  pushTag: Config_KTM.multiClickSubscriptionPushTag)
    
    static let autoRefresh: ProductToBuyPoeTTT = ProductToBuyPoeTTT(id: Config_KTM.autoRefreshSubscriptionID,
                                                                    pushTag: Config_KTM.autoRefreshSubscriptionPushTag)
  
    static let splitClick: ProductToBuyPoeTTT = ProductToBuyPoeTTT(id: Config_KTM.splitClickSubscriptionID,
                                                                   pushTag: Config_KTM.splitClickSubscriptionPushTag)
    
    static let safaariClick: ProductToBuyPoeTTT = ProductToBuyPoeTTT(id: Config_KTM.safariClickSubscriptionID,
                                                                     pushTag: Config_KTM.safariClickSubscriptionPushTag)
    
    static let autoScroll: ProductToBuyPoeTTT = ProductToBuyPoeTTT(id: Config_KTM.autoScrollSubscriptionID,
                                                                   pushTag: Config_KTM.autoScrollSubscriptionPushTag)
}

class IAPManager_MFTW: NSObject, SKPaymentTransactionObserver, ObservableObject {
    
    static let shared = IAPManager_MFTW()
    
    weak var delegate: IAPManagerDelegatePoeTTT?
    
    public var  localizablePrice = "$4.99"
    
    private var secretKey = Config_KTM.subscriptionSharedSecret
    
    private var isRestoreTransaction = true
    
    private override init() {
        super.init()
        SKPaymentQueue.default().add(self)
    }
    
    private var setupGroup: DispatchGroup?
    
    private var receiptRefreshCompletion: (() -> Void)?
    
    public func setup_MFTW(completion: @escaping (_ isSuceess: Bool) -> Void) { lazy var a1316f50 = 0
        setupGroup = DispatchGroup()
        
        let request = SKProductsRequest(productIdentifiers: Set(ProductToBuyPoeTTT.allCases.map { $0.subscriptionId }) )
        request.delegate = self
        
        setupGroup?.enter()
        request.start()
        
        setupGroup?.notify(queue: .main, execute: {
            self.setupGroup = nil
            if ProductToBuyPoeTTT.allCases.contains(where: { $0.product == nil }) {
                completion(false)
            } else {
                completion(true)
            }
        })
    }
    
    public func purchase_MFTW(product: ProductToBuyPoeTTT) { lazy var a1316f50 = 0
        guard let product = product.product else { return }
        
        let payment = SKPayment(product: product)
        SKPaymentQueue.default().add(payment)
    }
    
    public func localizedPrice_MFTW(for product: ProductToBuyPoeTTT) -> String { lazy var a1316f50 = 0
        guard InternetManager_KTM.shared.checkInternetConnectivity_KTM() else { return localizablePrice }
        processProductPrice_MFTW(for: product.product)
        return localizablePrice
    }

    public func completeAllTransactions_MFTW() { lazy var a1316f50 = 0
        let transactions = SKPaymentQueue.default().transactions
        for transaction in transactions { lazy var a1316f50 = 0
            let transactionState = transaction.transactionState
            if transactionState == .purchased || transactionState == .restored { lazy var a1316f50 = 0
                SKPaymentQueue.default().finishTransaction(transaction)
            }
        }
    }

    public func validateSubscriptions_MFTW(completion: @escaping (_ isSuccess: Bool) -> Void) { lazy var a1316f50 = 0
        
        let validationFunc = {
            guard let receiptUrl = Bundle.main.appStoreReceiptURL,
                  let receiptData = try? Data(contentsOf: receiptUrl) else {
                completion(false)
                return
            }
            
            let receiptDataString = receiptData.base64EncodedString(options: [])
            
            let jsonRequestBody: [String: Any] = [
                "receipt-data": receiptDataString,
                "password": self.secretKey,
                "exclude-old-transactions": true
            ]
            
            let requestData: Data
            do {
                requestData = try JSONSerialization.data(withJSONObject: jsonRequestBody)
            } catch {
                print("Failed to serialize JSON: \(error)")
                completion(false)
                return
            }
            #warning("replace to release")
    //#if DEBUG
            let url = URL(string: "https://sandbox.itunes.apple.com/verifyReceipt")!
    //#else
//            let url = URL(string: "https://buy.itunes.apple.com/verifyReceipt")!
    //#endif
            
            
            var request = URLRequest(url: url)
            request.httpMethod = "POST"
            request.httpBody = requestData
            
            let task = URLSession.shared.dataTask(with: request) { [weak self] (data, response, error) in
                var isSuccess = false
                
                defer {
                    DispatchQueue.main.async {
//                        NotificationCenter.default.post(name: .notificationStatusesDidChange, object: nil, userInfo: nil)
                        completion(isSuccess)
                    }
                }
                
                if let error = error { lazy var a1316f50 = 0
                    print("Failed to validate receipt: \(error) IAPManager_MFTW")
                    return
                }
                
                guard let data = data else {
                    print("No data received from receipt validation IAPManager_MFTW")
                    return
                }
                
                guard let json = try? JSONSerialization.jsonObject(with: data) as? [String: Any],
                      let receiptInfo = json["latest_receipt_info"] as? [[String: Any]] else {
                    return
                }
                
                isSuccess = true
                
                for receipt in receiptInfo {
                    guard let receiptProductIdentifier = receipt["product_id"] as? String,
                          let expiresDateMsString = receipt["expires_date_ms"] as? String,
                          let expiresDateMs = Double(expiresDateMsString),
                          let product = ProductToBuyPoeTTT.allCases.first(where: { $0.subscriptionId == receiptProductIdentifier })else {
                        continue
                    }
                    
                    let expiresDate = Date(timeIntervalSince1970: expiresDateMs / 1000)
                    
                    let isEnabled = expiresDate > Date()
                    
                    print("isEnabled \(product.subscriptionId): \(isEnabled)")
                    
                    if product == .main {
                        self?.pushwooshSetMainSubscriptionEnabledStatus_MFTW(isEnabled: isEnabled)
                    }
                    
                    if !product.isEnabled {
                        DispatchQueue.main.async {
                            product.isEnabled = isEnabled
                        }
                    }
                }
            }
            task.resume()
        }
        
        let receiptRefreshRequest = SKReceiptRefreshRequest(receiptProperties: nil)
        receiptRefreshRequest.delegate = self
        
        receiptRefreshCompletion = {
            self.receiptRefreshCompletion = nil
            validationFunc()
        }
        
        receiptRefreshRequest.start()
    }
    
    func paymentQueue(_ queue: SKPaymentQueue, updatedTransactions transactions: [SKPaymentTransaction]) { lazy var a1316f50 = 0
        Pushwoosh.sharedInstance().sendSKPaymentTransactions(transactions)
        
        transactions
            .filter { $0.transactionState != .purchasing }
            .forEach { queue.finishTransaction($0) }
        
        if transactions.count == 1, let transaction = transactions.first, transaction.transactionState != .purchasing {
            
            guard let product = ProductToBuyPoeTTT.allCases.first(where: { $0.subscriptionId == transaction.payment.productIdentifier }) else {
                return
            }
            
            switch transaction.transactionState {
            case .failed:
                delegate?.transactionDidFail_MFTW(for: product)
            case .purchased:
                if let product = product.product {
                    trackSubscription_MFTW(transaction: transaction, product: product)
                }
                
                validateSubscriptions_MFTW { _ in }
            default:
                break
            }
        }
    }
    
    private func processProductPrice_MFTW(for product: SKProduct?) { lazy var a1316f50 = 0
        let numberFormatter = NumberFormatter()
        numberFormatter.numberStyle = .currency
        numberFormatter.locale = product?.priceLocale ?? Locale(identifier: "en-US")
        
        if let product,
           let formattedPrice = numberFormatter.string(from: product.price) { lazy var a1316f50 = 0
            self.localizablePrice = formattedPrice
        } else {
            self.localizablePrice = "4.99 $"
        }
    }
    
    private func pushwooshSetMainSubscriptionEnabledStatus_MFTW(isEnabled : Bool) { lazy var a1316f50 = 0
        
        Pushwoosh.sharedInstance().setTags(["Subscription purchased": isEnabled]) { error in
            if let err = error { lazy var a1316f50 = 0
                print(err.localizedDescription)
                print("send tag error IAPManager_MFTW")
            }
        }
    }

    private func trackSubscription_MFTW(transaction: SKPaymentTransaction, product: SKProduct) { lazy var a1316f50 = 0
        if let receiptURL = Bundle.main.appStoreReceiptURL,
           let receiptData = try? Data(contentsOf: receiptURL) { lazy var a1316f50 = 0
            
            let price = NSDecimalNumber(decimal: product.price.decimalValue)
            let currency = product.priceLocale.currencyCode ?? "USD"
            let transactionId = transaction.transactionIdentifier ?? ""
            let transactionDate = transaction.transactionDate ?? Date()
            let salesRegion = product.priceLocale.regionCode ?? "US"
            
            if let subscription = ADJSubscription(price: price, currency: currency, transactionId: transactionId, andReceipt: receiptData) { lazy var a1316f50 = 0
                subscription.setTransactionDate(transactionDate)
                subscription.setSalesRegion(salesRegion)
                Adjust.trackSubscription(subscription)
            }
        }
    }
}


extension IAPManager_MFTW: SKProductsRequestDelegate {
    func productsRequest(_ request: SKProductsRequest, didReceive response: SKProductsResponse) { lazy var a1316f50 = 0
        print("requesting to product IAPManager_MFTW")
        
        response.invalidProductIdentifiers.forEach { id in lazy var a1316f50 = 0
            print("Invalid product identifier:", id, "IAPManager_MFTW")
        }
        
        let products = ProductToBuyPoeTTT.allCases
        
        for product in products {
            guard let productFromResponse = response.products.first(where: { $0.productIdentifier == product.subscriptionId }) else {
                print("no product for: \(product.subscriptionId) IAPManager_MFTW")
                setupGroup?.leave()
                return
            }
            print("Found product: \(productFromResponse.productIdentifier) IAPManager_MFTW")
            product.product = productFromResponse
        }
        
        setupGroup?.leave()
    }
    
    func requestDidFinish(_ request: SKRequest) {
        if request is SKReceiptRefreshRequest {
            receiptRefreshCompletion?()
        }
    }
    
    func request(_ request: SKRequest, didFailWithError error: Error) {
        if request is SKReceiptRefreshRequest {
            receiptRefreshCompletion?()
        }
    }
}







////
////  IAPManager.swift
////  Auto Clicker
////
////  Created by Timur Kadiev on 23.01.2024.
////
//
//import Foundation
//import StoreKit
//import SwiftyStoreKit
//import Pushwoosh
//import Adjust
//
//protocol IAPManagerProtocolPoeTTT: AnyObject {
//    func infoAlert(title: String, message: String)
//    func goToTheApp()
//    func failed()
//}
//
//class IAPManagerPoeTTT: NSObject, SKPaymentTransactionObserver, SKProductsRequestDelegate, ObservableObject {
//    
//    static let shared = IAPManagerPoeTTT()
//    weak var  transactionsDelegate: IAPManagerProtocolPoeTTT?
//    
//    public var  localizablePrice = "$4.99"
//    
//    
//    private var  inMain: SKProduct?
//    private var  inUnlockContent: SKProduct?
//    private var  inUnlockFunc: SKProduct?
//    private var  inUnlockOther: SKProduct?
//    
//    @Published private(set) var isSubscribed = false
//    @Published private(set) var isFirstFuncEnabled = false
//    @Published private(set) var isSecondFuncEnabled = false
//    
//    var restoreBool = false
//    
//    private var mainProduct = Configurations.mainSubscriptionID
//    private var unlockContentProduct = Configurations.unlockContentSubscriptionID
//    private var unlockFuncProduct = Configurations.unlockFuncSubscriptionID
//    private var unlockOther = Configurations.unlockerThreeSubscriptionID
//    
//    private var secretKey = Configurations.subscriptionSharedSecret
//    
//    private var isRestoreTransaction = true
//    
//    private let iapError      = NSLocalizedString("error_iap", comment: "")
//    private let prodIDError   = NSLocalizedString("inval_prod_id", comment: "")
//    private let restoreError  = NSLocalizedString("faledRestore", comment: "")
//    private let purchaseError = NSLocalizedString("notPurchases", comment: "")
//    
//    public var productBuy : PremiumMainControllerStylePoeTTT = .mainProduct
//    
//    public func loadProductsFunc() {
//        SKPaymentQueue.default().add(self)
//        let request = SKProductsRequest(productIdentifiers:[mainProduct,unlockContentProduct,unlockFuncProduct,unlockOther])
//        request.delegate = self
//        request.start()
//    }
//         
//    
//    public func doPurchase() {
//        switch productBuy {
//          case .mainProduct:
//            if let inMain {
//                processPurchase(for: inMain, with: Configurations.mainSubscriptionID)
//            }
//            else {
//                transactionsDelegate?.infoAlert(title: "Error", message: "Product is empty!")
//            }
//          case .unlockContentProduct:
//            if let inUnlockContent {
//                processPurchase(for: inUnlockContent, with: Configurations.unlockContentSubscriptionID)
//            }
//            else {
//                transactionsDelegate?.infoAlert(title: "Error", message: "Product is empty!")
//            }
//          case .unlockFuncProduct:
//            if let inUnlockFunc {
//                processPurchase(for: inUnlockFunc, with: Configurations.unlockFuncSubscriptionID)
//            }
//            else {
//                transactionsDelegate?.infoAlert(title: "Error", message: "Product is empty!")
//            }
//        case .unlockOther:
//            if let inUnlockOther {
//                processPurchase(for: inUnlockOther, with: Configurations.unlockerThreeSubscriptionID)
//            }
//            else {
//                transactionsDelegate?.infoAlert(title: "Error", message: "Product is empty!")
//            }
//        }
//    }
//    
//    public func localizedPrice() -> String {
//        if InternetManager.shared.checkInternetConnectivity() {
//            switch productBuy {
//            case .mainProduct:
//                localizablePrice = inMain?.localizedPrice ?? "4.99$"
//            case .unlockContentProduct:
//                localizablePrice = inUnlockContent?.localizedPrice ?? "4.99$"
//            case .unlockFuncProduct:
//                localizablePrice = inUnlockFunc?.localizedPrice ?? "4.99$"
//            case .unlockOther:
//                localizablePrice = inUnlockOther?.localizedPrice ?? "4.99$"
//            }
//        }
//        return localizablePrice
//    }
//    
//    func getCurrentProduct() -> SKProduct? {
//        switch productBuy {
//        case .mainProduct:
//            return self.inMain
//        case .unlockContentProduct:
//            return self.inUnlockContent
//        case .unlockFuncProduct:
//            return self.inUnlockFunc
//        case .unlockOther:
//            return self.inUnlockOther
//        }
//    }
//    
//    private func processPurchase(for product: SKProduct, with configurationId: String) {
//        if product.productIdentifier.isEmpty {
//        
//            self.transactionsDelegate?.infoAlert(title: iapError, message: prodIDError)
//        } else if product.productIdentifier == configurationId {
//            let payment = SKPayment(product: product)
//            SKPaymentQueue.default().add(payment)
//        }
//    }
//    
//    
//    public func doRestore() {
//        if !restoreBool  {
//            SKPaymentQueue.default().restoreCompletedTransactions()
//            restoreBool = true
//        }
//    }
//    
//    
//    private func completeRestoredStatusFunc(restoreProductID : String) {
//        guard isRestoreTransaction else {
//            return
//        }
//        
//        isRestoreTransaction = false
//        
//        validateSubscriptionWithCompletionHandler(productIdentifier: restoreProductID) { [weak self] result in
//            guard let self = self else {
//                return
//            }
//            
//            if result {
//                self.transactionsDelegate?.goToTheApp()
//            } else {
//                self.transactionsDelegate?.infoAlert(title: self.restoreError, message: self.purchaseError)
//            }
//        }
//    }
//    
//    
//    public func completeAllTransactionsFunc() {
//        let transactions = SKPaymentQueue.default().transactions
//        for transaction in transactions {
//            let transactionState = transaction.transactionState
//            if transactionState == .purchased || transactionState == .restored {
//                SKPaymentQueue.default().finishTransaction(transaction)
//            }
//        }
//    }
//    
//    // Ваша собственная функция для проверки подписки.
//    public func validateSubscriptionWithCompletionHandler(productIdentifier: String,_ resultExamination: @escaping (Bool) -> Void) {
//        SKReceiptRefreshRequest().start()
//
//        guard let receiptUrl = Bundle.main.appStoreReceiptURL,
//              let receiptData = try? Data(contentsOf: receiptUrl) else {
//            pushwooshSetSubTag(value: false)
//            resultExamination(false)
//            return
//        }
//        
//        let receiptDataString = receiptData.base64EncodedString(options: [])
//        
//        let jsonRequestBody: [String: Any] = [
//            "receipt-data": receiptDataString,
//            "password": self.secretKey,
//            "exclude-old-transactions": true
//        ]
//        
//        let requestData: Data
//        do {
//            requestData = try JSONSerialization.data(withJSONObject: jsonRequestBody)
//        } catch {
//            print("Failed to serialize JSON: \(error)")
//            pushwooshSetSubTag(value: false)
//            resultExamination(false)
//            return
//        }
//        #warning("replace to release")
////#if DEBUG
//        let url = URL(string: "https://sandbox.itunes.apple.com/verifyReceipt")!
////#else
////        let url = URL(string: "https://buy.itunes.apple.com/verifyReceipt")!
////#endif
//        
//        
//        var request = URLRequest(url: url)
//        request.httpMethod = "POST"
//        request.httpBody = requestData
//        
//        let task = URLSession.shared.dataTask(with: request) { (data, response, error) in
//            if let error = error {
//                print("Failed to validate receipt: \(error) IAPManager")
//                self.pushwooshSetSubTag(value: false)
//                resultExamination(false)
//                return
//            }
//            
//            guard let data = data else {
//                print("No data received from receipt validation IAPManager")
//                self.pushwooshSetSubTag(value: false)
//                resultExamination(false)
//                return
//            }
//            
//            do {
//                if let json = try JSONSerialization.jsonObject(with: data) as? [String: Any],
//                   let latestReceiptInfo = json["latest_receipt_info"] as? [[String: Any]] {
//                    for receipt in latestReceiptInfo {
//                           if let receiptProductIdentifier = receipt["product_id"] as? String,
//                              receiptProductIdentifier == productIdentifier,
//                              let expiresDateMsString = receipt["expires_date_ms"] as? String,
//                              let expiresDateMs = Double(expiresDateMsString) {
//                               let expiresDate = Date(timeIntervalSince1970: expiresDateMs / 1000)
//                               if expiresDate > Date() {
//                                   DispatchQueue.main.async {
//                                       self.pushwooshSetSubTag(value: true)
//                                       if productIdentifier == self.inMain?.productIdentifier {
//                                           self.isSubscribed = true
//                                       }
//                                       resultExamination(true)
//                                   }
//                                   return
//                               }
//                           }
//                       }
//                }
//            } catch {
//                print("Failed to parse receipt data 🔴: \(error) IAPManager")
//            }
//            
//            DispatchQueue.main.async {
//                self.pushwooshSetSubTag(value: false)
//                resultExamination(false)
//            }
//        }
//        task.resume()
//    }
//    
//    
//    func validateSubscriptions(productIdentifiers: [String], completion: @escaping ([String: Bool]) -> Void) {
//        var results = [String: Bool]()
//        let dispatchGroup = DispatchGroup()
//        
//        for productIdentifier in productIdentifiers {
//            dispatchGroup.enter()
//            validateSubscriptionWithCompletionHandler(productIdentifier: productIdentifier) { isValid in
//                results[productIdentifier] = isValid
//                dispatchGroup.leave()
//            }
//        }
//        
//        dispatchGroup.notify(queue: .main) {
//            self.isFirstFuncEnabled = results[Configurations.unlockFuncSubscriptionID] ?? false
//            self.isSecondFuncEnabled = results[Configurations.unlockContentSubscriptionID] ?? false
//            completion(results)
//        }
//    }
//    
//    func paymentQueue(_ queue: SKPaymentQueue, updatedTransactions transactions: [SKPaymentTransaction]) {
//        Pushwoosh.sharedInstance().sendSKPaymentTransactions(transactions)
//        for transaction in transactions {
//            if let error = transaction.error as NSError?, error.domain == SKErrorDomain {
//                switch error.code {
//                case SKError.paymentCancelled.rawValue:
//                    print("User cancelled the request IAPManager")
//                case SKError.paymentNotAllowed.rawValue, SKError.paymentInvalid.rawValue, SKError.clientInvalid.rawValue, SKError.unknown.rawValue:
//                    print("This device is not allowed to make the payment IAPManager")
//                default:
//                    break
//                }
//            }
//            
//            switch transaction.transactionState {
//            case .purchased:
//                SKPaymentQueue.default().finishTransaction(transaction)
//                if let product = getCurrentProduct() {
//                    if transaction.payment.productIdentifier == product.productIdentifier {
//                        trackSubscription(transaction: transaction, product:  product)
//                        transactionsDelegate?.goToTheApp()
//                    }
//                    
//                }
//                
//                if transaction.payment.productIdentifier == self.inMain?.productIdentifier {
//                    isSubscribed = true
//                }
//                else if transaction.payment.productIdentifier == self.inUnlockFunc?.productIdentifier {
//                    isFirstFuncEnabled = true
//                }
//                else if transaction.payment.productIdentifier == self.inUnlockContent?.productIdentifier {
//                    isSecondFuncEnabled = true
//                }
//              //  print("Purchased IAPManager")
//                
//            case .failed:
//                SKPaymentQueue.default().finishTransaction(transaction)
//                transactionsDelegate?.failed()
//                print("Failed IAPManager")
//                
//            case .restored:
//                restoreBool = false
//                SKPaymentQueue.default().finishTransaction(transaction)
//                if let product = getCurrentProduct() {
//                    trackSubscription(transaction: transaction, product:  product)
//                    completeRestoredStatusFunc(restoreProductID: product.productIdentifier)
//                }
//                print("Restored IAPManager")
//                if transaction.payment.productIdentifier == self.inMain?.productIdentifier {
//                    isSubscribed = true
//                }
//                else if transaction.payment.productIdentifier == self.inUnlockFunc?.productIdentifier {
//                    isFirstFuncEnabled = true
//                }
//                else if transaction.payment.productIdentifier == self.inUnlockContent?.productIdentifier {
//                    isSecondFuncEnabled = true
//                }
//            case .purchasing, .deferred:
//                print("Purchasing IAPManager")
//                
//            default:
//                print("Default IAPManager")
//            }
//        }
//        completeAllTransactionsFunc()
//    }
//    
//    
//    func productsRequest(_ request: SKProductsRequest, didReceive response: SKProductsResponse) {
//        print("requesting to product IAPManager")
//        
//        if let invalidIdentifier = response.invalidProductIdentifiers.first {
//            print("Invalid product identifier:", invalidIdentifier , "IAPManager")
//        }
//        
//        guard !response.products.isEmpty else {
//            print("No products available IAPManager")
//            return
//        }
//        
//        response.products.forEach({ productFromRequest in
//            switch productFromRequest.productIdentifier {
//            case Configurations.mainSubscriptionID:
//                inMain = productFromRequest
//            case Configurations.unlockContentSubscriptionID:
//                inUnlockContent = productFromRequest
//            case Configurations.unlockFuncSubscriptionID:
//                inUnlockFunc = productFromRequest
//            case Configurations.unlockerThreeSubscriptionID:
//                inUnlockOther = productFromRequest
//            default:
//                print("error IAPManager")
//                return
//            }
//            print("Found product: \(productFromRequest.productIdentifier) IAPManager")
//        })
//    }
//    
//    private func processProductPrice(for product: SKProduct) {
//        let numberFormatter = NumberFormatter()
//        numberFormatter.numberStyle = .currency
//        numberFormatter.locale = product.priceLocale
//        
//        if let formattedPrice = numberFormatter.string(from: product.price) {
//            self.localizablePrice = formattedPrice
//        } else {
//            self.localizablePrice = "4.99 $"
//        }
//    }
//    
//    private func pushwooshSetSubTag(value : Bool) {
//        
//        var tag = Configurations.mainSubscriptionPushTag
//        
//        switch productBuy {
//        case .mainProduct:
//             print("continue IAPManager")
//        case .unlockContentProduct:
//            tag = Configurations.unlockContentSubscriptionPushTag
//        case .unlockFuncProduct:
//            tag = Configurations.unlockFuncSubscriptionPushTag
//        case .unlockOther:
//            tag = Configurations.unlockerThreeSubscriptionPushTag
//        }
//        
//        Pushwoosh.sharedInstance().setTags([tag: value]) { error in
//            if let err = error {
//                print(err.localizedDescription)
//                print("send tag error IAPManager")
//            }
//        }
//    }
//
//    private func trackSubscription(transaction: SKPaymentTransaction, product: SKProduct) {
//        if let receiptURL = Bundle.main.appStoreReceiptURL,
//           let receiptData = try? Data(contentsOf: receiptURL) {
//            
//            let price = NSDecimalNumber(decimal: product.price.decimalValue)
//            let currency = product.priceLocale.currencyCode ?? "USD"
//            let transactionId = transaction.transactionIdentifier ?? ""
//            let transactionDate = transaction.transactionDate ?? Date()
//            let salesRegion = product.priceLocale.regionCode ?? "US"
//            
//            if let subscription = ADJSubscription(price: price, currency: currency, transactionId: transactionId, andReceipt: receiptData) {
//                subscription.setTransactionDate(transactionDate)
//                subscription.setSalesRegion(salesRegion)
//                Adjust.trackSubscription(subscription)
//            }
//        }
//    }
//}
