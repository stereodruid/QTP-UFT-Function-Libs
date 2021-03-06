﻿
' *******************************************************************************************
' VBScript Header, &copy; 2005-2017
' Name:
'		isFileExist
' Input:
'		ByVal pStrFilename As String - Absolute Path of the File incl. Filename
' Output:
'		Returns True if a specified file exists; False if it does not.
' Purpose:
'		Checks if a File exists
' Remarks:
'		-
' Author:
'		
' History:
'		Date – Version - Change
' *******************************************************************************************
Function isFileExist(ByVal pStrFilename)
	Dim lObjFilesys
	Set lObjFilesys = CreateObject("Scripting.FileSystemObject")
	isFileExist = lObjFilesys.FileExists(pStrFilename)
	Set lObjFilesys = Nothing
End Function
' #############################################################################################
' VBScript Header, &copy; 2009-2017
' Name:
'		GetFile
' Input:
'		FileName As String (Filepath)
' Output:
'		-
' Purpose:
'		This Function will get Content from a textbased File(Read text file)
' Remarks:
' History:
'		Date – Version - Change
' ##############################################################################################
function GetFile(FileName)
  If FileName<>"" Then
    Dim FS, FileStream
    Set FS = CreateObject("Scripting.FileSystemObject")
      on error resume Next
      Set FileStream = FS.OpenTextFile(FileName)
      GetFile = FileStream.ReadAll
  End If
End Function
' *******************************************************************************************
' VBScript Header, &copy; 2005-2017
' Name:
'		isFolderExist
' Input:
'		ByVal pStrFolderName As String - Absolute Path of the Folder
' Output:
'		Returns True if a specified folder exists; False if it does not.
' Purpose:
'		Checks if a folder exists
' Remarks:
'		-
' Author:
'		
' History:
'		Date – Version - Change
' *******************************************************************************************
Function isFolderExist(ByVal pStrFolderName)
	Dim lObjFilesys
	Set lObjFilesys = CreateObject("Scripting.FileSystemObject")
	isFolderExist = lObjFilesys.FolderExists(pStrFolderName)
	Set lObjFilesys = Nothing
End Function


' *******************************************************************************************
' VBScript Header, &copy; 2005-2017
' Name:
'		deleteFile
' Input:
'		ByVal pStrFilename As String - Absolute Path of the File incl. Filename
' Output:
'		-
' Purpose:
'		Delete a File
' Remarks:
'		-
' Author:
'		
' History:
'		Date – Version - Change
' *******************************************************************************************
Function deleteFile(pStrFilename)
	Dim lObjFilesys
	deleteFile = False
	Set lObjFilesys = CreateObject("Scripting.FileSystemObject")
	If lObjFilesys.FileExists(pStrFilename) Then
		If lObjFilesys.DeleteFile(pStrFilename, True) Then
			deleteFile = True
			Reporter.ReportEvent micDoen, "Datei wurde gelöscht werden", "Datei: " & pStrFilename &  " wurde gelöscht werden"
		Else
			Reporter.ReportEvent micDoen, "Datei konnte nicht gelöscht werden", "Datei: " & pStrFilename &  " konnte nicht gelöscht werden"
		End IF
	End If
	Set lObjFilesys = Nothing
End Function


' *******************************************************************************************
' VBScript Header, &copy; 2005-2017
' Name:
'		DeleteFilesInFolder
' Input:
'		ByVal pStrPfad As String - Absolute folderpath, in which the files should be deleted
' Output:
'		-
' Purpose:
'		Deletes all files in a folder. (Not recursive)
' Remarks:
'		-
' Author:
'		
' History:
'		Date – Version - Change
' *******************************************************************************************
Sub DeleteFilesInFolder(ByVal pStrPfad)
	Dim lObjFilesys
	Set lObjFilesys = CreateObject("Scripting.FileSystemObject")
	If lObjFilesys.FolderExists(pStrPfad) Then
		Dim lArrFiles
		Set lArrFiles = lObjFilesys.GetFolder(pStrPfad).Files
        Dim lObjFile 
		For each lObjFile In lArrFiles
			lObjFile.delete
        Next
		Set lObjFile = Nothing
	Else
		reporter.ReportEvent micFail, "Sub DeleteFilesInFolder", "Path doesn't exist"
    End If
	Set lObjFilesys = Nothing
End Sub


