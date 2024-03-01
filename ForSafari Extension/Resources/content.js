browser.runtime.sendMessage({ greeting: "hello" }).then((response) => {
    console.log("Received response: ", response);
});


var isAutoReloadMode = localStorage.getItem("isAutoReloadMode") == null ? true : (String(localStorage.getItem("isAutoReloadMode")).toLowerCase().trim() == "true")
var isRunning_KTM = localStorage.getItem("isRunning_KTM") == null ? false : (String(localStorage.getItem("isRunning_KTM")).toLowerCase().trim() == "true")
var reloadTime = localStorage.getItem("reloadTime") == null ? 1 : localStorage.getItem("reloadTime")
var scrollSpeed = localStorage.getItem("scrollSpeed") == null ? 1 : localStorage.getItem("scrollSpeed")
var secCounter = localStorage.getItem("secCounter") == null ? 0 : localStorage.getItem("secCounter")

if (!isAutoReloadMode && isRunning_KTM){
    isRunning_KTM = false
    localStorage.isRunning_KTM = false
}


browser.runtime.onMessage.addListener((request, sender, sendResponse) => {
    console.log("Received request: ", request);
    if (request.action == "autoReload"){
        isAutoReloadMode = request.isAutoReloadMode
        isRunning_KTM = request.isRunning_KTM
        reloadTime = request.reloadTime
        
        localStorage.isAutoReloadMode = isAutoReloadMode
        localStorage.isRunning_KTM = isRunning_KTM
        localStorage.reloadTime = reloadTime
        
        location.reload()
        
        return
    };
    
    if (request.action == "autoScroll"){
        isAutoReloadMode = request.isAutoReloadMode
        isRunning_KTM = request.isRunning_KTM
        scrollSpeed = request.scrollSpeed
        
        localStorage.isAutoReloadMode = isAutoReloadMode
        localStorage.isRunning_KTM = isRunning_KTM
        localStorage.scrollSpeed = scrollSpeed
        
        if (isRunning_KTM){
            pageScroll()
        }
        
        return
    };
    
    if (request.action == "getStatus"){
        sendResponse({
            isAutoReloadMode: isAutoReloadMode,
            reloadTime: reloadTime,
            isRunning_KTM: isRunning_KTM,
            scrollSpeed: scrollSpeed
        });
        return
    }
    
    if (request.action == "setData"){
        isAutoReloadMode = request.isAutoReloadMode
        isRunning_KTM = request.isRunning_KTM
        reloadTime = request.reloadTime
        scrollSpeed = request.scrollSpeed
        
        localStorage.isAutoReloadMode = isAutoReloadMode
        localStorage.isRunning_KTM = isRunning_KTM
        localStorage.reloadTime = reloadTime
        localStorage.scrollSpeed = scrollSpeed
        return
    }
    
});

if (isAutoReloadMode){
    if (isRunning_KTM){
        setTimeout(function (){
            location.reload()
        }, reloadTime*1000);
    }
}else{
    if (isRunning_KTM){
//        pageScroll()
    }
}


function pageScroll() {
    window.scrollBy(0,0.5*scrollSpeed);
    if (!isAutoReloadMode){
        if (isRunning_KTM){
            scrolldelay = setTimeout(pageScroll,10);
        }
    }
}


window.onbeforeunload = function() {
  localStorage.removeItem("reloadTime")
};
