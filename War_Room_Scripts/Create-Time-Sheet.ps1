$Word_Object = New-Object -ComObject word.application
#$Word_Object.Visible = $True

$Desktop_Path = [Environment]::GetFolderPath("Desktop")

$Date = Get-Date
$Today_Date = $Date.ToString('MM-dd-yy')

$Day_Of_Week = (Get-Date).DayOfWeek

$Current_Time = (Get-Date).ToString('T')


$Test_Path = Test-Path -Path "$Desktop_Path\TimeSheets"

if($Test_Path -eq $True){

Write-Host "TimeSheets folder already exists."

}

else{

New-Item -ItemType Directory -Path $Desktop_Path\TimeSheets

Write-Host "TimeSheets folder created."

}


if($Day_Of_Week -eq "Monday"){

Copy-Item "$Desktop_Path\Blank-Time-Sheet.doc" -Destination "$Desktop_Path\TimeSheets\Time-Sheet-Week-Of-Monday-$Today_Date.doc"

$Find_Monday_Date = “Monday-Date”

$Replace_Monday_Date = $Today_Date

$Find_Monday_Time_In = "Monday-Time-In"

$Replace_Monday_Time_In = $Current_Time

$Find_Monday_Total = "Monday-Total" 

$Clock_Out_Time = [DateTime]"5:00 PM"

$Current_Time = [DateTime]$Current_Time

$Total_Time_Worked = New-TimeSpan -Start $Current_Time -End $Clock_Out_Time

$Total_Time_Worked = [String]$Total_Time_Worked

$Total_Time_Worked_Monday = "Mon-Total:" + "`n`n`n$Total_Time_Worked"

$Document_Object = $Word_Object.Documents.Open(“$Desktop_Path\TimeSheets\Time-Sheet-Week-Of-Monday-$Today_Date.doc”)
$Object_Selection = $Word_Object.Selection

$ReplaceAll = 2
$FindContinue = 1
$MatchCase = $False
$MatchWholeWord = $True
$MatchWildcards = $False
$MatchSoundsLike = $False
$MatchAllWordForms = $False
$Forward = $True
$Wrap = $FindContinue
$Format = $False

$Object_Selection.Find.Execute($Find_Monday_Date, $MatchCase,
  $MatchWholeWord,$MatchWildcards,$MatchSoundsLike,
  $MatchAllWordForms,$Forward,$Wrap,$Format, $Replace_Monday_Date,
  $ReplaceAll)

$Object_Selection.Find.Execute($Find_Monday_Time_In, $MatchCase,
  $MatchWholeWord,$MatchWildcards,$MatchSoundsLike,
  $MatchAllWordForms,$Forward,$Wrap,$Format, $Replace_Monday_Time_In,
  $ReplaceAll)

$Object_Selection.Find.Execute($Find_Monday_Total, $MatchCase,
  $MatchWholeWord,$MatchWildcards,$MatchSoundsLike,
  $MatchAllWordForms,$Forward,$Wrap,$Format, $Total_Time_Worked_Monday,
  $ReplaceAll)

}

if($Day_Of_Week -eq "Tuesday"){

$Today_Date = $Date.ToString('MM-dd-yy')

$Today_Date = [DateTime]$Today_Date

$Yesterday = $Today_Date.AddDays(-1)

$Yesterday = $Yesterday.ToString('MM-dd-yy')

$Find_Tuesday_Date = “Tuesday-Date”

$Replace_Tuesday_Date = $Today_Date

$Document_Object = $Word_Object.Documents.Open(“$Desktop_Path\TimeSheets\Time-Sheet-Week-Of-Monday-$Yesterday.doc”)
$Object_Selection = $Word_Object.Selection

$ReplaceAll = 2
$FindContinue = 1
$MatchCase = $False
$MatchWholeWord = $True
$MatchWildcards = $False
$MatchSoundsLike = $False
$MatchAllWordForms = $False
$Forward = $True
$Wrap = $FindContinue
$Format = $False

$Object_Selection.Find.Execute($Find_Tuesday_Date, $MatchCase,
  $MatchWholeWord,$MatchWildcards,$MatchSoundsLike,
  $MatchAllWordForms,$Forward,$Wrap,$Format,$Replace_Tuesday_Date,
  $ReplaceAll)

}

