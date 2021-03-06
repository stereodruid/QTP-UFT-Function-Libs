Public Const cStrIgnore = "<Ignore>"


' #############################################################################################
' VBScript Header, &copy; 2009-2017
' Name:
'		getTextPos
' Input:
'		obj As String, txt As String
' Output:
'		Array As ArrayArray(l, t, r, b)(Integer)
' Purpose:,0
'		This Function will search for visible text and return the coordinates of firstl Lette from founded Text.
' Remarks:
' History:
'		Date – Version - Change
' #############################################################################################
Function getTextPos(obj, txt)
	dim a, l, t, r, b
	l = -1
	t = -1
	r = -1
	b = -1
	a = obj.GetTextLocation(txt, l, t, r, b)
	getTextPos = Array(l, t, r, b)
End Function


' #############################################################################################
' VBScript Header, &copy; 2009-2017
' Name:
'		strToBool
' Input:
'		txt As String
' Output:
'		bool
' Purpose:,0
'		This Function will convert strings(bol:) and return a bool val.
' Remarks:
' History:
'		Date – Version - Change
' #############################################################################################
Public Function strToBool(str)
	Select Case lcase(str)
		Case "false"
			strToBool = false
		Case "f"
			strToBool = false
		Case "0"
			strToBool = false
		Case "true"
			strToBool = true
		Case "t"
			strToBool = true
		Case "1"
		strToBool = true
		Case Else
			strToBool = false
	End Select
End Function
' #############################################################################################
' VBScript Header, &copy; 2015-2099
' Name:
'		cleanAStringByRegEx
' Input:
'		Sting(Source string to be parsed ), String(Pattern condition as String)
' Output:
'		returns the source string, without the pattern result
' Purpose:
'		Get a part of an string
' Remarks:
'		Call it like: cleanAStringByRegEx("This is your Chicken time" " Chicken.*"), Result: This is your time"
' History:
'		04.11.17  Initial
' #############################################################################################
Function cleanAStringByRegEx(strSoruceString, strRegExPattern)
	 ' Create RegExp instance.
	 Set objRegEx = New RegExp
	 ' Define regular expression pattern.
	 objRegEx.Pattern = strRegExPattern 
	 ' Set global search flag
	 objRegEx.Global = True
	 ' Perform replace operation
	 strSoruceString = objRegEx.Replace(strSoruceString, "")
	 cleanAStringByRegEx = strSoruceString
	Set objRegEx = Nothing
End Function
    
' -----------------------------------------------------
' ---- Sub RunHere(theCommandLine, theWorkingDirectory)
' -----------------------------------------------------
 ' #############################################################################################
' VBScript Header, &copy; 2015-2017
' Name:
'		RunHere
' Input:
'		Sting(strCommand, strPath )
' Output:
'		None
' Purpose:
'		execute a command in a specified working directory
' Remarks:
'		RunHere, executes a command in the specified working directory and then changes back to the original directory.
' History:
'		21.09.16  Initial
' #############################################################################################
Function RunHere(theCommandLine, theWorkingDirectory)
 
	Const WAITIng = True
 
	Dim objSh, strPopd
 
	On Error Resume Next
	Set objSh = WScript.CreateObject("WScript.Shell")
	strPopd = objSh.CurrentDirectory
	objSh.CurrentDirectory = theWorkingDirectory
	objSh.Run  theCommandLine, 1 , WAITIng
	objSh.CurrentDirectory = strPopd
	Set objSh = Nothing
	On Error GoTo 0
 
End Function

' #############################################################################################
' VBScript Header, &copy; 2009-2017
' Name:
'		HTTPPost
' Input:
'		sUrl As strLink("http://xxx/xxx/xxx") 
'		sRequest As Strin  (Seconds to wait)
' Output:
'		-
' Purpose:
'		This Function will push a request

' History:
'		Date – Version - Change
' #############################################################################################
'	Sample post:
'	Dim res
'	res = HTTPPost("http://xxx/xxx/xxx", "1,1,1,2013-01-01T12:00,2013-01-01T12:22")

Function HTTPPost(sUrl, sRequest)
  set oHTTP = CreateObject("Microsoft.XMLHTTP")
  oHTTP.open "POST", sUrl,false
  oHTTP.setRequestHeader "Content-Type", "text/csv"
  oHTTP.setRequestHeader "Content-Length", Len(sRequest)
  oHTTP.send sRequest
  'HTTPPost = oHTTP.responseText
  HTTPPost = CStr(oHTTP.Status)
 End Function
 

' *******************************************************************************************
' VBScript Header, &copy; 2005-2017
'
' Name:
'		isIgnore
' Input:
'		ByVal pStrval As String - String being checked
' Output:
'		Returns True when  pStrval is equal to cStrIgnore otherwise FALSE
' Purpose:
'		Checks if  the parameter pStrval is equal to constant cStrIgnore
' Remarks:
' History:
'		Date – Version - Change
' *******************************************************************************************
Public Function isIgnore(ByVal pStrval)
   If LCase(pStrval) = LCase(cStrIgnore) Then
	   isIgnore = True
   Else
		isIgnore = False
   End If
End Function


' *******************************************************************************************
' VBScript Header, &copy; 2005-2017
' Name:
'		isNotIgnore
' Input:
'		ByVal pStrval As String - String being checked
' Output:
'		Returns True when  pStrval is not equal to cStrIgnore otherwise FALSE
' Purpose:
'		Checks if  the parameter pStrval is not equal to constant cStrIgnore
' Remarks:
'		Function isIgnore
' History:
'		Date – Version - Change
' *******************************************************************************************
Public Function isNotIgnore(ByVal pStrval)
   isNotIgnore = not isIgnore(pStrval)
End Function

