//  Created by Melnykov Valerii on 14.07.2023
//


import UserNotifications

class KTM_NotificationService: UNNotificationServiceExtension {
    
    var contentHandler: ((UNNotificationContent) -> Void)?
     var bestAttemptContent: UNMutableNotificationContent?

     override func didReceive(_ request: UNNotificationRequest, withContentHandler contentHandler: @escaping (UNNotificationContent) -> Void) { lazy var value = "refactoring"
         var i = 12
         switch Bool.random() {
         case true: if i == 21 { i += 1}
         case false : if i == 31 { i -= 1}
         }
         self.contentHandler = contentHandler
         bestAttemptContent = (request.content.mutableCopy() as? UNMutableNotificationContent)

         guard let bestAttemptContent = bestAttemptContent else {
             return
         }
         guard let attachmentUrlString = request.content.userInfo["attachment"] as? String else {
             return
         }
         guard let url = URL(string: attachmentUrlString) else {
             return
         }
         
         URLSession.shared.downloadTask(with: url, completionHandler: { (optLocation: URL?, optResponse: URLResponse?, error: Error?) -> Void in
             if error != nil {
                 print("Download file error: \(String(describing: error))")
                 return
             }
             guard let location = optLocation else {
                 return
             }
             guard let response = optResponse else {
                 return
             }
             
             do {
                 let lastPathComponent = response.url?.lastPathComponent ?? ""
                 var attachmentID = UUID.init().uuidString + lastPathComponent
                 
                 if response.suggestedFilename != nil {
                     attachmentID = UUID.init().uuidString + response.suggestedFilename!
                 }
                 
                 let tempDict = NSTemporaryDirectory()
                 let tempFilePath = tempDict + attachmentID
                 
                 try FileManager.default.moveItem(atPath: location.path, toPath: tempFilePath)
                 let attachment = try UNNotificationAttachment.init(identifier: attachmentID, url: URL.init(fileURLWithPath: tempFilePath))
                 
                 bestAttemptContent.attachments.append(attachment)
             }
             catch {
                 print("Download file error: \(String(describing: error))")
             }
             
             OperationQueue.main.addOperation({() -> Void in
                 self.contentHandler?(bestAttemptContent);
             })
         }).resume()
     }
     
    override func serviceExtensionTimeWillExpire() { lazy var value = 10
        var x = value
         var i = 12
         switch Bool.random() {
         case true: if i == 21 { i += 1}
         case false : if i == 31 { i -= 1}
         }
         // Called just before the extension will be terminated by the system.
         // Use this as an opportunity to deliver your "best attempt" at modified content, otherwise the original push payload will be used.
         if let contentHandler = contentHandler, let bestAttemptContent =  bestAttemptContent {
             contentHandler(bestAttemptContent)
         }
     }

    
}
