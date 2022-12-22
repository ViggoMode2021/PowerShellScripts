$videoId = 'WUQoh_1pFzE'

$channelId = 'UCWNxa-_nWe_w9SFfgFF1LoQ'

$GoogleApiKey = 'AIzaSyAuVuGWqJY6506FG7_Gb203nG36d9zrP14'

$video_analytics = 'C:\Users\rviglione\Desktop\Announcements.csv' 

function start_and_stop_announcements{
Stop-Process -Name msedge
Start-Process msedge https://www.youtube.com/embed/WUQoh_1pFzE?autoplay=1 #Replace with LiveStream link https://www.youtube.com/
Sleep 5
Stop-Process -Name msedge
Start-Process -FilePath  msedge -ArgumentList '--start-fullscreen https://docs.google.com/presentation/d/e/2PACX-1vSmux0MzvHL6vpWuTzi_mvJ4AHdjP7TkKLAiA-nYTt82Wh2VNvECzNq2jCGPRUUoOo2XWFrb2dYypJp/pub?start=true"&"loop=true"&"delayms=10000"&"slide=id.p'
}

start_and_stop_announcements

function get_video_date{
try {
   
   $Views = (Invoke-RestMethod -uri "https://www.googleapis.com/youtube/v3/videos?id=$videoId&key=$GoogleApiKey&part=snippet,contentDetails,statistics,status").items.statistics.viewCount
   $Likes = (Invoke-RestMethod -uri "https://www.googleapis.com/youtube/v3/videos?id=$videoId&key=$GoogleApiKey&part=snippet,contentDetails,statistics,status").items.statistics.likeCount
   $Comments = (Invoke-RestMethod -uri "https://www.googleapis.com/youtube/v3/videos?id=$videoId&key=$GoogleApiKey&part=snippet,contentDetails,statistics,status").items.statistics.commentCount

   $Date = Date

   $NewRow = "$Views,$Likes,$Comments"

   $NewRow | Add-Content -Path $video_analytics 

   $newRow = New-Object PsObject -Property @{ Views = "$Views" ; Likes = $Likes ; Comments = $Comments ; Date = $Date }
   $fileContent += $newRow

   $filecontent | Export-csv -append $video_analytics

}

catch {
    Write-Host "The video's information could not be loaded."
}
}

get_video_date