' *******************************************************************************************
' VBScript Header, &copy; 2005-2017
' Name:
'		ReportScrn
' Input:
'		Byref  pObj As Object - 	Object from which to get a screenshot
'		ByVal pStrStatus As String - Reporter status
'		ByVal pStrStepName As String - Reporter step name
'		ByVal pStrDetails As String - Reporter details description
' Output:
'		-
' Purpose:
'		Reporter with Screenshot
' Remarks:
' Author:
'		TQA
' History:
'		Date – Version - Change
' *******************************************************************************************
Public Sub ReportScrn(Byref pObj, pStrStatus, pStrStepName, pStrDetails)

	pathm = Reporter.ReportPath & "\" & getTimeStamp_YYYYMMDD_HHmmssSS & ".png"
	
	pObj.CaptureBitmap pathm,True 
	'Reporter.ReportEvent micDone, pObject_snap, "<p align='center'>&nbsp</p><img src='" & pathm & "'>;&gt;"
	'Reporter.ReportEvent pStrStatus, pStrStepName, pStrDetails & "<p align='center'>&nbsp</p><img src='" & pathm & "'>;&gt;", pObj
	Reporter.ReportEvent pStrStatus, pStrStepName, pStrDetails, pathm
End Sub



' *******************************************************************************************
' VBScript Header, &copy; 2005-2017
' Name:
'		WaitUntilExist
' Input:
'		ByRef pObj As Object - At this object the exist method is called
'		ByVal pIntDuration As Integer - Defines the timeout for waiting of the object [seconds]
'		ByVal pIntWaitIteration As Integer - Time of waiting for one Iteration [milliseconds]
' Output:
'		Existence of the object (Boolean)
' Purpose:
'		Waiting for an object until it exists
' Remarks:
'		-
' Author:
' History:
'		Date – Version - Change
' *******************************************************************************************
Function WaitUntilExist(ByRef pObj, ByVal pIntDuration, ByVal pIntWaitIteration)
    Dim lIntOldFilter
	Dim lStrObjectName
	Dim lDblStartTimer, lDblEndTimer
	
	lIntOldFilter = Reporter.Filter 
	Reporter.Filter = 2 'rfEnableErrorsOnly 
	lStrObjectName = pObj.Tostring()
	WaitUntilExist = False
	
	lDblStartTimer = Timer
	While (lDblEndTimer - lDblStartTimer) < pIntDuration
		pObj.RefreshObject
		If pObj.Exist(0) Then
			lDblEndTimer = Timer
			Reporter.Filter = lIntOldFilter
		Reporter.ReportEvent micDone, "WaitUntilExist: Objekt  gefunden" , lStrObjectName & " existiert. Wartezeit =  " & CDBL(lDblEndTimer - lDblStartTimer) & " Sekunden", pObj
			WaitUntilExist = True
			Exit Function
		End If

		wait 0, pIntWaitIteration
		lDblEndTimer = Timer
	Wend

	Reporter.Filter = lIntOldFilter
	Reporter.ReportEvent micDone, "WaitUntilExist (Timeout erreicht):" , lStrObjectName &  " existiert nicht. Wartezeit =  " & CDBL(lDblEndTimer - lDblStartTimer) & " Sekunden", pObj

End Function

'same here, supports two objects
Function WaitUntilExists(ByRef pObj, ByRef pObj2, ByVal pIntDuration, ByVal pIntWaitIteration)
    Dim lIntOldFilter
	Dim lStrObjectName, lStrObjectName2
	Dim lDblStartTimer, lDblEndTimer
	
	lIntOldFilter = Reporter.Filter 
	Reporter.Filter = 2 'rfEnableErrorsOnly 
	lStrObjectName = pObj.Tostring()
	lStrObjectName2 = pObj2.Tostring()
	WaitUntilExists = False
	
	lDblStartTimer = Timer
	While (lDblEndTimer - lDblStartTimer) < pIntDuration
		pObj.RefreshObject
		pObj2.RefreshObject	
		If pObj.Exist(0) Or pObj2.Exist(0) Then
			lDblEndTimer = Timer
			Reporter.Filter = lIntOldFilter
			Reporter.ReportEvent micDone, "WaitUntilExists: Objekt  gefunden" , lStrObjectName & " oder " & lStrObjectName2 &  " existiert. Wartezeit =  " & CDBL(lDblEndTimer - lDblStartTimer) & " Sekunden", pObj
			WaitUntilExists = True
			Exit Function
		End If

		wait 0, pIntWaitIteration
		lDblEndTimer = Timer
	Wend
	Reporter.Filter = lIntOldFilter
	Reporter.ReportEvent micDone, "WaitUntilExists (Timeout erreicht):" , lStrObjectName &  " existiert nicht. Wartezeit =  " & CDBL(lDblEndTimer - lDblStartTimer) & " Sekunden", pObj

End Function

' *******************************************************************************************
' VBScript Header, &copy; 2014
' Name:
'		WaitUntilExistsArrBool
' Input:
'		ByRef pObjArray As Object - At this object the exist method is called
'		ByVal pIntDuration As Integer - Defines the timout for waiting of the object [seconds]
'		ByVal pIntWaitIteration As Integer - Time of waiting for one Iteration [milliseconds]
' Output:
'		Existence of the first object found in the array pObjArray (Boolean)
' Purpose:
'		Waiting for an object until it exists
' Remarks:
'		-
' Author:
' History:
'		Date – Version - Change
' *******************************************************************************************
Function WaitUntilExistsArrBool(ByRef pObjArray, ByVal pIntDuration, ByVal pIntWaitIteration)
    Dim lIntOldFilter
	Dim lDblStartTimer, lDblEndTimer
	lIntOldFilter = Reporter.Filter 
	Reporter.Filter = 2 'rfEnableErrorsOnly 
	WaitUntilExistsArrBool = False

	lDblStartTimer = Timer
	While (lDblEndTimer - lDblStartTimer) < pIntDuration
		For each obj in pObjArray
			obj.RefreshObject
			If obj.Exist(0) Then
				lDblEndTimer = Timer
				Reporter.Filter = lIntOldFilter
				Reporter.ReportEvent micDone, "WaitUntilExistsArrBool: Objekt  gefunden" , obj.ToString() &  " existiert. Wartezeit =  " & CDBL(lDblEndTimer - lDblStartTimer) & " Sekunden", Obj
				WaitUntilExistsArrBool = True
				Exit Function
			End If
		Next
		
		wait 0, pIntWaitIteration
		lDblEndTimer = Timer
	Wend
	Reporter.Filter = lIntOldFilter
	
	For each obj in pObjArray
		Reporter.ReportEvent micDone, "WaitUntilExistsArrBool (Timeout erreicht):" , obj.ToString() & " existiert nicht. Wartezeit =  " & CDBL(lDblEndTimer - lDblStartTimer) & " Sekunden", obj
	Next