if($Day_Of_Week -eq "Wednesday"){

$Today_Date = $Date.ToString('MM-dd-yy')

$Today_Date = [DateTime]$Today_Date

$Monday = $Today_Date.AddDays(-2)

$Monday = $Monday.ToString('MM-dd-yy')

$Find_Wednesday_Date = “Wednesday-Date”

$Find_Wednesday_Date = $Today_Date

$Document_Object = $Word_Object.Documents.Open(“$Desktop_Path\TimeSheets\Time-Sheet-Week-Of-Monday-$Monday.doc”)
$Object_Selection = $Word_Object.Selection

$ReplaceAll = 2
$FindContinue = 1
$MatchCase = $False
$MatchWholeWord = $True
$MatchWildcards = $False
$MatchSoundsLike = $False
$MatchAllWordForms = $False
$Forward = $True
$Wrap = $FindContinue
$Format = $False

$Object_Selection.Find.Execute($Find_Wednesday_Date, $MatchCase,
  $MatchWholeWord,$MatchWildcards,$MatchSoundsLike,
  $MatchAllWordForms,$Forward,$Wrap,$Format,$Replace_Wednesday_Date,
  $ReplaceAll)

}

if($Day_Of_Week -eq "Thursday"){

$Today_Date = $Date.ToString('MM-dd-yy')

$Today_Date = [DateTime]$Today_Date

$Monday = $Today_Date.AddDays(-3)

$Monday = $Monday.ToString('MM-dd-yy')

$Find_Thursday_Date = “Thursday-Date”

$Find_Wednesday_Date = $Today_Date

$Document_Object = $Word_Object.Documents.Open(“$Desktop_Path\TimeSheets\Time-Sheet-Week-Of-Monday-$Monday.doc”)
$Object_Selection = $Word_Object.Selection

$ReplaceAll = 2
$FindContinue = 1
$MatchCase = $False
$MatchWholeWord = $True
$MatchWildcards = $False
$MatchSoundsLike = $False
$MatchAllWordForms = $False
$Forward = $True
$Wrap = $FindContinue
$Format = $False

$Object_Selection.Find.Execute($Find_Thursday_Date, $MatchCase,
  $MatchWholeWord,$MatchWildcards,$MatchSoundsLike,
  $MatchAllWordForms,$Forward,$Wrap,$Format,$Replace_Thursday_Date,
  $ReplaceAll)

}

if($Day_Of_Week -eq "Friday"){

$Today_Date = $Date.ToString('MM-dd-yy')

$Today_Date = [DateTime]$Today_Date

$Monday = $Today_Date.AddDays(-3)

$Monday = $Monday.ToString('MM-dd-yy')

$Find_Friday_Date = “Friday-Date”

$Find_Friday_Date = $Today_Date

$Document_Object = $Word_Object.Documents.Open(“$Desktop_Path\TimeSheets\Time-Sheet-Week-Of-Monday-$Monday.doc”)
$Object_Selection = $Word_Object.Selection

$ReplaceAll = 2
$FindContinue = 1
$MatchCase = $False
$MatchWholeWord = $True
$MatchWildcards = $False
$MatchSoundsLike = $False
$MatchAllWordForms = $False
$Forward = $True
$Wrap = $FindContinue
$Format = $False

$Object_Selection.Find.Execute($Find_Friday_Date, $MatchCase,
  $MatchWholeWord,$MatchWildcards,$MatchSoundsLike,
  $MatchAllWordForms,$Forward,$Wrap,$Format,$Replace_Friday_Date,
  $ReplaceAll)

}

$Document_Object = $Word_Object.Documents.Open(“$Desktop_Path\TimeSheets\Time-Sheet-Week-Of-Monday-$Today_Date.doc”)

$Monday_Time = $Document_Object.Tables[1].Cell(3,2).range.text

Write-Host $Doc_Table

Stop-Process -Name "*Microsoft Word*"
