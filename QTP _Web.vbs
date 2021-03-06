

' *******************************************************************************************
' VBScript Header, &copy; 2005-2017
' Name:
'		start
' Input:
'		ByVal pStrTiteltext As String - Title of the Internet Explorer
'		ByVal pIntSnapshotReportMode As Integer - 0: always captures images, 1: only if an error, 
'												  2: error or warning, 3:  never
' Output:
'		-
' Purpose:
'		This Sub sets the Snapshotmode for the run. Also it moves and maximzes the IE on the main desktop.
' Remarks:
'		-
' History:
'		Date – Version - Change
' *******************************************************************************************
Sub start(ByVal pStrTitletext, ByVal pIntSnapshotReportMode)
	Dim lObjMyWin
	Dim lIntReporterFiler, lIntXpos
	Dim lBlnMaximized
	
	Set lObjMyWin =  Window("text:=" & pStrTitletext & ".*", "regexpwndclass:=IEFrame")
	lIntReporterFiler = Reporter.Filter 
	Reporter.Filter = 1
	lBlnMaximized = lObjMyWin.GetROProperty("maximized")  'Window("IE").GetROProperty("maximized")
	lIntXpos =  lObjMyWin.GetROProperty("abs_x")
	If  lBlnMaximized = True And lIntXpos > 0 Then lObjMyWin.Restore
    If lIntXpos > 0 Then lObjMyWin.Move 0,0
	lObjMyWin.Maximize 
	Reporter.Filter = lIntReporterFiler
	If Not isIgnore(pIntSnapshotReportMode) Then
	   Setting("SnapshotReportMode") = pIntSnapshotReportMode
	End If
	Set lObjMyWin = Nothing
End Sub



' *******************************************************************************************
' VBScript Header, &copy; 2005-2017
' Name:
'		Web_WebEdit_SetValue
' Input:
'		ByRef pObj As Object - At this object the Set method is called
'		ByVal pStrVal As String - Value to set
' Output:
'		-
' Purpose:
'		This Sub sets WebEdit fields and is ignoreable.
' Remarks:
'		-
' History:
'		Date – Version - Change
' *******************************************************************************************
Sub Web_WebEdit_SetValue(ByRef pObj, ByVal pStrVal)
	If  isIgnore(pStrVal) Then
		Reporter.ReportEvent micDone, "SET:  " & pObj.toString()  & " is ignored", "", pObj
	Else
		pObj.Set pStrVal
	End If
End Sub
RegisterUserFunc "WebEdit","SetValue", "Web_WebEdit_SetValue"

' *******************************************************************************************
' VBScript Header, &copy; 2005-2017
' Name:
'		Web_WebEdit_SetSecureValue
' Input:
'		ByRef pObj As Object - At this object the SetSecure method is called
'		ByVal pStrVal As String - Value to set . The encrypted text to be entered in the edit box
' Output:
'		-
' Purpose:
'		This Sub sets WebEdit fields with encrypted text  and is ignoreable.
' Remarks:
'		-
' History:
'		Date – Version - Change
' *******************************************************************************************
Sub Web_WebEdit_SetSecureValue(ByRef pObj, ByVal pStrVal)
	If  isIgnore(pStrVal) Then
		Reporter.ReportEvent micDone, "SET:  " & pObj.toString()  & " is ignored", "", pObj
	Else
		pObj.SetSecure pStrVal
	End If
End Sub
RegisterUserFunc "WebEdit","SetSecureValue", "Web_WebEdit_SetSecureValue"


' *******************************************************************************************
' VBScript Header, &copy; 2005-2017
' Name:
'		Web_WebEdit_CheckValue
' Input:
'		ByRef pObj As Object - At this object the CheckProperty method is called
'		ByVal pStrVal As String - Value to check
' Output:
'		-
' Purpose:
'		This Sub checks WebEdit fields and is ignoreable.
' Remarks:
'		-
' History:
'		Date – Version - Change
' *******************************************************************************************
Sub Web_WebEdit_CheckValue(ByRef pObj, ByVal pStrVal)
      
	If  isIgnore(pStrVal) Then
		Reporter.ReportEvent micDone, "SET:  " & pObj.toString()  & " is ignored", "", pObj
	Else
		 pObj.CheckProperty "value", pStrVal
	End If