End Function

' *******************************************************************************************
' VBScript Header, &copy; 2014
' Name:
'		WaitWileOExistsArrBool
' Input:
'		ByRef pObjArray As Object - At this object the exist method is called
'		ByVal pIntDuration As Integer - Defines the timout for waiting of the object [seconds]
'		ByVal pIntWaitIteration As Integer - Time of waiting for one Iteration [milliseconds]
' Output:
'		Existence of all object found in the array pObjArray (Boolean)
' Purpose:
'		Waiting while any object in the array exists
' Remarks:
'		-
' Author:
' History:
'		Date – Version - Change
' *******************************************************************************************
Function WaitWileOExistsArrBool(ByRef pObjArray, ByVal pIntDuration, ByVal pIntWaitIteration)
    Dim lIntOldFilter, oIndex
	Dim lDblStartTimer, lDblEndTimer
	oIndex = UBound(pObjArray)
'	lIntOldFilter = Reporter.Filter 
'	Reporter.Filter = 2 'rfEnableErrorsOnly 
	WaitWileOExistsArrBool = False
	
	lDblStartTimer = Timer
	While (lDblEndTimer - lDblStartTimer) < pIntDuration and  oIndex > -1
	oIndex = UBound(pObjArray)	
		For each obj in pObjArray
			obj.RefreshObject
			If not obj.Exist(0) Then
				oIndex = oIndex - 1
				lDblEndTimer = Timer
			End If
		Next
		
		wait 0, pIntWaitIteration
		lDblEndTimer = Timer
	Wend
	
	If oIndex < 0 Then
		WaitWileOExistsArrBool = true
	End If	
End Function



' *******************************************************************************************
' VBScript Header, &copy; 2014
' Name:
'		WaitUntilExistsArrObj
' Input:
'		ByRef pObjArray As Object - At this object the exist method is called
'		ByVal pIntDuration As Integer - Defines the timout for waiting of the object [seconds]
'		ByVal pIntWaitIteration As Integer - Time of waiting for one Iteration [milliseconds]
' Output:
'		Existence of the first object found in the array pObjArray (Object or Nothing)
' Purpose:
'		Waiting for an object until it exists
' Remarks:
'		-
' History:
'		Date – Version - Change
' *******************************************************************************************


Function WaitUntilExistsArrObj(ByRef pObjArray, ByVal pIntDuration, ByVal pIntWaitIteration)
    Dim lIntOldFilter
	Dim lDblStartTimer, lDblEndTimer
	
	lIntOldFilter = Reporter.Filter 
	Reporter.Filter = 2 'rfEnableErrorsOnly 
	Set WaitUntilExistsArrObj = Nothing


	lDblStartTimer = Timer
	While (lDblEndTimer - lDblStartTimer) < pIntDuration
		For each obj in pObjArray
			obj.RefreshObject
			If obj.Exist(0) Then
				lDblEndTimer = Timer
				Reporter.Filter = lIntOldFilter
				Reporter.ReportEvent micDone, "WaitUntilExistsArrObj: Objekt  gefunden" , obj.ToString() &  " existiert. Wartezeit =  " & CDBL(lDblEndTimer - lDblStartTimer) & " Sekunden", Obj
				Set WaitUntilExistsArrObj = obj
				Exit Function
			End If
		Next
		
		wait 0, pIntWaitIteration
		lDblEndTimer = Timer
	Wend
	Reporter.Filter = lIntOldFilter
	
	For each obj in pObjArray
		Reporter.ReportEvent micDone, "WaitUntilExistsArrObj (Timeout erreicht):" , obj.ToString() & " existiert nicht. Wartezeit =  " & CDBL(lDblEndTimer - lDblStartTimer) & " Sekunden", obj
	Next

End Function



' *******************************************************************************************
' VBScript Header, &copy; 2005-2017
' Name:
'		WaitUntilValueExist
' Input:
'		ByRef pOb As Object - At this object the exist method is called
'		ByVal pStrPropertyName As String - Name of the propertey being checked
'		ByVal pStrCompareValue As String - Expected value
'		ByVal pIntDuration As Integer - Defines the timout for waiting of the object [seconds]
'		ByVal pIntWaitIteration As Integer - Time of waiting for one Iteration [milliseconds]
' Output:
'		Existence of the object (Boolean)
' Purpose:
'		Waiting for an object value until it exists
' Remarks:
'		Function Libary "QTP_String.qfl"
' History:
'		Date – Version - Change
' *******************************************************************************************
Function WaitUntilValueExist(ByRef pObj, ByVal pStrPropertyName, ByVal pStrCompareValue, ByVal pIntDuration, ByVal pIntWaitIteration)
    Dim lIntReporterFilter
	Dim lStrObjectName
	Dim lDblStartTimer, lDblEndTimer
	
	WaitUntilValueExist = False
    lIntReporterFilter = Reporter.Filter 
	Reporter.Filter = 2 'rfEnableErrorsOnly 
	lStrObjectName = pObj.Tostring()
 
	lDblStartTimer = Timer
	While (lDblEndTimer - lDblStartTimer) < pIntDuration
		pObj.RefreshObject
		If isMatch(pStrCompareValue, pObj.GetRoProperty(pStrPropertyName), False) Then
			lDblEndTimer = Timer
			Reporter.Filter = lIntReporterFilter
			Reporter.ReportEvent micDone, "WaitUntilValueExist: Objekt  gefunden" , lStrObjectName & " existiert. Wartezeit =  " & CDBL(lDblEndTimer - lDblStartTimer) & " Sekunden", pObj
			WaitUntilValueExist = True
			Exit Function
		End If

		wait 0, pIntWaitIteration
		lDblEndTimer = Timer
	Wend
	Reporter.Filter = lIntOldFilter
	Reporter.ReportEvent micDone, "WaitUntilValueExist (Timeout erreicht):" , lStrObjectName &  " existiert nicht. Wartezeit =  " & CDBL(lDblEndTimer - lDblStartTimer) & " Sekunden", pObj
