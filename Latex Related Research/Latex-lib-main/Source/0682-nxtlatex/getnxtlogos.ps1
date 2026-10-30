# getnxtlogos.ps1 -- Hochschullogo und Skyline herunterladen und installieren
# Funktioniert auf Windows mit TeX Live oder MiKTeX.
#
# Seit nxtlatex 1.3 stecken die NXT-Logos im NXT Logo Font. Gebraucht
# werden die Dateien nur noch für Brief und Folien (Logo_HSRT_Grau.pdf,
# hsrtskyline.pdf); das Archiv enthält für ältere Fassungen weiterhin
# auch die NXT-Logos als PDF.

$Url = "https://www.reutlingen-university.de/fileadmin/NXT/Unsere_Fakultaet/Dateien/nxtlatex-logos.zip"

# Zielverzeichnis: TeX Live und MiKTeX verwenden beide ~/texmf als User-Baum
$TexmfRoot = Join-Path $env:USERPROFILE "texmf"
$TexmfTarget = Join-Path $TexmfRoot "tex\latex\nxtlatex"

Write-Host "==> Zielverzeichnis: $TexmfTarget"
New-Item -ItemType Directory -Force -Path $TexmfTarget | Out-Null

# Herunterladen
$TmpFile = Join-Path $env:TEMP "nxtlatex-logos.zip"
Write-Host "==> Lade $Url ..."
try {
    Invoke-WebRequest -Uri $Url -OutFile $TmpFile -UseBasicParsing
} catch {
    Write-Error "Fehler beim Herunterladen: $_"
    exit 1
}

# Entpacken
Write-Host "==> Entpacke nach $TexmfTarget ..."
Expand-Archive -Path $TmpFile -DestinationPath $TexmfTarget -Force
Remove-Item $TmpFile

# TeX-Dateidatenbank aktualisieren
if (Get-Command mktexlsr -ErrorAction SilentlyContinue) {
    Write-Host "==> Aktualisiere TeX-Dateidatenbank (TeX Live) ..."
    mktexlsr $TexmfRoot
} elseif (Get-Command initexmf -ErrorAction SilentlyContinue) {
    Write-Host "==> Aktualisiere TeX-Dateidatenbank (MiKTeX) ..."
    initexmf --update-fndb
}

Write-Host "==> Fertig."
