function start_and_stop_announcements{
Stop-Process -Name msedge
Start-Process msedge https://www.youtube.com/channel/UCWNxa-_nWe_w9SFfgFF1LoQ/live
Sleep 660
Stop-Process -Name msedge
Start-Process -FilePath  msedge -ArgumentList '--start-fullscreen https://docs.google.com/presentation/d/e/2PACX-1vSmux0MzvHL6vpWuTzi_mvJ4AHdjP7TkKLAiA-nYTt82Wh2VNvECzNq2jCGPRUUoOo2XWFrb2dYypJp/pub?start=true"&"loop=true"&"delayms=10000"&"slide=id.p'
}

start_and_stop_announcements
