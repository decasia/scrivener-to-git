on run argv
    set exportPath to item 1 of argv

    tell application "System Events"
      set frontmostProcess to first process where it is frontmost

      tell process "Scrivener"
        set frontmost to true
        set projectName to name of front window

        -- select Draft
        click menu item "Draft" of menu 1 of menu item "Go To" of menu "Navigate" of menu bar 1
        delay 1.5

        -- export
        click menu item "Files..." of menu 1 of menu item "Export" of menu "File" of menu bar 1
        -- keystroke "E" using {shift down, command down}

        -- navigate to the scratch folder
        delay 0.5
        keystroke "G" using {shift down, command down}
        keystroke exportPath
        keystroke return

        -- export files
        delay 1.5
        keystroke return
        delay 1.5
      end tell

      -- switch back to the initial process
      set frontmost of frontmostProcess to true
    end tell

    return projectName & "/OK"
end run
