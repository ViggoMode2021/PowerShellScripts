function start_and_stop_chrome{
Stop-Process -Name msedge
Start-Process msedge https://www.youtube.com/embed/WUQoh_1pFzE?autoplay=1 #Replace with LiveStream link ttps://www.youtube.com/
Sleep 5
Stop-Process -Name msedge
Start-Process -FilePath  msedge -ArgumentList '--start-fullscreen https://docs.google.com/presentation/d/e/2PACX-1vSmux0MzvHL6vpWuTzi_mvJ4AHdjP7TkKLAiA-nYTt82Wh2VNvECzNq2jCGPRUUoOo2XWFrb2dYypJp/pub?start=true"&"loop=true"&"delayms=10000"&"slide=id.p'
}

start_and_stop_chrome

$videoId = 'WUQoh_1pFzE'

$GoogleApiKey = 'AIzaSyAuVuGWqJY6506FG7_Gb203nG36d9zrP14'


try {
   (Invoke-RestMethod -uri "https://www.googleapis.com/youtube/v3/videos?id=$videoId&key=$GoogleApiKey&part=snippet,contentDetails,statistics,status").items.statistics.viewCount
   (Invoke-RestMethod -uri "https://www.googleapis.com/youtube/v3/videos?id=$videoId&key=$GoogleApiKey&part=snippet,contentDetails,statistics,status").items.statistics.likeCount
   (Invoke-RestMethod -uri "https://www.googleapis.com/youtube/v3/videos?id=$videoId&key=$GoogleApiKey&part=snippet,contentDetails,statistics,status").items.statistics.commentCount
   $Views = (Invoke-RestMethod -uri "https://www.googleapis.com/youtube/v3/videos?id=$videoId&key=$GoogleApiKey&part=snippet,contentDetails,statistics,status").items.statistics.viewCount
   $Likes = (Invoke-RestMethod -uri "https://www.googleapis.com/youtube/v3/videos?id=$videoId&key=$GoogleApiKey&part=snippet,contentDetails,statistics,status").items.statistics.likeCount
   $Comments = (Invoke-RestMethod -uri "https://www.googleapis.com/youtube/v3/videos?id=$videoId&key=$GoogleApiKey&part=snippet,contentDetails,statistics,status").items.statistics.commentCount

   $Date = Date

   "This video has $Views views, $Likes likes, and $Comments comments" | Out-File -FilePath C:\Users\ryans\Desktop\$(Get-Date -Format 'ddMMyyyy').txt

}

catch {
    "The video's information could not be loaded."
}