End Sub
RegisterUserFunc "WebEdit","CheckValue", "Web_WebEdit_CheckValue" 
RegisterUserFunc "WebFile","CheckValue", "Web_WebEdit_CheckValue" 

' *******************************************************************************************
' VBScript Header, &copy; 2005-2017
' Name:
'		Web_WebEdit_SetDate
' Input:
'		ByRef pObj As Object - At this object the Set method is called
'		ByVal pStrVal As String - Value to set. This String can also being a relative date-String.
'		ByVal pStrPttrn As String - Pattern of the date. If string is empty so default pattern is used.
' Output:
'		-
' Purpose:
'		This Sub sets WebEdit fields with an date and is ignoreable.
' Remarks:
'		Function Libary QTP_DateTime.qfl 
' History:
'		Date – Version - Change
' *******************************************************************************************
Sub Web_WebEdit_SetDate(ByRef pObj, ByVal pStrVal, ByVal pStrPttrn)

	If  isIgnore(pStrVal) Then
		Reporter.ReportEvent micDone, "SetDate:  " & pObj.toString()  & " is ignored", "", pObj
	Else
		If isRelativeDate(pStrVal) Then
			pStrVal = createRelativeDate(pStrVal, pStrPttrn)
		end if
		Web_WebEdit_SetValue pObj, pStrVal
	End if
	
End Sub
RegisterUserFunc "WebEdit", "SetDate", "Web_WebEdit_SetDate"

' *******************************************************************************************
' VBScript Header, &copy; 2005-2017
' Name:
'		Web_WebEdit_CheckDate
' Input:
'		ByRef pObj As Object - At this object the Set method is called
'		ByVal pStrVal As String - Value to set. This String can also being a relative date-String.
'		ByVal pStrPttrn As String - Pattern of the date. If string is empty so default pattern is used.
' Output:
'		-
' Purpose:
'		This Sub checks WebEdit fields with an date and is ignoreable.
' Remarks:
'		Function Libary QTP_DateTime.qfl 
' History:
'		Date – Version - Change
' *******************************************************************************************
Sub Web_WebEdit_CheckDate(ByRef pObj, pStrVal, pStrPttrn)
	JavaEdit_CheckDate = false
	If  isIgnore(pStrVal) Then
		Reporter.ReportEvent micDone, "CheckDate:  " & pObj.toString()  & " is ignored", "", pObj
	Else
		If isRelativeDate(pStrVal) Then
			pStrVal = createRelativeDate(pStrVal, pStrPttrn)
		end if
		Web_WebEdit_CheckValue pObj, pStrVal
	End if
	
End Sub
RegisterUserFunc "WebEdit", "CheckDate", "Web_WebEdit_CheckDate"


' *******************************************************************************************
' VBScript Header, &copy; 2005-2017
' Name:
'		Web_WebRadioGroup_SelectValue
' Input:
'		ByRef pObj As Object - At this object the Select method is called
'		ByVal pStrVal As String - Value to select. Value can be a number (index) 
' Output:
'		-
' Purpose:
'		This sub selects WebRadioGroup fields and is ignoreable.
' Remarks:
'		-
' History:
'		Date – Version - Change
' *******************************************************************************************v
Sub Web_WebRadioGroup_SelectValue(ByRef pObj, ByVal pStrVal)
	If  isIgnore(pStrVal) Then
		Reporter.ReportEvent micDone, "SET:  " & pObj.toString()  & " is ignored", "", pObj
	Else
		If IsNumeric(pStrVal) Then
				pStrVal ="#" & CInt(pStrVal)-1
		End If
		pObj.Select pStrVal
	End If

End Sub
RegisterUserFunc "WebRadioGroup","SelectValue", "Web_WebRadioGroup_SelectValue" 



' *******************************************************************************************
' VBScript Header, &copy; 2005-2017
' Name:
'		Web_WebRadioGroup_CheckValue
' Input:
'		ByRef pObj As Object - At this object the CheckProperty method is called
'		ByVal pStrVal As String - Value to check. Value can be a number (index) 
' Output:
'		-
' Purpose:
'		This sub checks WebRadioGroup fields and is ignoreable.
' Remarks:
'		-
' History:
'		Date – Version - Change
' *******************************************************************************************
Sub Web_WebRadioGroup_CheckValue(ByRef pObj, ByVal pStrVal)
	If  isIgnore(pStrVal) Then
		Reporter.ReportEvent micDone, "SET:  " & pObj.toString()  & " is ignored", "", pObj
	Else
		If IsNumeric(pStrVal) Then
				pObj.CheckProperty "selected item index", pStrVal
		Else
				pObj.CheckProperty "value", pStrVal
		End If
	End If

