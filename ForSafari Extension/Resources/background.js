browser.runtime.onMessage.addListener((request, sender, sendResponse) => {
    console.log("Received request: ", request);
//
//    if (request.greeting === "hello")
//        sendResponse({ farewell: "goodbye" });
    
    if (request.action == "reload"){
//        location.reload();
//        setInterval(function() {
//            location.reload();
//        }, 2 * 1000);
//        sendResponse({
//            message: "Reloaded!!!!"
//        });
    };
});