' *******************************************************************************************
' VBScript Header, &copy; 2005-2017
' Name:
'		getFilePathsFromFolder
' Input:
'		ByVal pStrPfad As String - Absolute folderpath
' Output:
'		Array with all filepaths in the directory 
' Purpose:
'		returns all filepaths in directory
' Remarks:
'		-
' Author:
'		
' History:
'		Date – Version - Change
' *******************************************************************************************
Function getFilePathsFromFolder(pStrPfad)
	Dim lObjFilesys
	Set lObjFilesys = CreateObject("Scripting.FileSystemObject")
	If lObjFilesys.FolderExists(pStrPfad) Then
		Dim i
		Dim lObjFile, lArrFiles
		Set lArrFiles = lObjFilesys.GetFolder(pStrPfad).Files
		Dim MyArr()
		ReDim MyArr(lArrFiles.Count-1)
		i=0
		For each lObjFile In lArrFiles
			MyArr(i)= lObjFile.Path
			i = i+1
		Next
		Set lArrFiles = Nothing
		getFilePathsFromFolder = MyArr
	Else
		reporter.ReportEvent micFail, "Function getFilePathsFromFolder", "Path doesn't exist"
		getFilePathsFromFolder = Empty
	End If
	Set lObjFilesys = Nothing
End Function


' *******************************************************************************************
' VBScript Header, &copy; 2005-2017
' Name:
'		getAllTextFromFile
' Input:
'		ByVal pStrfilepath As String - Absolute filepath
' Output:
'		content of file 
' Purpose:
'		Returns the whole content of a the textfile
' Remarks:
'		-
' Author:
'		
' History:
'		Date – Version - Change
' *******************************************************************************************
Function getAllTextFromFile(ByVal pStrfilepath)
	Dim lIntForReading
	Dim lObjFilesys, lObjFileStrm
	lIntForReading = 1
	Set lObjFilesys = CreateObject("Scripting.FileSystemObject")
	Set lObjFileStrm = lObjFilesys.OpenTextFile(pStrfilepath, lIntForReading, False, TristateUseDefault)
	getAllTextFromFile = lObjFileStrm.ReadAll
	lObjFileStrm.Close
	Set lObjFilesys = Nothing
	Set lObjFileStrm = Nothing
End Function


