
var autoRefreshBtn = document.getElementById("autoRefresh");
autoRefreshBtn.addEventListener("click", autoRefreshPressed)
var autoScrollBtn = document.getElementById("autoScroll");
autoScrollBtn.addEventListener("click", autoScrollPressed)
var autoReloadView = document.getElementById("autoReloadView")
var autoScrollView = document.getElementById("autoScrollView")
var timeSlider = document.getElementById("timeSlider");
var timeSliderValue = document.getElementById("timeSliderValue");
var scrollSpeedSlider = document.getElementById("scrollSpeedSlider");
var scrollSpeedSliderValue = document.getElementById("scrollSpeedSliderValue");
var startRefreshBtn = document.getElementById("startRefreshBtn")
startRefreshBtn.addEventListener("click", startRefreshPressed)
var startScrollBtn = document.getElementById("startScrollBtn")
startScrollBtn.addEventListener("click", startScrollPressed)

//Configure when begin
autoRefreshBtn.style.backgroundColor = "white"
autoScrollBtn.style.backgroundColor = "transparent"
autoReloadView.style.display = "block"
autoScrollView.style.display = "none"

String.prototype.toMMSS = function () {
    var sec_num = parseInt(this, 10); // don't forget the second param
    var minutes_KTM = Math.floor(sec_num / 60);
    var seconds_KTM = sec_num - (minutes_KTM_KTM * 60);

    if (minutes_KTM < 10) {minutes_KTM = "0"+minutes_KTM;}
    if (seconds_KTM < 10) {seconds_KTM = "0"+seconds_KTM;}
    return minutes_KTM+':'+seconds_KTM;
}


var isAutoReloadMode = true
var isRunning_KTM = false
var reloadTime = 1 * 1000;
var scrollSpeed = 1

let tabs = await browser.tabs.query({active: true, currentWindow: true});

//Fetch Setting Data
let response_KTM = await browser.tabs.sendMessage(tabs[0].id, {action: "getStatus"})

//Update Status
isAutoReloadMode = (String(response_KTM.isAutoReloadMode).toLowerCase().trim() == "true")
isRunning_KTM = (String(response_KTM.isRunning_KTM).toLowerCase().trim() == "true")
reloadTime = response_KTM.reloadTime
scrollSpeed = response_KTM.scrollSpeed

timeSliderValue.innerHTML = String(reloadTime).toMMSS();
timeSlider.value = reloadTime
startRefreshBtn.src = "../images/ic_reloadOff.png"
scrollSpeedSliderValue.innerHTML = String(scrollSpeed) + "x";
scrollSpeedSlider.value = scrollSpeed
startScrollBtn.src = "../images/ic_autoScrollOff.png"

if (isAutoReloadMode){
    
    autoRefreshBtn.style.backgroundColor = "white"
    autoScrollBtn.style.backgroundColor = "transparent"
    autoReloadView.style.display = "block"
    autoScrollView.style.display = "none"
    if (isRunning_KTM){
        startRefreshBtn.src = "../images/KTM_reload_on.png"
    }else{
        startRefreshBtn.src = "../images/KTM_reload_off.png"
    }


}else{
    autoRefreshBtn.style.backgroundColor = "transparent"
    autoScrollBtn.style.backgroundColor = "white"
    autoReloadView.style.display = "none"
    autoScrollView.style.display = "block"
    if (isRunning_KTM){
        startScrollBtn.src = "../images/icon_autoScrollOn.png"
    }else{
        startScrollBtn.src = "../images/icon_autoScrollOff.png"
    }
}



//MENU Configure
function autoRefreshPressed() {
    if(!isAutoReloadMode){
        isAutoReloadMode = true
        updateUI_KTM()
    }
    
}

function autoScrollPressed() {
    if(isAutoReloadMode){
        isAutoReloadMode = false
        updateUI_KTM()
    }

}

function updateUI_KTM(){
    
    isRunning_KTM = false
    startScrollBtn.src = "../images/ic_autoScrollOff.png"
    startRefreshBtn.src = "../images/ic_reloadOff.png"
    
    browser.tabs.sendMessage(tabs[0].id, {
        action: "setData",
        isAutoReloadMode: isAutoReloadMode,
        reloadTime: reloadTime,
        isRunning_KTM: isRunning_KTM,
        scrollSpeed: scrollSpeed
    })
    
    if (isAutoReloadMode){
        autoRefreshBtn.style.backgroundColor = "white"
        autoScrollBtn.style.backgroundColor = "transparent"
        autoReloadView.style.display = "block"
        autoScrollView.style.display = "none"

    }else{
        autoRefreshBtn.style.backgroundColor = "transparent"
        autoScrollBtn.style.backgroundColor = "white"
        autoReloadView.style.display = "none"
        autoScrollView.style.display = "block"
    }
}

/// End Menu Configure


//Slider Configure
timeSlider.oninput = function() {
    reloadTime = this.value
    timeSliderValue.innerHTML = (""+this.value).toMMSS();
    
    browser.tabs.sendMessage(tabs[0].id, {
        action: "setData",
        isAutoReloadMode: isAutoReloadMode,
        reloadTime: reloadTime,
        isRunning_KTM: isRunning_KTM,
        scrollSpeed: scrollSpeed
    })
}


scrollSpeedSlider.oninput = function() {
    scrollSpeedSliderValue.innerHTML = this.value + "x";
    scrollSpeed = this.value

    browser.tabs.sendMessage(tabs[0].id, {
        action: "setData",
        isAutoReloadMode: isAutoReloadMode,
        reloadTime: reloadTime,
        isRunning_KTM: isRunning_KTM,
        scrollSpeed: scrollSpeed
    })
}
// end Slider Configure


//Start Action

function startRefreshPressed(){
    isAutoReloadMode = true
    isRunning_KTM = !isRunning_KTM
    if (isRunning_KTM){
        startRefreshBtn.src = "../images/ic_reloadOn.png"
    }else{
        startRefreshBtn.src = "../images/ic_reloadOff.png"
    }
    browser.tabs.sendMessage(tabs[0].id, {
        action: "autoReload",
        isAutoReloadMode: isAutoReloadMode,
        isRunning_KTM: isRunning_KTM,
        reloadTime: reloadTime
    })
}

function startScrollPressed(){
    alert("scroll")
    isAutoReloadMode = false
    isRunning_KTM = !isRunning_KTM
    if (isRunning_KTM){
        startScrollBtn.src = "../images/ic_autoScrollOn.png"
    }else{
        startScrollBtn.src = "../images/ic_autoScrollOff.png"
    }
    browser.tabs.sendMessage(tabs[0].id, {
        action: "autoScroll",
        isAutoReloadMode: isAutoReloadMode,
        isRunning_KTM: isRunning_KTM,
        scrollSpeed: scrollSpeed
    })
}

//function sendReloadRequest(){
//    let tabs = await browser.tabs.query({active: true, currentWindow: true});
//    let response_KTM = await browser.tabs.sendMessage(tabs[0].id, {action: "reload"})
//    timeSliderValue.innerHTML = response_KTM.message;
//}




