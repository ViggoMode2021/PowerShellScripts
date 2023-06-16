$objWord = New-Object -ComObject word.application
$objWord.Visible = $True
$objDoc = $objWord.Documents.Open(“C:\Users\rviglione\Desktop\Blank-Time-Sheet.doc”)
$objSelection = $objWord.Selection

$Date = Get-Date
$Today_Date = $Date.ToString('MM/dd/yy')

$Find_Monday_Date = “Monday-Date”
$Replace_Monday_Date = “$Today_Date”

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

$objSelection.Find.Execute($Find_Monday_Date,$MatchCase,
  $MatchWholeWord,$MatchWildcards,$MatchSoundsLike,
  $MatchAllWordForms,$Forward,$Wrap,$Format,
  $Replace_Monday_Date,$ReplaceAll)
