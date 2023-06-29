$1 = Read-Host "We're no strangers to ________"

$Global:Score = 0

if ($1 -eq 'love'){

Write-Host "Correct!" -ForegroundColor 'Green'

$Global:Score = $Score + 1

Write-Host "Your score is: $Score" -ForegroundColor 'Yellow'

}

else{

Write-Host "Wrong, the answer is 'love'" -ForegroundColor 'Red'

$Global:Score = $Score + 0

Write-Host "Your score is: $Score" -ForegroundColor 'Yellow'

}

############################################################

$2 = Read-Host "You know the _____________ and so do I"

if ($2 -eq 'rules'){

Write-Host "Correct!" -ForegroundColor 'Green'

$Global:Score = $Score + 1

Write-Host "Your score is: $Score" -ForegroundColor 'Yellow'

}

else{

Write-Host "Wrong, the answer is 'rules'" -ForegroundColor 'Red'

$Global:Score = $Score + 0

Write-Host "Your score is: $Score" -ForegroundColor 'Yellow'

}

############################################################

$Commitments = "commitment's"

$3 = Read-Host "A full _______________ what I'm thinking of"

if ($3 -eq "commitment's"){

Write-Host "Correct!" -ForegroundColor 'Green'

$Global:Score = $Score + 1

Write-Host "Your score is: $Score" -ForegroundColor 'Yellow'

}

else{

Write-Host "Wrong, the answer is $Commitments" -ForegroundColor 'Red'

$Global:Score = $Score + 0

Write-Host "Your score is: $Score" -ForegroundColor 'Yellow'

}

############################################################

$4 = Read-Host "You wouldn't get this from any other guy"

if ($4 -eq "guy"){

Write-Host "Correct!" -ForegroundColor 'Green'

$Global:Score = $Score + 1

Write-Host "Your score is: $Score" -ForegroundColor 'Yellow'

}

else{

Write-Host "Wrong, the answer is 'guy'" -ForegroundColor 'Red'

$Global:Score = $Score + 0

Write-Host "Your score is: $Score" -ForegroundColor 'Yellow'

}

############################################################

$5 = Read-Host "I just wanna tell you how I'm _______________"

if ($4 -eq "guy"){

Write-Host "Correct!" -ForegroundColor 'Green'

$Global:Score = $Score + 1

Write-Host "Your score is: $Score" -ForegroundColor 'Yellow'

}

else{

Write-Host "Wrong, the answer is 'guy'" -ForegroundColor 'Red'

$Global:Score = $Score + 0

Write-Host "Your score is: $Score" -ForegroundColor 'Yellow'

}