End Sub
RegisterUserFunc "WebRadioGroup","CheckValue", "Web_WebRadioGroup_CheckValue" 


' *******************************************************************************************
' VBScript Header, &copy; 2005-2017
' Name:
'		Web_WebList_SelectValue
' Input:
'		ByRef pObj As Object - At this object the Select method is called
'		ByVal pStrVal As String - Value to select. Value can be a number (index) 
' Output:
'		-
' Purpose:
'		This sub selects WebList fields and is ignoreable.
' Remarks:
'		-

' History:
'		Date – Version - Change
' *******************************************************************************************
Sub Web_WebList_SelectValue(ByRef pObj, ByVal pStrVal)
	If  isIgnore(pStrVal) Then
		Reporter.ReportEvent micDone, "SET:  " & pObj.toString()  & " is ignored", "", pObj
	Else
		If IsNumeric(pStrVal) Then
				pStrVal ="#" &pStrVal
		End If
		pObj.Select pStrVal
	End If

End Sub
RegisterUserFunc "WebList","SelectValue", "Web_WebList_SelectValue" 

' *******************************************************************************************
' VBScript Header, &copy; 2005-2017
' Name:
'		Web_WebList_CheckValue
' Input:
'		ByRef pObj As Object - At this object the CheckProperty method is called
'		ByVal pStrVal As String - Value to check. Value can be a number (index) 
' Output:
'		-
' Purpose:
'		This sub checks WebList fields and is ignoreable.
' Remarks:
'		-

' History:
'		Date – Version - Change
' *******************************************************************************************
Sub Web_WebList_CheckValue(ByRef obj, ByVal pStrVal)
	If  isIgnore(pStrVal) Then
		Reporter.ReportEvent micDone, "SET:  " & obj.toString()  & " is ignored", "", obj
	Else
		If IsNumeric(pStrVal) Then
				obj.CheckProperty "selected item index", pStrVal
		Else
				obj.CheckProperty "value", pStrVal
		End If
	End If

End Sub
RegisterUserFunc "WebList","CheckValue", "Web_WebList_CheckValue" 

' *******************************************************************************************
' VBScript Header, &copy; 2005-2017
' Name:
'		Web_WebCeckBox_SetValue
' Input:
'		ByRef pObj As Object - At this object the Set method is called
'		ByVal pStrVal As String - Value to set. Value can be a number (1: ON, 0: OFF) 
' Output:
'		-
' Purpose:
'		This sub sets WebCeckBox fields and is ignoreable.
' Remarks:
'		-

' History:
'		Date – Version - Change
' *******************************************************************************************
Sub Web_WebCeckBox_SetValue(ByRef pObj, ByVal pStrVal)
	 If  isIgnore(pStrVal) Then
		Reporter.ReportEvent micDone, "SET:  " & pObj.toString()  & " is ignored", "", pObj
	Else
		If pStrVal = "1"  Or lCase(pStrVal) = "on"Then
			pObj.Set "ON"
		Else
			pObj.Set "OFF"
		End If
	End If
End Sub
RegisterUserFunc "WebCheckBox","SetValue", "Web_WebCeckBox_SetValue" 


' *******************************************************************************************
' VBScript Header, &copy; 2005-2017
' Name:
'		Web_WebCeckBox_CheckValue
' Input:
'		ByRef pObj As Object - At this object the CheckProperty method is called
'		ByVal pStrVal As String - Value to check. Value can be a number (1: ON, 0: OFF) 
' Output:
'		-
' Purpose:
'		This sub checks WebCeckBox fields and is ignoreable.
' Remarks:
'		-

' History:
'		Date – Version - Change
' *******************************************************************************************
Sub Web_WebCeckBox_CheckValue(ByRef pObj, pStrVal)
	 If  isIgnore(pStrVal) Then
		Reporter.ReportEvent micDone, "SET:  " & pObj.toString()  & " is ignored", "", pObj
	Else
		If pStrVal = "1"  Or lCase(pStrVal) = "on"Then
			pObj.CheckProperty "checked", "1"
		Else
			pObj.CheckProperty "checked", "0"
		End If
	End If
End Sub
RegisterUserFunc "WebCheckBox","CheckValue", "CheckWebCeckBox" 




