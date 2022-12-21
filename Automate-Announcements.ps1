function start_and_stop_chrome{
Stop-Process -Name chrome
Start-Process chrome https://www.youtube.com/embed/WUQoh_1pFzE?autoplay=1 #Replace with LiveStream link ttps://www.youtube.com/
Sleep 10
Stop-Process -Name chrome
Start-Process -FilePath  chrome -ArgumentList '--start-fullscreen https://docs.google.com/presentation/d/e/2PACX-1vSmux0MzvHL6vpWuTzi_mvJ4AHdjP7TkKLAiA-nYTt82Wh2VNvECzNq2jCGPRUUoOo2XWFrb2dYypJp/pub?start=true"&"loop=true"&"delayms=10000"&"slide=id.p'
}

start_and_stop_chrome