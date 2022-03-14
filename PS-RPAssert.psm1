function Assert-RPNetConnection
{
    param (
        [Parameter (Mandatory = $false )] [String] $ComputerName = "internetbeacon.msedge.net"
    )
    
    if(-not (Test-NetConnection -ComputerName $ComputerName -InformationLevel Quiet -WarningAction SilentlyContinue -ErrorAction SilentlyContinue))
    {
        Write-Error -Message "No connection to $($ComputerName)"
    }
}
function Assert-RPIsPath
{
    param(
        [Parameter (Mandatory = $true )] [String] $Path,
        [Parameter (Mandatory = $false)] [Switch] $IsValid = $false
    )

    if($IsValid)
    {
        if(-not (Test-Path -Path $Path -IsValid))
        {
            Write-Error -Message "$($Path) is not a valid path"
        }
    }
    else
    {
        if(-not (Test-Path -Path $Path))
        {
            Write-Error -Message "$($Path) does not exist"
        }
    }
}
function Assert-RPIsFile
{
    param(
        [Parameter (Mandatory = $true )] [String] $Path
    )

    Assert-RPIsPath -Path $Path -IsValid
    Assert-RPIsPath -Path $Path
    if(-not (Test-Path -Path $Path -PathType Leaf))
    {
        Write-Error -Message "$($Path) is not a file"
    }
}
function Assert-RPIsDirectory
{
    param(
        [Parameter (Mandatory = $true )] [String] $Path
    )

    Assert-RPIsPath -Path $Path -IsValid
    Assert-RPIsPath -Path $Path
    if(-not (Test-Path -Path $Path -PathType Directory))
    {
        Write-Error -Message "$($Path) is not a directory"
    }
}