End Function



' *******************************************************************************************
' VBScript Header, &copy; 2005-2017
' Name:
'		WaitWhileExist
' Input:
'		ByRef pObj As Object - At this object the exist method is called
'		ByVal pIntDuration As Integer - Defines the timout for waiting of the object [seconds]
'		ByVal pIntWaitIteration As Integer - Time of waiting for one Iteration [milliseconds]
' Output:
'		Existence of the object (Boolean)
' Purpose:
'		Waiting for an object while it exists
' Remarks:
'		-
' History:
'		Date – Version - Change
' *******************************************************************************************
Function WaitWhileExist(Byref pObj, pIntDuration, pIntWaitIteration)
	Dim lStrObjectName
	Dim lIntReporterFilter
	Dim lDblStartTimer, lDblEndTimer
	
	lIntReporterFilter = Reporter.Filter 
	Reporter.Filter = 2 'rfEnableErrorsOnly 
	lStrObjectName = pObj.Tostring()
	WaitWhileExist = False
	
	lDblStartTimer = Timer
	While (lDblEndTimer - lDblStartTimer) < pIntDuration
		pObj.RefreshObject
		If not pObj.exist(0) Then
			lDblEndTimer = Timer
			Reporter.Filter = lIntReporterFilter
			Reporter.ReportEvent micDone, "WaitWhileExist: Objekt nicht gefunden" , lStrObjectName & " existiert nicht. Wartezeit =  " & CDBL(lDblEndTimer - lDblStartTimer) & " Sekunden", pObj
			WaitWhileExist = True
			Exit Function
		End If

		wait 0, pIntWaitIteration
		lDblEndTimer = Timer
	Wend
   Reporter.Filter = lIntReporterFilter
   Reporter.ReportEvent micDone, "WaitWhileExist (Timeout erreicht):" , lStrObjectName &  " existiert. Wartezeit =  " & CDBL(lDblEndTimer - lDblStartTimer) & " Sekunden", pObj
End Function

' *******************************************************************************************
' VBScript Header, &copy; 2005-2017
' Name:
'		CopyToClipboard
' Input:
'		ByVal pObj As Object - Data which is to add to the Clipboard
' Output:
'		-
' Purpose:
'		Adds Data to the Clipboard
' Remarks:
'		-
' History:
'	Date – Version - Change
' *******************************************************************************************
Sub CopyToClipboard(ByVal pObj)
	Dim lObjClip
	Set lObjClip = DotNetFactory.CreateInstance("System.Windows.Forms.Clipboard")
	lObjClip.SetDataObject pObj
	Set lObjClip = Nothing
End Sub


' *******************************************************************************************
' VBScript Header, &copy; 2005-2017
' Name:
'		getTextFromClipboard
' Input:
'		-
' Output:
'		Text from the clipboard
' Purpose:
'		Adds Data to the Clipboard
' Remarks:
'		-
' History:
'		Date – Version - Change
' *******************************************************************************************
Function getTextFromClipboard()
	Dim lObjClip
	Set lObjClip = DotNetFactory.CreateInstance("System.Windows.Forms.Clipboard")
	getTextFromClipboard = lObjClip.GetText()
	Set lObjClip = Nothing
End Function

' *******************************************************************************************
' VBScript Header, &copy; 2005-2017
' Name:
'		ClearClipboard
' Input:
'		-
' Output:
'		-
' Purpose:
'		Clears the content of the Clipboard
' Remarks:
' History:
'		Date – Version - Change
' *******************************************************************************************
Sub ClearClipboard()
	Dim lObjClip
	Set lObjClip = DotNetFactory.CreateInstance("System.Windows.Forms.Clipboard")
	lObjClip.Clear 
	Set lObjClip = Nothing
End Sub

' *******************************************************************************************
' VBScript Header, &copy; 2005-2017
' Name:
'		getLngVal
' Input:
'		ByVal pStrVal As String - Value to be converted to a long
' Output:
'		Returns pStrVal as Long or 0
' Purpose:
'		If pStrVal is numeric then converts it to a long and returns it otherwise returns 0
' Remarks:
'		-
' History:
'		Date – Version - Change
' *******************************************************************************************
Public Function getLngVal(ByVal pStrVal)
	If isNumeric(pStrVal) Then
		getIntVal = CLng(pStrVal)
	Else
		getIntVal = 0
	End If
End Function

' *******************************************************************************************
' VBScript Header, &copy; 2005-2017
' Name:
'		getBool
' Input:
'		ByVal pStrBoolval As String - Value to be converted to a boolean
' Output:
'		If pStrBoolval is numeric and 0 returns False otherwise True 
'		If pStrBoolval is string and "True" returns True otherwise False
' Purpose:
'		If pStrVal is numeric then converts it to a long and returns it otherwise returns 0
' Remarks:
'	-
' History:
'	Date – Version - Change
' *******************************************************************************************
Public Function getBool(ByVal pStrBoolval)
	   
	pStrBoolval = UCase(pStrBoolval)
	If isNumeric(pStrBoolval) Then
		If CLng(pStrBoolval) = 0 Then
			getBool = False
		Else
			getBool = True
		End If
	ElseIf pStrBoolval = "TRUE" Or pStrBoolval = "WAHR" Then
		getBool = True
	Else 
		getBool = False
	End If

End Function

