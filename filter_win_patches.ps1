#
# https://support.industry.siemens.com/cs/document/18490004/which-microsoft-updates-have-been-tested-for-compatibility-with-simatic-pcs-7-?dti=0&lc=en-AE
#

$excel_url = "https://support.industry.siemens.com/cs/attachments/18490004s/"

$src_filename = "security_patches_iec.zip"
$target_folder = $PSScriptRoot + "\tmp\"
$out_file = $target_folder + "baklist.txt"

if (-Not (Test-Path $target_folder)){
    $folder = New-Item -Path $target_folder -ItemType Directory
} else {
    Get-ChildItem -Path $target_folder | Remove-Item
}


try {
    Invoke-WebRequest -uri ($excel_url + $src_filename) -outfile ($target_folder + $src_filename)
}
catch {
    $error_msg = "can not download filte from " + $excel_url + $src_filename
    Write-Error -Message $error_msg -Category ResourceUnavailable
    Break
}


Expand-Archive  ($target_folder + $src_filename) -DestinationPath $target_folder
$xlm_file = (Get-ChildItem $target_folder -Filter *.xml).FullName
[xml]$data = Get-Content -path $xlm_file

$csv_data = $data.PatchData.PatchVendor.Patch

$kblist = $csv_data | Where-Object {$_.FailedProduct -eq 'PCS7Vxy' } | Select-Object -Property PatchIdentifier1

$kblist.PatchIdentifier1 |Out-File $out_file