' *******************************************************************************************
' VBScript Header, &copy; 2005-2017
' Name:
'		Web_WebTable_FindRowByColumValue
' Input:
'		ByRef pObjTable As Object - At this tableobject the row is searched
'		ByVal pStrkeyValuePairs As String - Description of the row, which is searched in the Table
'											The String must match to the following pattern
'	 										Der String muss folgendem Muster entsprechen:
'											"[Columnname1]=[Cellvalue]|[Columnname2]|[Cellvalue];..."
'											For all cellvalues is regex possible.	
'											e.g. "Partner ID=91000000\d\d|Name=Wholesale Service"											
' Output:
'		When found rownumber otherwise -1
' Purpose:
'		This Function searches a row in a table.
' Remarks:
'		Assumption, rownumber 0 is the headerrow
'		Function Libary QTP_String.qfl

' History:
'		Date – Version - Change
' *******************************************************************************************
Function Web_WebTable_FindRowByColumValue(ByRef pObjTable, pStrkeyValuePairs)
	
	If pStrkeyValuePairs = "" or isIgnore(pStrkeyValuePairs) Then
		Web_WebTable_FindRowByColumValue = -1
		Exit function
	End If

	'Default Rückgabewert
	Web_WebTable_FindRowByColumValue = -1
	
	Dim i
	Dim lArrKeyValuePair, lArrKeyValue
	Dim lArrIndexValue()
	lArrKeyValuePair = Split(pStrkeyValuePairs, "|", -1, 1)
	Redim lArrIndexValue (UBound(lArrKeyValuePair), 1)
	
	For i = 0 To UBound(lArrKeyValuePair)
		lArrKeyValue = Split(lArrKeyValuePair(i), "=", -1, 1)
		If UBound(lArrKeyValue) < 1 Then
			Reporter.ReportEvent micWarning, "missing data", "Expected Array size is 2, current size is "& UBound(lArrKeyValue) &". Perhaps thats not a key-value-pair seperated by '='. " & lArrKeyValuePair(i)
			Web_WebTable_FindRowByColumValue = -1
			Exit function
		End If
		Dim lStrColumName, lStrColumNameTmp
		'Gesuchten Spaltennamen kopieren
		lStrColumName = lArrKeyValue(0)
		lArrIndexValue(i,0) = -1
		lStrColumNameTmp = "" 'colum name
		For k = 1 To pObjTable.ColumnCount(1)
			lStrColumNameTmp = pObjTable.GetCellData(1, k)
			'print "lStrColumNameTmp=" & lStrColumNameTmp & " lStrColumName=" & lStrColumName & vbcr
			If lStrColumNameTmp = lStrColumName Then 
				'Der Spaltennamen entspricht dem gesuchtem Spaltennamen
				lArrIndexValue(i,0) = k
				Exit for
			End If
		Next
		lArrIndexValue(i,1) = Trim(lArrKeyValue(1))
	next
	Dim lIntGefunden
	lIntGefunden = 0 ' Speichert die Anzahl der gefundenen Übereinstimmungen
	
    For i=2 To pObjTable.RowCount ' In der ersten Zeile sind die Spaltennamen, also beginnen wir mit Zeile 2
		
		For k=0 to UBound(lArrIndexValue)

			'Vergleiche geforderten mit vorhandenem Wert
			'print "Geforderter Wert=" & lArrIndexValue(k, 1) & vbcr
			'print "Vorhandener Wert=" & trim(pObjTable.GetCellData(i, lArrIndexValue(k, 0))) & vbcr
			
			'If lArrIndexValue(k, 1) = trim(pObjTable.GetCellData(i, lArrIndexValue(k, 0))) Then
			If isMatch(lArrIndexValue(k, 1), trim(pObjTable.GetCellData(i, lArrIndexValue(k, 0))), false) Then
				lIntGefunden = lIntGefunden + 1
			else
				'Es müssen ALLE Kriterien übereinstimmen, so können wir die Schleife bei der ersten nicht Übereinstimmung abbrechen
				k = UBound(lArrIndexValue) + 1
			End If
		Next
		
		' Überprüfe die Anzahl der Übereinstimmungen
		If lIntGefunden = (UBound(lArrIndexValue)+1) Then
			Web_WebTable_FindRowByColumValue = i
			Exit function
		End If

		lIntGefunden = 0
	Next
	Web_WebTable_FindRowByColumValue = -1
