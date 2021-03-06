$repoRoot = (Resolve-Path "$PSScriptRoot\..\..").Path;
Describe 'Linting\FileEncoding' {

    $excludedPaths = @(
                        '.git*',
                        '.vscode',
                        'Release',
                        '*.png',
                        'TestResults.xml'
                    );

    function TestEncodingPath {
        [CmdletBinding()]
        param (
            [Parameter(Mandatory, ValueFromPipeline)]
            [System.String] $Path,

            [System.String[]] $Exclude
        )
        process
        {
            $WarningPreference = 'SilentlyContinue'
            Get-ChildItem -Path $Path -Exclude $Exclude |
                ForEach-Object {
                    if ($_ -is [System.IO.FileInfo])
                    {
                        It "File '$($_.FullName.Replace($repoRoot,''))' uses UTF-8 (no BOM) encoding" {
                            $encoding = (Get-FileEncoding -Path $_.FullName -WarningAction SilentlyContinue).HeaderName
                            $encoding | Should Be 'us-ascii'
                        }
                    }
                    elseif ($_ -is [System.IO.DirectoryInfo])
                    {
                        TestEncodingPath -Path $_.FullName -Exclude $Exclude
                    }
                }
        } #end process
    } #end function

    Import-Module VirtualEngine.Build -Force

    Get-ChildItem -Path $repoRoot -Exclude $excludedPaths |
        ForEach-Object {
            TestEncodingPath -Path $_.FullName -Exclude $excludedPaths
        }

}
