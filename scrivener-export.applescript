on run argv
    set theDate to the ((current date) as «class isot» as string)
    set exportPath to item 1 of argv

    tell application "System Events"
      set frontmostProcess to first process where it is frontmost

      tell process "Scrivener"
        set frontmost to true
        set projectName to name of front window

        -- select the right UI state. prefer keyboard.
        -- select binder
        -- click menu item "Binder" of menu 1 of menu item "Move Focus To" of menu "Navigate" of menu bar 1
        keystroke "B" using {control down, option down, command down}
        click menu item "Reveal Draft Folder" of menu "Navigate" of menu bar 1

        -- export
        click menu item "Files..." of menu 1 of menu item "Export" of menu "File" of menu bar 1
        -- keystroke "E" using {shift down, command down}

        -- enter temp file name
        delay 0.5
        keystroke theDate
        keystroke "|"
        keystroke projectName

        -- navigate to the scratch folder
        delay 0.5
        keystroke "G" using {shift down, command down}
        keystroke exportPath
        keystroke return

        -- export files
        delay 1.0
        keystroke return
        delay 1.5
      end tell

      -- switch back to the initial process
      set frontmost of frontmostProcess to true
    end tell

end run