End Function
RegisterUserFunc "WebTable", "FindRowByColumValue", "Web_WebTable_FindRowByColumValue"


' *******************************************************************************************
' VBScript Header, &copy; 2005-2017
' Name:
'		Web_WebTable_CheckRow
' Input:
'		ByRef pObjTable As Object - At this tableobject the row is searched
'		ByVal pStrkeyValuePairs As String - Description of the row, which is searched in the Table
'											The String must match to the following pattern
'	 										Der String muss folgendem Muster entsprechen:
'											"[Columnname1]=[Cellvalue]|[Columnname2]|[Cellvalue];..."
'											For all cellvalues is regex possible.	
'											e.g. "Partner ID=91000000\d\d|Name=Wholesale Service"			
'		ByVal pIntRowNumber AS Integer - rownumber
'		ByVal pBlnReporterOn As Boolean - Reports when this parameter is True						
' Output:
'		True when found otherwise False
' Purpose:
'		This Function checks a row in a table.
' Remarks:
'		Assumption, rownumber 0 is the headerrow
'		Function Libary QTP_String.qfl

' History:
'		Date – Version - Change
' *******************************************************************************************
Function Web_WebTable_CheckRow(ByRef pObjTable, ByVal pStrkeyValuePairs, ByVal pIntRowNumber, ByVal pBlnReporterOn)
	'Default Rückgabewert
	Web_WebTable_CheckRow =False
	If pStrkeyValuePairs = "" or isIgnore(pStrkeyValuePairs) Then
		Exit function
	End If

	Dim i
	Dim lArrKeyValuePair, lArrKeyValue
	Dim lArrIndexValue()
	lArrKeyValuePair = Split(pStrkeyValuePairs, "|", -1, 1)
	Redim lArrIndexValue (UBound(lArrKeyValuePair), 1)
	
	For i = 0 To UBound(lArrKeyValuePair)
		lArrKeyValue = Split(lArrKeyValuePair(i), "=", -1, 1)
		If UBound(lArrKeyValue) < 1 Then
			If getBool(pBlnReporterOn) Then
				Reporter.ReportEvent micWarning, "missing data", "Expected Array size is 2, current size is "& UBound(lArrKeyValue) &". Perhaps thats not a key-value-pair seperated by '='. " & lArrKeyValuePair(i), pObjTable
			End If
			Exit function
		End If
		Dim lStrColumName, lStrColumNameTmp
		'Gesuchten Spaltennamen kopieren
		lStrColumName = lArrKeyValue(0)
		lArrIndexValue(i,0) = -1
		lStrColumNameTmp = "" 'colum name
		For k = 1 To pObjTable.ColumnCount(1)
			lStrColumNameTmp = pObjTable.GetCellData(1, k)
			'print "lStrColumNameTmp=" & lStrColumNameTmp & " lStrColumName=" & lStrColumName & vbcr
			If isMatch("^" & lStrColumName & "$", lStrColumNameTmp, True)  Then 
				'Der Spaltennamen entspricht dem gesuchtem Spaltennamen
				lArrIndexValue(i,0) = k
				Exit For
			End If
		Next
		lArrIndexValue(i,1) = Trim(lArrKeyValue(1))
	Next
	'Dim lIntGefunden
	'lIntGefunden = 0 ' Speichert die Anzahl der gefundenen Übereinstimmungen

	
	For k=0 to UBound(lArrIndexValue)

			'Vergleiche geforderten mit vorhandenem Wert
			'print "Geforderter Wert=" & lArrIndexValue(k, 1) & vbcr
			'print "Vorhandener Wert=" & trim(pObjTable.GetCellData(i, lArrIndexValue(k, 0))) & vbcr
			
			'If lArrIndexValue(k, 1) = trim(pObjTable.GetCellData(i, lArrIndexValue(k, 0))) Then
			lStrColValTmp = trim(pObjTable.GetCellData(pIntRowNumber, lArrIndexValue(k, 0)))
			If isMatch("^" & lArrIndexValue(k, 1) & "$", lStrColValTmp, false) Then
				lIntGefunden = lIntGefunden + 1
				If getBool(pBlnReporterOn) Then
					Reporter.ReportEvent micPass, "Spalte mit Wert gefunden", "In Zeile: " & pIntRowNumber & "  hat die Spalte: " & lArrIndexValue(k, 0) & "  den erwarteten Wert: " & lArrIndexValue(k, 1) & "  , aktueller Wert: " & lStrColValTmp, pObjTable
				End If
			else
				'Es müssen ALLE Kriterien übereinstimmen, so können wir die Schleife bei der ersten nicht Übereinstimmung abbrechen
            	If getBool(pBlnReporterOn) Then
					Reporter.ReportEvent micFail, "Spalte mit Wert nicht gefunden", "In Zeile: " & pIntRowNumber & "  hat die Spalte: " & lArrIndexValue(k, 0) & "  nicht den erwarteten Wert: " & lArrIndexValue(k, 1) & "  , aktueller Wert: " & lStrColValTmp, pObjTable
				End If
				'k = UBound(lArrIndexValue) + 1
				'Exit For
			End If
		Next
		
		' Überprüfe die Anzahl der Übereinstimmungen
		If lIntGefunden = (UBound(lArrIndexValue)+1) Then
			Web_WebTable_CheckRow = True
			Exit function
		End If