' *******************************************************************************************
' VBScript Header, &copy; 2005-2017
' Name:
'		getTestAttachment
' Input:
'		ByVal pStrAttachmentFilename As String - filename of attachment
' Output:
'		Returns the name (path) of the local stored file otherwise Empty String will be returned and an error will be set
' Purpose:
'		An attachment from the current test will be stored locally on the client pc
' Remarks:
' History:
'		Date – Version - Change
' *******************************************************************************************
Function getTestAttachment(ByVal pStrAttachmentFilename)
	
	Dim lObjQTPApp, lObjFilesys, lObjAttachmentFilter, lObjAttachment, lObjColAttachment
	Dim lStrReturnValue
	lStrReturnValue = Empty
	Set lObjQTPApp = CreateObject("QuickTest.Application")
	Set lObjFilesys = CreateObject("Scripting.FileSystemObject")

	If Not lObjFilesys.FileExists(pStrAttachmentFilename)  Then
		
		If InStr(1, pStrAttachmentFilename, "*") <> 1 Then pStrAttachmentFilename = "*" & pStrAttachmentFilename
		Dim lStrTestID
		lStrTestID = QCUTIL.CurrentTest.ID
		'lStrTestID = 3026 				'			 For Debugging only
		'Set lObjColAttachment =  QCUTIL.CurrentTest.Attachments.NewList("Select * From CROS_REF Where CR_REFERENCE Like '" & pStrAttachmentFilename & "' And CR_KEY_1 = "  & lStrTestID)
		Set lObjAttachmentFilter = QCUTIL.CurrentTest.Attachments.Filter
		lObjAttachmentFilter.Filter("CR_REFERENCE") = pStrAttachmentFilename
		Set lObjColAttachment =  QCUTIL.CurrentTest.Attachments.NewList(lObjAttachmentFilter.Text)
		For Each lObjAttachment in lObjColAttachment
			lObjAttachment.load true, "" 'Downloads an attachment file to a client machine. 
			'Return Value
			lStrReturnValue = lObjAttachment.filename
			Exit for
		Next
	
		If isNull(lStrReturnValue) Then
			reporter.ReportEvent micWarning, "Attachment wurde nicht gefunden", "Dateiname des Attachment ist '" & pStrAttachmentFilename & "' QCUTIL.CurrentTest.ID="& QCUTIL.CurrentTest.ID
			lStrReturnValue = Empty
		End If
	End If
	
	Set lObjQTPApp = Nothing
	Set lObjFilesys = Nothing
	Set lObjAttachmentFilter = Nothing
	Set lObjAttachment = Nothing
	Set lObjColAttachment = Nothing
	
	'Return Value
	getTestAttachment = lStrReturnValue
End Function


