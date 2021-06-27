

# moviesup 
# walks through folders, picks up movies, renames them with the name of the folder, then moves them one folder up


$source = $args[0]
$target = ( Get-Item $source )

"target: " + $target.FullName

$skip = 'movies'

#get top level folder
$folders = Get-ChildItem -Directory -path $source 

#top level
foreach ( $f in $folders )
{
    # skip reserved names
    # if ( $folder.Name.ToLower() -like '*movies*') {continue}

    # if we have the movie here 
    $path = ($f.FullName + '\*.*')
    $files = Get-ChildItem -Path $path -Include *.avi,*.mpeg,*.mp4,*.mov,*.wmv,*.m4v,*.flv,*.mkv

    if ( $files.Count -gt 0 )
    {
        foreach ( $file in $files ) 
        {
            # $path

            $newName = $f.Name + $file.extension

            $title    = $f.Name
            $question = 'Rename   ' + $file.Name + '    to    ' + $newName
            $choices  = '&Yes', '&No'

            $decision = $Host.UI.PromptForChoice("confirm", $question, $choices, 1)
            if ($decision -eq 0) {
                # Write-Host 'confirmed'

                $newPath = Join-Path -Path $target.FullName -ChildPath $newName
            } else {
                
                $newPath = Join-Path -Path $target.FullName -ChildPath $file.Name
            }

            "movin " + $file.FullName
            "moving to " + $newPath

            Move-Item -Path $file.FullName -Destination $newPath
        }


    }

}