End Function
RegisterUserFunc "WebTable", "CheckRowByColumValue", "Web_WebTable_CheckRow"



' *******************************************************************************************
' VBScript Header, &copy; 2005-2017
' Name:
'		getColIndexByName
' Input:
'		ByRef  pObjTable As Object - Tableobject
'		ByVal pStrColName As String - Columnname
																		
' Output:
'		When found Columnindex otherwise -1
' Purpose:
'		Returns the Columnindex by Columnname 
' Remarks:
'		-

' History:
'		Date – Version - Change
' *******************************************************************************************
Function getColIndexByName(ByRef pObjTable, ByVal pStrColName)
 
	getColIndexByName = -1
	For i=1 To pObjTable.ColumnCount(1)
		If isMatch(pStrColName, pObjTable.GetCellData(1,i), True) Then
			getColIndexByName = i
			Exit Function
		End If
	Next
End Function


' *******************************************************************************************
' VBScript Header, &copy; 2005-2017
' Name:
'		CloseBrowserExcept
' Input:
'		ByVal pStrBrowserName As String - The name property of the Browser
'																					
' Output:
'		-
' Purpose:
'		This Sub closes all Browser, which has the parameter pStrBrowserName in their property name
' Remarks:
'		-

' History:
'		Date – Version - Change
' *******************************************************************************************
Public Sub CloseBrowserExcept(ByVal pStrBrowserName)
	Dim lObjBrowser, lObjColBrowser
	Dim lStrHwnd, lStrBname, lStrBurl
	
	Set lObjBrowser = Description.Create
	lObjBrowser("micclass").Value = "Browser"
	Set lObjColBrowser = Desktop.ChildObjects(lObjBrowser) 
	For i = lObjColBrowser.Count -1 to 0 Step -1 ' For loop starts with Count -1 till 0 & Decrement One Step at a time
		If Instr(1,lObjColBrowser(i).GetRoProperty("Name"), pStrBrowserName)= 0 Then
			lStrHwnd =  lObjColBrowser(i).GetRoProperty("hwnd")
			lStrBname = lObjColBrowser(i).GetRoProperty("name")
			lStrBurl = lObjColBrowser(i).GetRoProperty("openurl")
            SystemUtil.CloseProcessByHwnd lStrHwnd
			Reporter.ReportEvent micdone, "Browser: " & lStrBname & " wurde geschlossen", " Browser mit Url: " & lStrBurl & " wurde erfolgreich geschlossen"
		End If 
	Next
	Set lObjBrowser = Nothing
	Set lObjColBrowser = Nothing
	
End Sub

' *******************************************************************************************
' VBScript Header, &copy; 2005-2017
' Name:
'		Web_CloseAll_IExplorer
' Input:
'		-																			
' Output:
'		-
' Purpose:
'		This Sub closes all IEBrowser and its dialogs, except the IE with ALM
' Remarks:
'		Function Libary QTP_String.qfl

