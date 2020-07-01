#
# https://support.industry.siemens.com/cs/document/18490004/which-microsoft-updates-have-been-tested-for-compatibility-with-simatic-pcs-7-?dti=0&lc=en-AE
#

$excel_url = "https://support.industry.siemens.com/cs/attachments/18490004/security_patches_iec.xls"

Remove-Item -Path .\pach_list.xls
Remove-Item -Path .\pach_list.csv
Remove-Item -Path .\baklist.txt

Invoke-WebRequest -uri $excel_url -outfile .\pach_list.xls

Function ExcelToCsv ($File) {
    $myDir = $PSScriptRoot
    $excelFile = "$myDir\" + $File
    $csv_file = $file.split(".")[0] +  ".csv"
    $Excel = New-Object -ComObject Excel.Application
    $wb = $Excel.Workbooks.Open($excelFile)

    foreach ($ws in $wb.Worksheets) {
        $ws.SaveAs("$myDir\" + $csv_file, 6)
    }
    $Excel.Quit()
}

ExcelToCsv "pach_list.xls"

$csv_data = Import-Csv -Path .\pach_list.csv

$kblist = $csv_data | Where-Object {$_.FailedProduct -eq 'PCS7Vxy' } | Select-Object -Property PatchIdentifier1

$kblist.PatchIdentifier1 |Out-File baklist.txt