' *******************************************************************************************
' VBScript Header, &copy; 2005-2017
' Name:
'		extractFileName
' Input:
'		ByVal pStrFullPathEndingName As String - Full name of the file inluding path and ending
' Output:
'		Returns the filename extracted out of the fullname.C:\Testdir\Testfile.txt -> Testfile
' Purpose:
'		The given argument represents a complete path to file on the local system
'		This function removes the path and the ending to get only the name of the file
' Remarks:
'	-
' History:
'		Date – Version - Change
' *******************************************************************************************
Function extractFileName(ByVal pStrFullPathEndingName)
	Dim lArrFileName, lArrFileNameWithoutEndingArray
	Dim lStrReturnValue, lStrFileNameWithEnding
	Dim lLngFileNameIndex
	lStrReturnValue = Empty

	If pStrFullPathEndingName <> "" and Not IsEmpty(pStrFullPathEndingName) Then
		' Split an extract only the filename with the ending
		lArrFileName = Split(pStrFullPathEndingName, "\")
		If IsArray(lArrFileName) Then
			lLngFileNameIndex = UBound(lArrFileName)
			lStrFileNameWithEnding = lArrFileName(lLngFileNameIndex)
		Else
			lStrFileNameWithEnding = pStrFullPathEndingName
		End If
	
		' Split an extract only the filename WITHOUT the ending
		lArrFileNameWithoutEndingArray = Split(lStrFileNameWithEnding, ".")
		If IsArray(lArrFileNameWithoutEndingArray) Then
			lStrReturnValue = lArrFileNameWithoutEndingArray(0)
		Else
			lStrReturnValue = lStrFileNameWithEnding
		End If
	Else
		lStrReturnValue = ""
		Reporter.ReportEvent micFail, "FileName is Empty or =""""""", "The given value """ & pStrFullPathEndingName & """ is not valid for this function"
	End If

	extractFileName = lStrReturnValue
	
End Function

' *******************************************************************************************
' VBScript Header, &copy; 2005-2017
' Name:
'		KillProcess
' Input:
'		ByVal pStrProcName As String - process name
' Output:
'		-
' Purpose:
'		Kills a process by name
' Remarks:
'		-
' History:
'		Date – Version - Change
' *******************************************************************************************
Public Sub KillProcess(ByVal pStrProcName)
	Dim i
	Dim lStrQuery, lStrQueryCheck
	Dim lObjwmi, lObjColProcesses, lObjColProcessesCheck, lObjProcess
	'Dim allKilled = False 
	
	Set lObjwmi = GetObject("winmgmts:")
	lStrQuery = "select * from win32_process where name='" & pStrProcName & "'"
	Set lObjColProcesses = lObjwmi.execquery(lStrQuery)
	
	
	i = 1
	For Each lObjProcess In lObjColProcesses
		
		lStrQueryCheck = "select * from win32_process where name='" & pStrProcName & "'"
		Set lObjColProcessesCheck = lObjwmi.execquery(lStrQueryCheck)
		If lObjColProcessesCheck.Count > 0 Then
			
			termRes = lObjProcess.terminate()
			Select Case termRes
			Case 0 	Reporter.ReportEvent micPass, "Prozess " & pStrProcName & " wurde beendet", "Instanz: " & i
			Case 2 	Reporter.ReportEvent micFail, "Prozess " & pStrProcName & ": Zugriff verweigert", "Instanz: " & i
			Case 3 	Reporter.ReportEvent micFail, "Prozess " & pStrProcName & ": Rechte zur Prozessbeendigung reichen nicht aus", "Instanz: " & i
			Case 8 	Reporter.ReportEvent micFail, "Prozess " & pStrProcName & ": Unbekannter Fehler bei der Beendigung", "Instanz: " & i
			Case 9 	Reporter.ReportEvent micFail, "Prozess " & pStrProcName & ": Pfad nicht gefunden", "Instanz: " & i
			Case 21 Reporter.ReportEvent micFail, "Prozess " & pStrProcName & ": Ungueltiger Parameter", "Instanz: " & i
			End Select
			'If Err.Number = 0 Then
			'	Reporter.ReportEvent micDone, "Prozess " & pStrProcName & " wurde beendet", "Instanz: " & i
			'End If
		Else
			Reporter.ReportEvent micDone, "Prozess " & pStrProcName & " wurde beireits automatisch beendet", "Instanz: " & i
		End If
		i = i+1
		wait 0.2	
		
	Next 
	
	Set lObjwmi = Nothing
	Set lObjColProcesses = Nothing
	Set lObjColProcessesCheck = Nothing
	Set lObjProcess = Nothing

End Sub


Public Function getProcessCount(ByVal pStrProcName)

	Dim lStrQuery
	Dim lObjwmi, lObjColProcesses

	Set lObjwmi = GetObject("winmgmts:")
	lStrQuery = "select * from win32_process where name='" & pStrProcName & "'"
	Set lObjColProcesses = lObjwmi.execquery(lStrQuery)
	
	getProcessCount = lObjColProcesses.Count
		
	Set lObjwmi = Nothing
	Set lObjColProcesses = Nothing

End Function

Function checkIfProcessExist(ByVal pStrProcName, ByVal pIntIteration, ByVal pIntDuration)
	
	Dim lStrQuery
	Dim lObjwmi, lObjColProcesses

	Set lObjwmi = GetObject("winmgmts:")
	lStrQuery = "select * from win32_process where name='" & pStrProcName & "'"


	
	For i=0 To pIntIteration 
		Set lObjColProcesses = lObjwmi.execquery(lStrQuery)
	
		If lObjColProcesses.Count <= 0 Then
			checkIfProcessExist = False
			Exit Function
		Else
			checkIfProcessExist = True
		End If
		Wait pIntDuration
   Next

   Set lObjwmi = Nothing
   Set lObjColProcesses = Nothing
End Function

Function WaitWhileProcessExist(ByVal pStrProcName, ByVal pIntIteration, ByVal pIntDuration)
	
	Dim lStrQuery
	Dim lObjwmi, lObjColProcesses

	Set lObjwmi = GetObject("winmgmts:")
	lStrQuery = "select * from win32_process where name='" & pStrProcName & "'"


	WaitWhileProcessExist = False
	For i=0 To pIntIteration 
		Set lObjColProcesses = lObjwmi.execquery(lStrQuery)
	
		If lObjColProcesses.Count <= 0 Then
			Reporter.ReportEvent micDone, "WaitWhileProcessExist: Prozess nicht gefunden" , pStrProcName & " existiert nicht. Wartezeit =  " & i * pIntDuration & " Sekunden"
			WaitWhileProcessExist = True
			Exit Function
		End If

		Wait pIntDuration
   Next

   Reporter.ReportEvent micDone, "WaitWhileExist: Prozess  gefunden" , pStrProcName &  " existiert. Wartezeit =  " & pIntIteration * pIntDuration & " Sekunden"

   Set lObjwmi = Nothing
   Set lObjColProcesses = Nothing
End Function

Function WaitUntilProcessExist(ByVal pStrProcName, ByVal pIntIteration, ByVal pIntDuration)
	
	Dim lStrQuery
	Dim lObjwmi, lObjColProcesses

	Set lObjwmi = GetObject("winmgmts:")
	lStrQuery = "select * from win32_process where name='" & pStrProcName & "'"


	WaitUntilProcessExist = False
	For i=0 To pIntIteration 
		Set lObjColProcesses = lObjwmi.execquery(lStrQuery)
	
		If lObjColProcesses.Count <= 0 Then
			Reporter.ReportEvent micDone, "WaitUntilProcessExist: Prozess nicht gefunden" , pStrProcName & " existiert nicht. Wartezeit =  " & i * pIntDuration & " Sekunden"
			WaitUntilProcessExist = False
		Else
			WaitUntilProcessExist = True
			Reporter.ReportEvent micDone, "WaitWhileExist: Prozess  gefunden" , pStrProcName &  " existiert. Wartezeit =  " & pIntIteration * pIntDuration & " Sekunden"
			Exit Function
		End If

		Wait pIntDuration
   Next

   Set lObjwmi = Nothing
   Set lObjColProcesses = Nothing
End Function


' *******************************************************************************************
' VBScript Header, &copy; 2005-2017
' Name:
'		startProcessIfNotStarted
' Input:
'		ByVal pStrProcessName As String - Full name of the file inluding path and ending
'		ByVal pStrExePath As String - The name of the file you want to run.
'		ByVal pStrParams As String - use the params argument to specify any parameters to be passed to the application. 
'		ByVal pStrDir As String - The default directory of the application or file.
'		ByVal pStrOp As String - open | edit | explore | find | print
'		ByVal pStrMode As String - An Integer value. Specifies how the application is displayed when it opens. You can specify one of the modes 
'							 				   				  1 = Default, 7 = Minimized & active window remains active
' Output:
'		True process was started otherwise false
' Purpose:
'		Starts the Programm only if the process name was not found.
' Remarks:
' History:
'		Date – Version - Change
' *******************************************************************************************
Function startProcessIfNotStarted(pStrProcessName, pStrExePath, pStrParams, pStrDir, pStrOp, pStrMode)
	Dim lObjWMIService, lObjProcess, lObjColProcess
	Dim lStrComputer, lStrList
	Dim lBlnWasNotFound
	
	startProcessIfNotStarted = False
	lStrComputer = "."
	lBlnWasNotFound = True

	Set lObjWMIService = GetObject("winmgmts:" & "{impersonationLevel=impersonate}!\\" & lStrComputer & "\root\cimv2")
	Set lObjColProcess = lObjWMIService.ExecQuery ("Select * from Win32_Process")
	
	For Each lObjProcess In lObjColProcess
		'lStrList = lStrList & vbCr & lObjProcess.Name
		If isMatch(pStrProcessName, lObjProcess.Name, True)  Then
			'println lObjProcess.Name
			Reporter.ReportEvent micDone, "startProcessIfNotStarted", "The following process was identified '" & lObjProcess.Name & "'"
			lBlnWasNotFound = False
		End If
	Next

	If lBlnWasNotFound Then
		SystemUtil.Run pStrExePath, pStrParams, pStrDir, pStrOp, pStrMode
		startProcessIfNotStarted = True
	End If
	
End Function

' *******************************************************************************************
' VBScript Header, &copy; 2005-2017
' Name:
'		printLn
' Input:
'		ByVal pStrVal As String - Printed string
' Output:
'		-
' Purpose:
'		Helper method. Prints the string parameter to QTP Print Log
' Remarks:
'		-
' History:
'		Date – Version - Change
' *******************************************************************************************
Public Sub printLn(ByVal pStrVal)
   print pStrVal & vbcr
End Sub

' *******************************************************************************************
' VBScript Header, &copy; 2005-2017
' Name:
'		QTP_PrintLogClear
' Input:
'		-
' Output:
'		-
' Purpose:
'		This function simply clears the QTP Print Log
' Remarks:
'		-
' History:
'		Date – Version - Change
' *******************************************************************************************
Sub QTP_PrintLogClear
	Const cWM_CLEAR= "&HC"
    Dim lLngHwnd

    Extern.Declare micLong, "SendMessage", "user32.dll", "SendMessageA", micHwnd, micLong, micLong, micLong
	If Window("regexpwndtitle:=QuickTest Print Log").WinEditor("nativeclass:=Edit","index:=0").Exist Then
		lLngHwnd = Window("regexpwndtitle:=QuickTest Print Log").WinEditor("nativeclass:=Edit","index:=0").GetROProperty ("hwnd")
		If lLngHwnd > 0 Then
			Extern.SendMessage lLngHwnd, cWM_CLEAR, 0, 0
		End If
	End If
End Sub


' *******************************************************************************************
' VBScript Header, &copy; 2005-2017
' Name:
'		QTP_ResizePrintLog
' Input:
'		ByVal pIntLeft As Integer - Moveposition (X-Pos)
'		ByVal pIntTop As Integer - Moveposition (Y-Pos)
'		ByVal pIntWidth As Integer - Resize width
'		ByVal pIntHeight As Integer - Resize height
' Output:
'		-
' Purpose:
'		This function simply resize Print Log
' Remarks:
'		-
' History:
'		Date – Version - Change
' *******************************************************************************************
Sub QTP_ResizePrintLog(ByVal pIntLeft, ByVal pIntTop, ByVal pIntWidth, ByVal pIntHeight)

	Dim lObjQtpWindow
	Set lObjQtpWindow = Window("Title:=QuickTest Print Log","index:=0")
	lObjQtpWindow.Move pIntLeft, pIntTop
	lObjQtpWindow.Resize pIntWidth, pIntHeight
	Set lObjQtpWindow = Nothing

End Sub

' *******************************************************************************************
' VBScript Header, &copy; 2005-2017
' Name:
'		getEnDeCrypt
' Input:
'		ByVal pStrText As String - Text to escape
'		ByVal pIntTop As pStrPwd - String for en or decryption
' Output:
'		When input encrypted text then decrypted text
'		When input clear text then encrypted text
' Purpose:
'		This function is en or decrypting the given textparameter. 
' Remarks:
'		-
' History:
'		Date – Version - Change
' *******************************************************************************************
 Function getEnDeCrypt(ByVal pStrText, ByVal pStrPwd)

    Dim a, i, j, k
	Dim lArrBox(255),  lArrKey(255)
	Dim lIntSwap, lIntTmp, lIntPwdLen, lIntCipherby	  
	Dim lStrEnDecrypted

	lIntPwdLen = len(pStrPwd)
	For i = 0 To 255
		lArrKey(i) = asc(mid(pStrPwd, (i mod lIntPwdLen)+1, 1))
		lArrBox(i) = i
	next
	
	lIntTmp = 0
	For i = 0 To 255
		lIntTmp = (lIntTmp + lArrBox(i) + lArrKey(i)) Mod 256
		lIntSwap = lArrBox(i)
		lArrBox(i) = lArrBox(lIntTmp)
		lArrBox(lIntTmp) = lIntSwap
	Next
	
	a = 0
	j = 0
	For i = 1 To Len(pStrText)
		a = (a + 1) Mod 256
		j = (j + lArrBox(a)) Mod 256
		lIntTmp = lArrBox(a)
		lArrBox(a) = lArrBox(j)
		lArrBox(j) = lIntTmp
		k = lArrBox((lArrBox(a) + lArrBox(j)) Mod 256)
		lIntCipherby = Asc(Mid(pStrText, i, 1)) Xor k
		lStrEnDecrypted = lStrEnDecrypted & Chr(lIntCipherby)
	Next
	getEnDeCrypt = lStrEnDecrypted

End Function

' *******************************************************************************************
' VBScript Header, &copy; 2005-2017
' Name:
'		ClickDeviceReplay
' Input:
'		ByRefpStrText As Object - Object to be clicked
' Output:
'		-
' Purpose:
'		This function perform mouse clck against object  coordinates that are provided
' Remarks:
' History:
'		Date – Version - Change
' *******************************************************************************************
Sub ClickDeviceReplay(ByRef pObj)

    Dim lObjDeviceReplay
	Dim lIntGetXaxis, lIntGetYaxis

	Set lObjDeviceReplay = CreateObject("Mercury.DeviceReplay")
	lIntGetXaxis = pObj.GetROProperty("abs_x")
	lIntGetYaxis = pObj.GetROProperty("abs_y")
   	lObjDeviceReplay.MouseMove lIntGetXaxis+5, lIntGetYaxis+5
	wait 0, 500
	lObjDeviceReplay.MouseMove lIntGetXaxis+4, lIntGetYaxis+4
	lObjDeviceReplay.MouseClick lIntGetXaxis+3 ,lIntGetYaxis+3 ,LEFT_MOUSE_BUTTON

	Set lObjDeviceReplay = Nothing

End Sub

Function ClickText(ByRef pObj, ByVal pStrText, ByVal pBlnWholeWord, ByVal pIntLeftAdd, ByVal pIntTopAdd)
	Dim pIntLeftPos, pIntTopPos, pIntRightPos, pIntButtomPos
	println pObj.GetVisibleText()
	If pObj.GetTextLocation(pStrText, pIntLeftPos, pIntTopPos, pIntRightPos, pIntButtomPos, pBlnWholeWord) Then
		ClickDRPos pObj, pIntLeftPos+CInt(pIntLeftAdd), pIntTopPos+CInt(pIntTopAdd), LEFT_MOUSE_BUTTON
		ClickText = True
	Else
		ClickText = False
	End If
End Function
RegisterUserFunc "Window", "ClickText", "ClickText"
RegisterUserFunc "WinObject", "ClickText", "ClickText"
'RegisterUserFunc "JavaStaticText","ClickText","ClickText"

Function ClickDRPos(ByRef pObj, ByVal pIntXPos, ByVal pIntYPos, ByVal pIntMouseButton )

	Dim lObjDeviceReplay
	Dim lIntXPos, lIntYPos

	lIntXPos = pObj.GetROProperty("abs_x")
	lIntYPos = pObj.GetROProperty("abs_y")
	Set lObjDeviceReplay = CreateObject("Mercury.DeviceReplay")
	lObjDeviceReplay.MouseClick lIntXPos + pIntXPos, lIntYPos + pIntYPos ,pIntMouseButton
	Set lObjDeviceReplay = Nothing

End Function

Sub getMousePosition(ByRef pIntX, ByRef pIntY)
	Dim pObjControl
   Set pObjControl = DotNetFactory.CreateInstance("System.Windows.Forms.Control")
	pIntX = pObjControl.MousePosition.X 
	pIntY = pObjControl.MousePosition.Y
	Set oForm = Nothing 
End Sub

Function sendKeys(ByVal pStrKeys)
	Dim lObjWSH
	Set lObjWSH = createobject("WScript.Shell")
	lObjWSH.SendKeys pStrKeys
	Set lObjWSH = Nothing
End Function
' #############################################################################################
' VBScript Header, &copy; 2015-2099
' Name:
'		DeleteFromArray
' Input:
'		Array(ell1,ell2,ell3...etc)
' Output:
'		Array(ell1,ell2...etc)
' Purpose:
'		Delete an ellement from a Array by its ellement number 
' Remarks:
'		Call it like:
'		yourArray = deleteFromArray(yourArray, 0)
' History:
'		14.10.15  Initial
' #############################################################################################
Function DeleteFromArray(aArray, vElementNumber)
	Dim aNewArray, intElement, idxLast
	aNewArray = array()
	intElement = 0

	For Each i In aArray
		idxLast = UBound(aNewArray)
		If not intElement = vElementNumber Then
			ReDim Preserve aNewArray(idxLast + 1)
			aNewArray( idxLast + 1 ) = i
		End If
		intElement = intElement + 1
	Next
	DeleteFromArray = aNewArray
End Function
' #############################################################################################
' VBScript Header, &copy; 2009-2017
' Name:
'		WT
' Input:
'		wastedTime As Integer (Seconds to wait)
' Output:
'		-
' Purpose:
'		This Function will wait for the given Time and logs it as wasted Time.
' Remarks:
'		Function Libary TITAN.qfl 
' Author:
'		Jan Gina T-Systems on site
' History:
'		Date – Version - Change
' #############################################################################################
Sub WT(wastedTime)
	MercuryTimers("Dead").Start 
	Wait (wastedTime)
	Services.AddWastedTime MercuryTimers("Dead").Stop 
End Sub

' #############################################################################################
' VBScript Header, &copy; 2009-2017
' Name:
'		takeScreenshot
' Input:
'		boolCreateSreenshot	As Boolean - take screenshot TRUE or FALSE
' Output:
'		-
' Purpose:
'		This Function will take a screenshot from the given object an store it in the default
'		UFT result folder.
' History:
'		Date – Version - Change
' #############################################################################################
Sub takeScreenshot(boolCreateSreenshot)
	if boolCreateSreenshot then 
		Desktop.CaptureBitmap Environment("TestName") & "_" & getTimeStamp() &".png", True 
	End if
End Sub

'*******************************  RegisterUserFunc  **********************************
RegisterUserFunc "Browser", "ReportScrn", "ReportScrn"
RegisterUserFunc "JavaWindow", "ReportScrn", "ReportScrn"
RegisterUserFunc "Window", "ReportScrn", "ReportScrn"
RegisterUserFunc "Page", "ReportScrn", "ReportScrn"
RegisterUserFunc "JavaWindow", "ReportScrn", "ReportScrn"
RegisterUserFunc "JavaDialog", "ReportScrn", "ReportScrn"
RegisterUserFunc "SAPFrame", "ReportScrn", "ReportScrn"
RegisterUserFunc "WinButton", "ClickDR", "ClickDeviceReplay"
RegisterUserFunc "JavaButton", "ClickDR", "ClickDeviceReplay"
RegisterUserFunc "JavaWindow", "ClickDR", "ClickDeviceReplay"
RegisterUserFunc "JavaToolbar", "ClickDR", "ClickDeviceReplay"

' *******************************************************************************************