' History:
'		Date – Version - Change
' *******************************************************************************************
Public Sub Web_CloseAll_IExplorer()
	Dim lobjShell
	Dim lobjShellWindows
	Dim lobjWindow
	Dim lstrType
	Dim lblnClosed
	On Error Resume Next
	Set lobjShell = CreateObject("Shell.Application")
	Do
		'Dialog wenn IE abgestürzt ist und nach Wiederherstellung fragt.
		If Dialog("text:=(Windows )?Internet Explorer","nativeclass:=#32770","index:=0").Exist(0) Then
			Dialog("text:=(Windows )?Internet Explorer","nativeclass:=#32770","index:=0").Close 
			wait 2
		End If


		lblnClosed = False
		Set lobjShellWindows = lobjShell.Windows
		For Each lobjWindow In lobjShellWindows
            If isMatch("[i]?explore[r]?\.exe", lobjWindow.FullName, True)    Then
				Err.Clear
				lstrType = lobjWindow.Type
				If Err.Number = 0 Then
					If isMatch( "HTML[ -]Do[ck]ument", lstrType, True) Then
						'If isMatch( "Quality Center", lobjWindow.Document.Title, True) Or isMatch("Application Lifecycle Management", lobjWindow.Document.Title, True) Then
							' Do nothing
						'Else
							'Durch Dialog gesperrt
							If   lobjWindow.busy Then
    							If Browser("index:=0;title:=" & lobjWindow.LocationName).Dialog("nativeclass:=#32770").Exist (0) Then
										'Wenn mehrere SubDialoge offen sind (gehe von maximal 3 aus)
										If Browser("index:=0;title:=" & lobjWindow.LocationName).Dialog("nativeclass:=#32770").Getroproperty("enabled") = False Then
											If Browser("index:=0;title:=" & lobjWindow.LocationName).Dialog("nativeclass:=#32770","location:=0").Dialog("nativeclass:=#32770","location:=1").Getroproperty("enabled") = False Then
												Browser("index:=0;title:=" & lobjWindow.LocationName).Dialog("nativeclass:=#32770","location:=0").Dialog("nativeclass:=#32770","location:=1").Dialog("nativeclass:=#32770","location:=2").close
												Browser("index:=0;title:=" & lobjWindow.LocationName).Dialog("nativeclass:=#32770","location:=0").Dialog("nativeclass:=#32770","location:=1").close
												Browser("index:=0;title:=" & lobjWindow.LocationName).Dialog("nativeclass:=#32770","enabled:=True").Close
											Else
												Browser("index:=0;title:=" & lobjWindow.LocationName).Dialog("nativeclass:=#32770","location:=0").Dialog("nativeclass:=#32770","location:=1").close
                                            	Browser("index:=0;title:=" & lobjWindow.LocationName).Dialog("nativeclass:=#32770","enabled:=True").Close
											End If
										Else
												Browser("index:=0;title:=" & lobjWindow.LocationName).Dialog("nativeclass:=#32770","location:=0").Close
										End If
									End If
							End If

	                        Reporter.ReportEvent micWarning, "Browser closed", "Existing browser window with title """ & lobjWindow.Document.Title & """ was closed."
	                        lobjWindow.Quit
	
							lblnClosed = True
							Wait 0, 250
						'End If
					End If
				End If
			End If
		Next
	Loop While lblnClosed
	Wait 1
	On Error Goto 0
End Sub



' *******************************************************************************************
' VBScript Header, &copy; 2005-2017
' Name:
'		GetAllTextFromPage
' Input:
'		ByRef  pObjPage As Object - Pageobject from Browser																			
' Output:
'		All Text in the page
' Purpose:
'		This Function returns all the Text in a Page
' Remarks:
'		Function Libary QTP_String.qfl

' History:
'		Date – Version - Change
' *******************************************************************************************
Function Web_Page_GetAllTextFromPage (ByRef pObjPage)

	Dim lObjFrame, lObjColFrames
	Dim lStrText
	
	Set lObjColFrames =pObjPage.Object.GetElementsByTagName("frame")
	If lObjColFrames.length = 0 Then
		lStrText = pObjPage.Object.body.innerText 
	Else
		For Each lobjFrame In lObjColFrames
			'println lobjFrame.Name 
			If  lobjFrame.Name <> Empty Then
				'println pObjPage.Frame("name:=" & lobjFrame.Name).Object.body.innerText 
				lStrText = lStrText & pObjPage.Frame("name:=" & lobjFrame.Name).Object.body.innerText 
			End If
		Next
	End If
	Web_Page_GetAllTextFromPage = lStrText
	Set lObjFrame =Nothing
	Set lObjColFrames = Nothing

End Function
RegisterUserFunc "Page", "GetAllTextFromPage", "Web_Page_GetAllTextFromPage"