' *******************************************************************************************
' VBScript Header, &copy; 2005-2017
' Name:
'		SaveFile
' Input:
'		ByRef pStrText As String - text 		
'		ByVal pStrFilepath As String - Absolute filepath
' Output:
'		-
' Purpose:
'		Writes text into a textfile.
' Remarks:
'		-
' Author:
'		
' History:
'		Date – Version - Change
' *******************************************************************************************
Sub SaveFile(ByRef pStrText, ByVal pStrFilepath)
	Dim lObjFilesys, lObjFileStrm
	Dim lIntForReading, lIntForWriting, lIntForAppending
	Dim lArrPath
	Dim lStrTmp
	lIntForReading = 1	' Set constants is absolutly nessary!
	lIntForWriting = 2
	lIntForAppending = 8
	Set lObjFilesys = CreateObject("Scripting.FileSystemObject")

    lArrPath = Split(pStrFilepath, "\", -1, 1)
	Dim i
	For i=0 To UBound(lArrPath)-1
		lStrTmp = lStrTmp & lArrPath(i) & "\"
		If not lObjFilesys.FolderExists(lStrTmp) Then
			lObjFilesys.CreateFolder(lStrTmp)
		End If
	Next
	'			OpenTextFile(filename,     iomode, create, format)
	Set lObjFileStrm = lObjFilesys.OpenTextFile(pStrFilepath, lIntForWriting, True, TristateUseDefault)	
	lObjFileStrm.Write(pStrText)
	lObjFileStrm.close
	Set lObjFilesys = Nothing
	
End Sub

' *******************************************************************************************
' VBScript Header, &copy; 2005-2017
' Name:
'		CreateFolder
' Input:
'		ByVal pStrFolderPath As String - Absolute folderpath
' Output:
'		-
' Purpose:
'		Creates Folder
' Remarks:
'		-
' Author:
'		
' History:
'		Date – Version - Change
' *******************************************************************************************
Sub CreateFolder(ByVal pStrFolderPath)
	Dim lObjFilesys
	Dim lArrPath
	Dim lStrTmp
	Set lObjFilesys = CreateObject("Scripting.FileSystemObject")

	If right(pStrFolderPath, 1) = "\" Then
		pStrFolderPath = Left(pStrFolderPath, Len(pStrFolderPath)-1)
	End If
    lArrPath = Split(pStrFolderPath, "\", -1, 1)
	Dim i
	For i=0 To UBound(lArrPath)
		lStrTmp = lStrTmp & lArrPath(i) & "\"
		If not lObjFilesys.FolderExists(lStrTmp) Then
			lObjFilesys.CreateFolder(lStrTmp)
		End If
	Next
	Set lObjFilesys = Nothing
	
End Sub


' *******************************************************************************************
' VBScript Header, &copy; 2005-2017
' Name:
'		DeleteAllFilesAndFolder
' Input:
'		ByVal pStrPfad As String - Absolute folderpath
' Output:
'		String with pahts, where an error occur
' Purpose:
'		Deletes files and folders (recursive)
' Remarks:
'		-
' Author:
'		
' History:
'		Date – Version - Change
' *******************************************************************************************
Function DeleteAllFilesAndFolder(ByVal pStrPfad)
	On Error Resume Next
	Dim lObjFilesys
	Dim lobjFolder,lobjPFolder, lobjFile
	Dim lobjSubFolders 
	Dim lStrErrPaths
	
	Set lObjFilesys = CreateObject("Scripting.FileSystemObject")
	Set lobjPFolder = lObjFilesys.GetFolder(pStrPfad)
	

	Set lobjSubFolders = lobjPFolder.SubFolders

	For each lobjFolder in lobjSubFolders
		
		lStrErrPaths = lStrErrPaths & DeleteAllFilesAndFolder(lobjFolder.Path)
		
		lobjFolder.Delete True
		if Err.Number <> 0 Then
			'Wscript.Echo lobjFolder.Name & " " & Err.Number & " " & Err.Description
			lStrErrPaths = lStrErrPaths & lobjFolder.Path & "\" & vbcrlf
			Err.Clear
		End if
	Next

	For each lobjFile in lobjPFolder.Files
		lobjFile.Delete True
		if Err.Number <> 0 Then
			lStrErrPaths = lStrErrPaths & lobjFile.Path & vbcrlf
			'Wscript.Echo lobjFile.Name & " " & Err.Number & " " & Err.Description
		Err.Clear
	End if
	Next
	DeleteAllFilesAndFolder = lStrErrPaths
	On Error Goto 0
End Function

' *******************************************************************************************
' VBScript Header, &copy; 2005-2017
' Name:
'		getSpecialFolderPath
' Input:
'		ByVal pStrFolder As String - e. g. TemporaryFolder|SystemFolder|WindowsFolder|AllUsersDesktop|AllUsersStartMenu|AllUsersPrograms|Startup|Templates|
'																			AllUsersStartup|Desktop|Favorites|Fonts|MyDocuments|NetHood|PrintHood|Programs|Recent|SendTo|StartMenu|Startup|Templates
' Output:
'		Folderpath
' Purpose:
'		Returns the Path of a special Folder
' Remarks:
'		-
' Author:
'		
' History:
'		Date – Version - Change
' *******************************************************************************************
Function getSpecialFolderPath(ByVal pStrFolder)
		
	Set lObjFso = CreateObject("Scripting.FileSystemObject")
	set lObjWshShell = CreateObject("WScript.Shell")

	Select Case LCase(pStrFolder)
			getSpecialFolderPath = lObjFso.GetSpecialFolder(2)						
		Case("systemfolder")		'C:\Windows\System32
			getSpecialFolderPath = lObjFso.GetSpecialFolder(1)						
		Case("windowsfolder")		'C:\Windows
			getSpecialFolderPath = lObjFso.GetSpecialFolder(0)						
		Case("allusersdesktop")		'C:\Users\Public\Desktop
			getSpecialFolderPath = lObjWshShell.SpecialFolders("AllUsersDesktop")	
		Case("allusersstartmenu")	'C:\ProgramData\Microsoft\Windows\Start Menu
			getSpecialFolderPath = lObjWshShell.SpecialFolders("AllUsersStartMenu")	
		Case("allusersprograms")	'C:\ProgramData\Microsoft\Windows\Start Menu\Programs
			getSpecialFolderPath = lObjWshShell.SpecialFolders("AllUsersPrograms")	
		Case("allusersstartup")			'C:\ProgramData\Microsoft\Windows\Start Menu\Programs\Startup
			getSpecialFolderPath = lObjWshShell.SpecialFolders("AllUsersStartup")	
		Case("fonts")							'C:\Windows\Fonts
			getSpecialFolderPath = lObjWshShell.SpecialFolders("Fonts")				
		Case("mydocuments")			
			getSpecialFolderPath = lObjWshShell.SpecialFolders("MyDocuments")		
		Case("programs")				
			getSpecialFolderPath = lObjWshShell.SpecialFolders("Programs")			
		Case("sendto")						
			getSpecialFolderPath = lObjWshShell.SpecialFolders("SendTo")			
		Case Else
			getSpecialFolderPath = Empty
	End Select
	Set lObjFso = Nothing
	set lObjWshShell = Nothing

End Function

' *******************************************************************************************
' VBScript Header, &copy; 2005-2017
' Name:
'		DeleteFolder
' Input:
'		ByVal pStrPfad As String - Absolute Path of the Folder
' Output:
'		True when exists, False when not exists
' Purpose:
'		Deletes a folder if exists
' Remarks:
'		-
' Author:
'		
' History:
'		Date – Version - Change
' *******************************************************************************************
Function DeleteFolder(ByVal pStrPfad)
	Dim lObjFilesys
	Set lObjFilesys = CreateObject("Scripting.FileSystemObject")
	
	If lObjFilesys.FolderExists(pStrPfad) Then
		lObjFilesys.DeleteFolder pStrPfad, True 
		DeleteFolder = True
	Else
		reporter.ReportEvent micDone, "Sub DeleteFilesInFolder", "Path doesn't exist"	
		DeleteFolder = False
	End If
	Set lObjFilesys = Nothing
End Function
