# hungary.tcl:
# Hungarian text for menu names and status bar help messages for SCID
# Translated by: G�bor Szts


addLanguage H Hungarian 0 ;# iso8859-2

proc setLanguage_H {} {

# File menu:
menuText H File "F�jl" 0
menuText H FileNew "�j..." 0 {�j SCID-adatb�zis l�trehoz�sa}
menuText H FileOpen "Megnyit..." 3 {Megl�v SCID-adatb�zis megnyit�sa}
menuText H FileClose "Bez�r" 2 {Az akt�v SCID-adatb�zis bez�r�sa}
menuText H FileFinder "F�jlkeres" 0 {Kinyitja a F�jlkeres ablakot.}
menuText H FileBookmarks "K�nyvjelzk" 0 {K�nyvjelzmen� (gyorsbillenty�: Ctrl+B)}
menuText H FileBookmarksAdd "�j k�nyvjelz" 0 \
  {Megjel�li az aktu�lis j�tszm�t �s �ll�st.}
menuText H FileBookmarksFile "K�nyvjelz ment�se" 11 \
  {Az �ll�shoz tartoz k�nyvjelzt k�l�n mapp�ba teszi.}
menuText H FileBookmarksEdit "K�nyvjelzk szerkeszt�se..." 13 \
  {K�nyvjelzk szerkeszt�se}
menuText H FileBookmarksList "Megjelen�t�s listak�nt" 13 \
  {A k�nyvjelzmapp�k nem almen�k�nt, hanem listak�nt jelennek meg.}
menuText H FileBookmarksSub "Megjelen�t�s almen�k�nt" 13 \
  {A k�nyvjelzmapp�k nem listak�nt, hanem almen�k�nt jelennek meg.}
menuText H FileMaint "Gondoz�s" 0 {SCID adatb�zisgondoz eszk�z�k}
menuText H FileMaintWin "Adatb�zisgondoz ablak" 0 \
  {Kinyitja/becsukja az SCID adatb�zisgondoz ablakot.}
menuText H FileMaintCompact "Adatb�zis t�m�r�t�se..." 10 \
  {Elt�vol�tja az adatb�zisbl a t�r�lt j�tszm�kat �s a haszn�laton k�v�l �ll neveket.}
menuText H FileMaintClass "Oszt�lyba sorol�s..." 0 \
  {�jra kisz�m�tja az �sszes j�tszma ECO-kdj�t.}
menuText H FileMaintSort "Rendez�s..." 0 \
  {Rendezi az adatb�zis �sszes j�tszm�j�t.}
menuText H FileMaintDelete "Ikerj�tszm�k t�rl�se..." 0 \
  {Megkeresi az ikerj�tszm�kat, �s megjel�li ket t�rl�sre.}
menuText H FileMaintTwin "Ikerkeres ablak" 4 \
  {Kinyitja/becsukja az ikerkeres ablakot.}
menuText H FileMaintName "Nevek helyes�r�sa" 0 {N�vszerkeszt �s helyes�r�si eszk�z�k}
menuText H FileMaintNameEditor "N�vszerkeszt" 0 \
  {Kinyitja/becsukja a n�vszerkeszt ablakot.}
menuText H FileMaintNamePlayer "J�t�kosnevek ellenrz�se..." 0 \
  {A helyes�r�s-ellenrz f�jl seg�ts�g�vel ellenrzi a j�t�kosok nev�t.}
menuText H FileMaintNameEvent "Esem�nynevek ellenrz�se..." 0 \
  {A helyes�r�s-ellenrz f�jl seg�ts�g�vel ellenrzi esem�nyek nev�t.}
menuText H FileMaintNameSite "Helynevek ellenrz�se..." 0 \
  {A helyes�r�s-ellenrz f�jl seg�ts�g�vel ellenrzi a helysz�nek nev�t.}
menuText H FileMaintNameRound "Fordulnevek ellenrz�se..." 0 \
  {A helyes�r�s-ellenrz f�jl seg�ts�g�vel ellenrzi a fordulk nev�t.}
menuText H FileReadOnly "�r�sv�delem..." 0 \
  {Az aktu�lis adatb�zist csak olvasni lehet, nehogy meg lehessen v�ltoztatni.}
menuText H FileSwitch "Adatb�zisv�lt�s" 0 \
  {�tv�lt egy m�sik megnyitott adatb�zisra.}
menuText H FileExit "Kil�p" 1 {Kil�p SCID-bl.}

# Edit menu:
menuText H Edit "Szerkeszt�s" 1
menuText H EditAdd "�j v�ltozat" 0 {Enn�l a l�p�sn�l �j v�ltozatot sz�r be a j�tszm�ba.}
menuText H EditDelete "V�ltozat t�rl�se" 9 {T�r�l egy v�ltozatot enn�l a l�p�sn�l.}
menuText H EditFirst "Els v�ltozatt� tesz" 0 \
  {Els helyre teszi a v�ltozatot a list�n.}
menuText H EditMain "Fv�ltozatt� tesz" 0 \
  {A v�ltozatot fv�ltozatt� l�pteti el.}
menuText H EditTrial "V�ltozat kiprb�l�sa" 11 \
  {Elind�tja/meg�ll�tja a prba�zemmdot, amellyel egy elgondol�st lehet a t�bl�n kiprb�lni.}
menuText H EditStrip "Lecsupasz�t" 2 {Elt�vol�tja a megjegyz�seket vagy a v�ltozatokat ebbl a j�tszm�bl.}
menuText H EditStripComments "Megjegyz�sek" 0 \
  {Elt�vol�tja az �sszes megjegyz�st �s elemz�st ebbl a j�tszm�bl.}
menuText H EditStripVars "V�ltozatok" 0 {Elt�vol�tja az �sszes v�ltozatot ebbl a j�tszm�bl.}
menuText H EditReset "Ki�r�ti a V�gasztalt" 2 \
  {Alaphelyzetbe hozza a V�gasztalt, hogy az teljesen �res legyen.}
menuText H EditCopy "A V�gasztalra m�solja ezt a j�tszm�t." 15 \
  {Ezt a j�tszm�t �tm�solja a V�gasztal adatb�zisba.}
menuText H EditPaste "Beilleszti az utols j�tszm�t a V�gasztalrl." 0 \
  {A V�gasztal akt�v j�tszm�j�t beilleszti ide.}
menuText H EditSetup "Kezd�ll�s fel�ll�t�sa..." 14 \
  {Fel�ll�tja a kezd�ll�st ehhez a j�tszm�hoz.}
menuText H EditCopyBoard "�ll�s m�sol�sa FEN-k�nt" 17 \
  {Az aktu�lis �ll�st FEN-jel�l�ssel a v�glapra m�solja.}
menuText H EditPasteBoard "Kezd�ll�s beilleszt�se" 13 \
  {Fel�ll�tja a kezd�ll�st kijel�lt sz�veg (v�glap) alapj�n.}

# Game menu:
menuText H Game "J�tszma" 0
menuText H GameNew "�j j�tszma" 0 \
  {�j j�tszm�t kezd; a v�ltoztat�sokat elveti.}
menuText H GameFirst "Bet�lti az els j�tszm�t." 11 {Bet�lti az els sz�rt j�tszm�t.}
menuText H GamePrev "Bet�lti az elz j�tszm�t." 12 {Bet�lti az elz sz�rt j�tszm�t.}
menuText H GameReload "Ism�t bet�lti az aktu�lis j�tszm�t." 0 \
  {�jra bet�lti ezt a j�tszm�t; elvet minden v�ltoztat�st.}
menuText H GameNext "Bet�lti a k�vetkez j�tszm�t." 10 {Bet�lti a k�vetkez sz�rt j�tszm�t.}
menuText H GameLast "Bet�lti az utols j�tszm�t." 11 {Bet�lti az utols sz�rt j�tszm�t.}
menuText H GameRandom "V�letlenszer�en bet�lt egy j�tszm�t." 0 {V�letlenszer�en bet�lt egy sz�rt j�tszm�t.}
menuText H GameNumber "Megadott sorsz�m� j�tszma bet�lt�se..." 9 \
  {Bet�lti a sorsz�mmal megadott j�tszm�t.}
menuText H GameReplace "Ment�s cser�vel..." 7 \
  {Elmenti ezt a j�tszm�t; fel�l�rja a r�gi v�ltozatot.}
menuText H GameAdd "Ment�s �j j�tszmak�nt..." 0 \
  {Elmenti ezt a j�tszm�t; �j j�tszm�t hoz l�tre az adatb�zisban.}
menuText H GameDeepest "Megnyit�s azonos�t�sa" 10 \
  {Az ECO-k�nyvben szerepl legnagyobb m�lys�gig megy bele a j�tszm�ba.}
menuText H GameGotoMove "Ugr�s megadott sorsz�m� l�p�shez..." 1 \
  {Megadott sorsz�m� l�p�shez ugrik az aktu�lis j�tszm�ban.}
menuText H GameNovelty "�j�t�s keres�se..." 2 \
  {Megkeresi ebben a j�tszm�ban az els olyan l�p�st, amely kor�bban nem fordult el.}

# Search Menu:
menuText H Search "Keres�s" 0
menuText H SearchReset "Sz�r t�rl�se" 6 {Alaphelyzetbe hozza a sz�rt, hogy az �sszes j�tszma benne legyen.}
menuText H SearchNegate "Sz�r neg�l�sa" 6 {Neg�lja a sz�rt, hogy csak a kiz�rt j�tszm�k legyenek benne.}
menuText H SearchCurrent "Aktu�lis �ll�s..." 0 {A t�bl�n l�v �ll�st keresi.}
menuText H SearchHeader "Fejl�c..." 0 {Keres�s fejl�c (j�t�kos, esem�ny, stb.) alapj�n}
menuText H SearchMaterial "Anyag/mot�vum..." 6 {Keres�s anyag vagy �ll�sszerkezet alapj�n}
menuText H SearchUsing "Keresf�jl haszn�lata..." 0 {Keres�s SearchOptions f�jl haszn�lat�val}

# Windows menu:
menuText H Windows "Ablakok" 0
menuText H WindowsComment "Megjegyz�sszerkeszt" 0 {Megnyitja/bez�rja a megjegyz�sszerkesztt.}
menuText H WindowsGList "J�tszm�k list�ja" 9 {Kinyitja/becsukja a j�tszm�k list�j�t mutat ablakot.}
menuText H WindowsPGN "PGN-ablak" 0 \
  {Kinyitja/becsukja a PGN-(j�tszmajegyz�s)-ablakot.}
menuText H WindowsPList "J�t�koskeres" 0 {Kinyitja/becsukja a j�t�koskerest.}
menuText H WindowsTmt "Versenykeres" 0 {Kinyitja/becsukja a versenykerest.}
menuText H WindowsSwitcher "Adatb�zisv�lt" 0 \
  {Kinyitja/becsukja az adatb�zisv�lt ablakot.}
menuText H WindowsMaint "Adatb�zisgondoz ablak" 9 \
  {Kinyitja/becsukja az adatb�zisgondoz ablakot.}
menuText H WindowsECO "ECO-b�ng�sz" 0 {Kinyitja/becsukja az ECO-b�ng�sz ablakot.}
menuText H WindowsRepertoire "Reperto�rszerkeszt" 0 \
  {Megnyitja/bez�rja a megnyit�si reperto�rszerkesztt.}
menuText H WindowsStats "Statisztika" 0 \
  {Kinyitja/becsukja a sz�r�si statisztika ablak�t.}
menuText H WindowsTree "Fastrukt�ra-ablak" 0 {Kinyitja/becsukja a fastrukt�ra-ablakot.}
menuText H WindowsTB "V�gj�t�kt�bl�zatok ablaka" 8 \
  {Kinyitja/becsukja a v�gj�t�kt�bl�zatok ablak�t.}

# Tools menu:
menuText H Tools "Eszk�z�k" 0
menuText H ToolsAnalysis "Elemz motor..." 0 \
  {Elind�t/le�ll�t egy sakkelemz programot.}
menuText H ToolsAnalysis2 "2. elemz motor..." 0 \
  {Elind�tja/le�ll�tja a 2. sakkelemz programot.}
menuText H ToolsCross "Versenyt�bl�zat" 0 {Megmutatja az ehhez a j�tszm�hoz tartoz verseny t�bl�zat�t.}
menuText H ToolsEmail "Levelez�si sakk" 0 \
  {Kinyitja/becsukja az elektronikus sakklevelez�s lebonyol�t�s�ra szolg�l ablakot.}
menuText H ToolsFilterGraph "Sz�rgrafikon" 5 \
  {Kinyitja/becsukja a sz�rgrafikont mutat ablakot.}
menuText H ToolsOpReport "�sszefoglal a megnyit�srl" 0 \
  {Ismertett k�sz�t az aktu�lis �ll�shoz tartoz megnyit�srl.}
menuText H ToolsTracker "Figurak�vet"  0 {Kinyitja/becsukja a figurak�vet ablakot.}
menuText H ToolsPInfo "J�t�kosinform�ci"  0 \
  {Kinyitja/friss�ti a j�t�kos adatait tartalmaz ablakot.}
menuText H ToolsRating "�rt�ksz�m alakul�sa" 0\
  {Grafikusan �br�zolja, hogyan alakult az aktu�lis j�tszma r�sztvevinek �rt�ksz�ma.}
menuText H ToolsScore "Eredm�ny alakul�sa" 1 {Megmutatja az eredm�nygrafikont.}
menuText H ToolsExpCurrent "Az aktu�lis j�tszma export�l�sa" 21 \
  {Sz�vegf�jlba �rja az aktu�lis j�tszm�t.}
menuText H ToolsExpCurrentPGN "Export�l�s PGN-f�jlba..." 11 \
  {PGN-f�jlba �rja az aktu�lis j�tszm�t.}
menuText H ToolsExpCurrentHTML "Export�l�s HTML-f�jlba..." 11 \
  {HTML-f�jlba �rja az aktu�lis j�tszm�t.}
menuText H ToolsExpCurrentLaTeX "Export�l�s LaTeX-f�jlba..." 11 \
  {LaTeX-f�jlba �rja az aktu�lis j�tszm�t.}
menuText H ToolsExpFilter "Az �sszes sz�rt j�tszma export�l�sa" 10 \
  {Sz�vegf�jlba �rja az �sszes sz�rt j�tszm�t.}
menuText H ToolsExpFilterPGN "Sz�r export�l�sa PGN-f�jlba..." 18 \
  {PGN-f�jlba �rja az �sszes sz�rt j�tszm�t.}
menuText H ToolsExpFilterHTML "Sz�r export�l�sa HTML-f�jlba..." 18 \
  {HTML-f�jlba �rja az �sszes sz�rt j�tszm�t.}
menuText H ToolsExpFilterLaTeX "Sz�r export�l�sa LaTeX-f�jlba..." 18 \
  {LaTeX-f�jlba �rja az �sszes sz�rt j�tszm�t.}
menuText H ToolsImportOne "PGN-j�tszma import�l�sa..." 0 \
  {PGN-form�tum� j�tszma import�l�sa}
menuText H ToolsImportFile "PGN-f�jl import�l�sa..." 2 \
  {PGN-f�jl �sszes j�tszm�j�nak import�l�sa}

# Options menu:
menuText H Options "Be�ll�t�sok" 0
menuText H OptionsSize "T�blam�ret" 0 {A t�bla m�ret�nek v�ltoztat�sa}
menuText H OptionsPieces "Figur�k st�lusa" 0 {A figur�k megjelen�si form�j�nak v�ltoztat�sa}
menuText H OptionsColors "Sz�nek..." 0 {A t�bla sz�neinek v�ltoztat�sa}
menuText H OptionsExport "Export�l�s" 1 {Export�l�si be�ll�t�sok v�ltoztat�sa}
menuText H OptionsFonts "Karakterk�szlet" 0 {Karakterk�szlet v�ltoztat�sa}
menuText H OptionsFontsRegular "Szok�sos" 0 {A szok�sos karakterk�szlet v�ltoztat�sa}
menuText H OptionsFontsMenu "Men�" 0 {A men�k karakterk�szlet�nek a v�ltoztat�sa}
menuText H OptionsFontsSmall "Kisbet�s" 0 {A kisbet�s karakterk�szlet v�ltoztat�sa}
menuText H OptionsFontsFixed "R�gz�tett" 0 {A r�gz�tett sz�less�g� karakterk�szlet v�ltoztat�sa}
menuText H OptionsGInfo "J�tszmainform�ci" 0 {J�tszmainform�ci v�ltoztat�sa}
menuText H OptionsLanguage "Nyelv" 0 {A men� nyelv�nek kiv�laszt�sa}
menuText H OptionsMoves "L�p�sek" 0 {L�p�sek bevitel�nek be�ll�t�sai}
menuText H OptionsMovesAsk "L�p�s cser�je eltt r�k�rdez." 6 \
  {Mieltt �t�rna egy meglev l�p�st, r�k�rdez.}
menuText H OptionsMovesDelay "Automatikus visszaj�tsz�s k�sleltet�se..." 0 \
  {Be�ll�tja a k�sleltet�st automatikus visszaj�tsz�shoz.}
menuText H OptionsMovesCoord "L�p�s megad�sa koordin�t�kkal" 15 \
  {Koordin�t�kkal megadott l�p�st ("g1f3") is elfogad.}
menuText H OptionsMovesSuggest "Javaslat" 0 \
  {Be/kikapcsolja a l�p�sjavaslatot.}
menuText H OptionsMovesKey "Billenty�-kieg�sz�t�s" 0 \
  {Be/kikapcsolja a billenty�zettel r�szlegesen bevitt l�p�sek automatikus kieg�sz�t�s�t.}
menuText H OptionsNumbers "Sz�mform�tum" 1 {Sz�mform�tum kiv�laszt�sa}
menuText H OptionsStartup "Ind�t�s" 0 {Az ind�t�skor kinyitand ablakok kiv�laszt�sa}
menuText H OptionsWindows "Ablakok" 0 {Ablakbe�ll�t�sok}
menuText H OptionsWindowsIconify "Automatikus ikoniz�l�s" 12 \
  {A f ablak ikoniz�l�sakor az �sszes t�bbit is ikoniz�lja.}
menuText H OptionsWindowsRaise "Automatikus elhoz�s" 12 \
  {Elhoz bizonyos ablakokat (pl. elrehalad�s-s�vokat), amikor el vannak takarva.}
menuText H OptionsToolbar "Eszk�zt�r" 0 {A f ablak eszk�zt�r�nak �ssze�ll�t�sa}
menuText H OptionsECO "ECO-f�jl bet�lt�se..." 2 {Bet�lti az ECO-oszt�lyoz f�jlt.}
menuText H OptionsSpell "Helyes�r�s-ellenrz f�jl bet�lt�se..." 0 \
  {Bet�lti a helyes�r�s-ellenrz f�jlt.}
menuText H OptionsTable "V�gj�t�kt�bl�zatok k�nyvt�ra..." 0 \
  {V�gj�t�kt�bl�zat-f�jl kiv�laszt�sa; a k�nyvt�rban lev �sszes v�gj�t�kt�bl�zatot haszn�latba veszi.}
menuText H OptionsRecent "Aktu�lis f�jlok..." 3 \
  {A F�jl-men�ben megjelen�tett aktu�lis f�jlok sz�m�nak megv�ltoztat�sa}
menuText H OptionsSave "Be�ll�t�sok ment�se" 12 \
  "Minden be�ll�that �rt�ket elment a $::optionsFile f�jlba."
menuText H OptionsAutoSave "Be�ll�t�sok automatikus ment�se kil�p�skor." 0 \
  {Automatikusan elment minden be�ll�t�st, amikor kil�psz SCID-bl.}

# Help menu:
menuText H Help "Seg�ts�g" 0
menuText H HelpIndex "Tartalom" 0 {Megjelen�ti a tartalomjegyz�ket.}
menuText H HelpGuide "R�vid ismertet" 0 {R�vid ismertett ny�jt a program haszn�lat�rl.}
menuText H HelpHints "K�rd�s-felelet" 0 {N�h�ny hasznos tan�cs}
menuText H HelpContact "C�mek" 0 {Fontosabb internetc�mek}
menuText H HelpTip "A nap tippje" 2 {Hasznos tipp SCID haszn�lat�hoz}
menuText H HelpStartup "Indul ablak" 0 {A program ind�t�sakor megjelen ablak}
menuText H HelpAbout "SCID-rl" 0 {T�j�koztat�s SCID-rl}

# Game info box popup menu:
menuText H GInfoHideNext "Elrejti a k�vetkez l�p�st." 2
menuText H GInfoMaterial "Mutatja az anyagi helyzetet" 11
menuText H GInfoFEN "FEN-form�tum megmutat�sa" 0
menuText H GInfoMarks "Mutatja a sz�nes mezket �s nyilakat." 10
menuText H GInfoWrap "Hossz� sorok t�rdel�se" 0
menuText H GInfoFullComment "A teljes komment�rt megmutatja." 9
menuText H GInfoPhotos "Show Photos" 5 ;# ***
menuText H GInfoTBNothing "V�gj�t�kt�bl�zatok: nincs inform�ci" 20
menuText H GInfoTBResult "V�gj�t�kt�bl�zatok: csak eredm�ny" 25
menuText H GInfoTBAll "V�gj�t�kt�bl�zatok: eredm�ny �s a legjobb l�p�sek" 42
menuText H GInfoDelete "T�rli/helyre�ll�tja ezt a j�tszm�t." 0
menuText H GInfoMark "Megjel�li ezt a j�tszm�t/megsz�nteti a jel�l�st." 0

# Main window buttons:
helpMsg H .button.start {Ugr�s a j�tszma elej�re  (billenty�: Home)}
helpMsg H .button.end {Ugr�s a j�tszma v�g�re  (billenty�: End)}
helpMsg H .button.back {Vissza egy l�p�ssel  (billenty�: balra mutat ny�l)}
helpMsg H .button.forward {Elre egy l�p�ssel  (billenty�: jobbra mutat ny�l)}
helpMsg H .button.intoVar {Bel�p egy v�ltozatba  (gyorsbillenty�: v).}
helpMsg H .button.exitVar {Kil�p az aktu�lis v�ltozatbl  (gyorsbillenty�: z).}
helpMsg H .button.flip {T�bla elforgat�sa  (gyorsbillenty�: .)}
helpMsg H .button.coords {Koordin�t�k be- vagy kikapcsol�sa  (gyorsbillenty�: 0)}
helpMsg H .button.autoplay {Automatikus visszaj�tsz�s  (billenty�: Ctrl+Z)}

# General buttons:
translate H Back {Vissza}
translate H Cancel {M�gse}
translate H Clear {Ki�r�t}
translate H Close {Bez�r}
translate H Defaults {Alap�rt�kek}
translate H Delete {T�r�l}
translate H Graph {Grafikon}
translate H Help {Seg�ts�g}
translate H Import {Import}
translate H Index {Tartalom}
translate H LoadGame {J�tszma bet�lt�se}
translate H BrowseGame {J�tszma n�zeget�se}
translate H MergeGame {J�tszma beolvaszt�sa}
translate H Preview {Eln�zet}
translate H Revert {Visszat�r}
translate H Save {Ment}
translate H Search {Keres}
translate H Stop {�llj}
translate H Store {T�rol}
translate H Update {Friss�t}
translate H ChangeOrient {Ablak elhelyezked�s�nek v�ltoztat�sa}
translate H None {Egyik sem}
translate H First {Els}
translate H Current {Aktu�lis}
translate H Last {Utols}

# General messages:
translate H game {j�tszma}
translate H games {j�tszma}
translate H move {l�p�s}
translate H moves {l�p�s}
translate H all {mind}
translate H Yes {Igen}
translate H No {Nem}
translate H Both {Mindkett}
translate H King {Kir�ly}
translate H Queen {Vez�r}
translate H Rook {B�stya}
translate H Bishop {Fut}
translate H Knight {Husz�r}
translate H Pawn {Gyalog}
translate H White {Vil�gos}
translate H Black {S�t�t}
translate H Player {J�t�kos}
translate H Rating {�rt�ksz�m}
translate H RatingDiff {�rt�ksz�mk�l�nbs�g (Vil�gos - S�t�t)}
translate H AverageRating {�tlagos �rt�ksz�m}
translate H Event {Esem�ny}
translate H Site {Helysz�n}
translate H Country {Orsz�g}
translate H IgnoreColors {A sz�n k�z�mb�s.}
translate H Date {D�tum}
translate H EventDate {Az esem�ny d�tuma}
translate H Decade {�vtized}
translate H Year {�v}
translate H Month {Hnap}
translate H Months {janu�r febru�r m�rcius �prilis m�jus j�nius
  j�lius augusztus szeptember oktber november december}
translate H Days {vas�rnap h�tf kedd szerda cs�t�rt�k p�ntek szombat}
translate H YearToToday {Az utols egy �vben}
translate H Result {Eredm�ny}
translate H Round {Fordul}
translate H Length {Hossz}
translate H ECOCode {ECO-kd}
translate H ECO {ECO}
translate H Deleted {t�r�lt}
translate H SearchResults {A keres�s eredm�nye}
translate H OpeningTheDatabase {Adatb�zis megnyit�sa}
translate H Database {Adatb�zis}
translate H Filter {Sz�r}
translate H noGames {nincs j�tszma}
translate H allGames {az �sszes j�tszma}
translate H empty {�res}
translate H clipbase {v�gasztal}
translate H score {pontsz�m}
translate H StartPos {Kezd�ll�s}
translate H Total {�sszesen}

# Standard error messages:
translate H ErrNotOpen {Ez az adatb�zis nincs megnyitva.}
translate H ErrReadOnly {Ez az adatb�zis csak olvashat; nem lehet megv�ltoztatni.}
translate H ErrSearchInterrupted {Keres�s megszak�tva; az eredm�nyek hi�nyosak.}

# Game information:
translate H twin {iker}
translate H deleted {t�r�lt}
translate H comment {megjegyz�s}
translate H hidden {rejtett}
translate H LastMove {Utols l�p�s}
translate H NextMove {K�vetkez}
translate H GameStart {J�tszma eleje}
translate H LineStart {El�gaz�s eleje}
translate H GameEnd {J�tszma v�ge}
translate H LineEnd {El�gaz�s v�ge}

# Player information:
translate H PInfoAll {Eredm�nyek az <b>�sszes</b> j�tszma alapj�n}
translate H PInfoFilter {Eredm�nyek a <b>sz�rt</b> j�tszm�k alapj�n}
translate H PInfoAgainst {Eredm�nyek, ha az ellenf�l}
translate H PInfoMostWhite {Leggyakoribb megnyit�sok vil�gosk�nt}
translate H PInfoMostBlack {Leggyakoribb megnyit�sok s�t�tk�nt}
translate H PInfoRating {�rt�ksz�m alakul�sa}
translate H PInfoBio {�letrajz}

# Tablebase information:
translate H Draw {D�ntetlen}
translate H stalemate {patt}
translate H withAllMoves {az �sszes l�p�ssel}
translate H withAllButOneMove {egy h�j�n az �sszes l�p�ssel}
translate H with {with}
translate H only {csak}
translate H lose {vesz�tenek}
translate H loses {vesz�t}
translate H allOthersLose {minden m�s vesz�t}
translate H matesIn {mates in}
translate H hasCheckmated {mattot adott}
translate H longest {leghosszabb}
translate H WinningMoves {Nyer l�p�s}
translate H DrawingMoves {D�ntetlenre vezet l�p�s}
translate H LosingMoves {Veszt l�p�s}
translate H UnknownMoves {Bizonytalan kimenetel� l�p�s}

# Tip of the day:
translate H Tip {Tipp}
translate H TipAtStartup {Tipp indul�skor}

# Tree window menus:
menuText H TreeFile "F�jl" 0
menuText H TreeFileSave "Cache-f�jl ment�se" 11 {Elmenti a fastrukt�ra-cache-f�jlt (.stc)}
menuText H TreeFileFill "Cache-f�jl felt�lt�se" 14 \
  {Felt�lti a cache-f�jlt gyakori megnyit�sokkal.}
menuText H TreeFileBest "Legjobb j�tszm�k list�ja" 3 {Megmutatja a legjobb j�tszm�kat a f�rl.}
menuText H TreeFileGraph "Grafikon" 0 {Megmutatja ennek a fa�gnak a grafikonj�t.}
menuText H TreeFileCopy "Sz�veg m�sol�sa a v�glapra" 0 \
  {A ki�rt statisztikai adatokat a v�glapra m�solja.}
menuText H TreeFileClose "Faablak bez�r�sa" 10 {Bez�rja a fastrukt�ra-ablakot.}
menuText H TreeSort "Rendez�s" 0
menuText H TreeSortAlpha "ABC" 0
menuText H TreeSortECO "ECO-kd" 0
menuText H TreeSortFreq "Gyakoris�g" 0
menuText H TreeSortScore "Pontsz�m" 0
menuText H TreeOpt "Be�ll�t�sok" 0
menuText H TreeOptLock "R�gz�t�s" 0 {A f�t az aktu�lis adatb�zishoz k�ti ill. a k�t�st feloldja.}
menuText H TreeOptTraining "Edz�s" 0 {Edz�s�zemmd be- vagy kikapcsol�sa}
menuText H TreeOptAutosave "Cache-f�jl automatikus ment�se" 11 \
  {A faablak bez�r�sakor automatikusan elmenti a cache-f�jlt.}
menuText H TreeHelp "Seg�ts�g" 0
menuText H TreeHelpTree "Seg�ts�g a f�hoz" 0
menuText H TreeHelpIndex "Tartalom" 0
translate H SaveCache {Cache ment�se}
translate H Training {Edz�s}
translate H LockTree {R�gz�t�s}
translate H TreeLocked {r�gz�tve}
translate H TreeBest {Legjobb}
translate H TreeBestGames {Legjobb j�tszm�k a f�rl}
translate H TreeTitleRow \
  {    L�p�s  ECO       Gyakoris�g  Eredm. �tl�l Telj. �tl.�v}

# Finder window:
menuText H FinderFile "F�jl" 0
menuText H FinderFileSubdirs "Keres�s az alk�nyvt�rakban" 0
menuText H FinderFileClose "A f�jlkeres bez�r�sa" 15
menuText H FinderSort "Rendez�s" 0
menuText H FinderSortType "T�pus" 0
menuText H FinderSortSize "M�ret" 0
menuText H FinderSortMod "Id" 0
menuText H FinderSortName "N�v" 0
menuText H FinderSortPath "�tvonal" 0
menuText H FinderTypes "T�pusok" 0
menuText H FinderTypesScid "SCID-adatb�zisok" 0
menuText H FinderTypesOld "R�gi form�tum� SCID-adatb�zisok" 0
menuText H FinderTypesPGN "PGN-f�jlok" 0
menuText H FinderTypesEPD "EPD-f�jlok" 0
menuText H FinderTypesRep "Reperto�rf�jlok" 0
menuText H FinderHelp "Seg�ts�g" 0
menuText H FinderHelpFinder "Seg�ts�g a f�jlkeresh�z" 0
menuText H FinderHelpIndex "Tartalom" 0
translate H FileFinder {F�jlkeres}
translate H FinderDir {K�nyvt�r}
translate H FinderDirs {K�nyvt�rak}
translate H FinderFiles {F�jlok}
translate H FinderUpDir {fel}

# Player finder:
menuText H PListFile "F�jl" 0
menuText H PListFileUpdate "Friss�t" 0
menuText H PListFileClose "J�t�koskeres bez�r�sa" 16
menuText H PListSort "Rendez�s" 0
menuText H PListSortName "N�v" 0
menuText H PListSortElo "�l" 0
menuText H PListSortGames "J�tszm�k" 0
menuText H PListSortOldest "Legr�gibb" 0
menuText H PListSortNewest "Leg�jabb" 3

# Tournament finder:
menuText H TmtFile "F�jl" 0
menuText H TmtFileUpdate "Friss�t" 0
menuText H TmtFileClose "A versenykeres bez�r�sa" 18
menuText H TmtSort "Rendez�s" 0
menuText H TmtSortDate "D�tum" 0
menuText H TmtSortPlayers "J�t�kosok" 0
menuText H TmtSortGames "J�tszm�k" 1
menuText H TmtSortElo "�l" 0
menuText H TmtSortSite "Helysz�n" 0
menuText H TmtSortEvent "Esem�ny" 1
menuText H TmtSortWinner "Gyztes" 0
translate H TmtLimit "Lista hossza"
translate H TmtMeanElo "Legkisebb �tlagos �l"
translate H TmtNone "Nem tal�ltam hozz� versenyt."

# Graph windows:
menuText H GraphFile "F�jl" 0
menuText H GraphFileColor "Ment�s Color PostScript-k�nt..." 7
menuText H GraphFileGrey "Ment�s Greyscale PostScript-k�nt..." 7
menuText H GraphFileClose "Ablak bez�r�sa" 8
menuText H GraphOptions "Be�ll�t�sok" 0
menuText H GraphOptionsWhite "Vil�gos" 0
menuText H GraphOptionsBlack "S�t�t" 0
menuText H GraphOptionsBoth "Mindkett" 1
menuText H GraphOptionsPInfo "A j�t�kosinform�ci j�t�kosa" 0
translate H GraphFilterTitle "Sz�rgrafikon: gyakoris�g 1000 j�tszm�nk�nt"

# Analysis window:
translate H AddVariation {V�ltozat besz�r�sa}
translate H AddMove {L�p�s besz�r�sa}
translate H Annotate {Jegyzetekkel l�t el}
translate H AnalysisCommand {Elemz�sparancs}
translate H PreviousChoices {Kor�bbi v�laszt�sok}
translate H AnnotateTime {K�t l�p�s k�z�tti id m�sodpercben}
translate H AnnotateWhich {V�ltozatok hozz�ad�sa}
translate H AnnotateAll {Mindk�t f�l l�p�seihez}
translate H AnnotateWhite {Csak vil�gos l�p�seihez}
translate H AnnotateBlack {Csak s�t�t l�p�seihez}
translate H AnnotateNotBest {Ha a j�tszm�ban nem a legjobbat l�pt�k}

# Analysis Engine open dialog:
translate H EngineList {Elemz motorok list�ja}
translate H EngineName {N�v}
translate H EngineCmd {Parancs}
translate H EngineArgs {Param�terek}
translate H EngineDir {K�nyvt�r}
translate H EngineElo {�l}
translate H EngineTime {D�tum}
translate H EngineNew {�j}
translate H EngineEdit {Szerkeszt�s}
translate H EngineRequired {A vastagbet�s mezk sz�ks�gesek, a t�bbiek kihagyhatk.}

# Stats window menus:
menuText H StatsFile "F�jl" 0
menuText H StatsFilePrint "Nyomtat�s f�jlba..." 0
menuText H StatsFileClose "Ablak bez�r�sa" 0
menuText H StatsOpt "Be�ll�t�sok" 0

# PGN window menus:
menuText H PgnFile "F�jl" 0
menuText H PgnFilePrint "Nyomtat�s f�jlba..." 0
menuText H PgnFileClose "PGN-ablak bez�r�sa" 0
menuText H PgnOpt "Megjelen�t�s" 0
menuText H PgnOptColor "Sz�nes sz�veg" 0
menuText H PgnOptShort "R�vid (3-soros) fejl�c" 0
menuText H PgnOptSymbols "Szimblumok haszn�lata" 1
menuText H PgnOptIndentC "Megjegyz�sek beh�z�sa" 0
menuText H PgnOptIndentV "V�ltozatok beh�z�sa" 0
menuText H PgnOptColumn "Oszlopok st�lusa (soronk�nt egy l�p�s)" 0
menuText H PgnOptSpace "Szk�z a l�p�s sorsz�ma ut�n" 3
menuText H PgnOptStripMarks "Sz�nes mezk �s nyilak kifejt�se" 2
menuText H PgnColor "Sz�nek" 0
menuText H PgnColorHeader "Fejl�c..." 0
menuText H PgnColorAnno "Jegyzetek..." 0
menuText H PgnColorComments "Megjegyz�sek..." 0
menuText H PgnColorVars "V�ltozatok..." 0
menuText H PgnColorBackground "H�tt�r..." 0
menuText H PgnHelp "Seg�ts�g" 0
menuText H PgnHelpPgn "Seg�ts�g PGN-hez" 9
menuText H PgnHelpIndex "Tartalom" 0

# Crosstable window menus:
menuText H CrosstabFile "F�jl" 0
menuText H CrosstabFileText "Nyomtat�s sz�vegf�jlba..." 10
menuText H CrosstabFileHtml "Nyomtat�s HTML-f�jlba..." 10
menuText H CrosstabFileLaTeX "Nyomtat�s LaTeX-f�jlba..." 10
menuText H CrosstabFileClose "Ablak bez�r�sa" 0
menuText H CrosstabEdit "Szerkeszt�s" 0
menuText H CrosstabEditEvent "Esem�ny" 0
menuText H CrosstabEditSite "Helysz�n" 0
menuText H CrosstabEditDate "D�tum" 0
menuText H CrosstabOpt "Megjelen�t�s" 0
menuText H CrosstabOptAll "K�rm�rkz�s" 0
menuText H CrosstabOptSwiss "Sv�jci" 0
menuText H CrosstabOptKnockout "Kies�ses" 1
menuText H CrosstabOptAuto "� maga j�n r�." 0
menuText H CrosstabOptAges "�letkor �vben" 0
menuText H CrosstabOptNats "Nemzetis�g" 0
menuText H CrosstabOptRatings "�rt�ksz�mok" 1
menuText H CrosstabOptTitles "C�mek" 0
menuText H CrosstabOptBreaks "Pontsz�m holtverseny eld�nt�s�hez" 0
menuText H CrosstabOptDeleted "T�r�lt j�tszm�kkal egy�tt" 0
menuText H CrosstabOptColors "Sz�nek (csak sv�jci rendszer eset�n)" 2
menuText H CrosstabOptColumnNumbers "Sz�mozott oszlopok (csak k�rm�rkz�shez)" 2
menuText H CrosstabOptGroup "Pontcsoportok" 1
menuText H CrosstabSort "Rendez" 0
menuText H CrosstabSortName "N�v" 0
menuText H CrosstabSortRating "�rt�ksz�m" 0
menuText H CrosstabSortScore "Pontsz�m" 0
menuText H CrosstabColor "Sz�n" 0
menuText H CrosstabColorPlain "K�z�ns�ges sz�veg" 0
menuText H CrosstabColorHyper "Hypertext" 0
menuText H CrosstabHelp "Seg�ts�g" 0
menuText H CrosstabHelpCross "Seg�ts�g keresztt�bl�zathoz" 0
menuText H CrosstabHelpIndex "Tartalom" 0
translate H SetFilter {Sz�r be�ll�t�sa}
translate H AddToFilter {Hozz�adja a sz�rh�z}
translate H Swiss {Sv�jci}
translate H Category {Kategria}

# Opening report window menus:
menuText H OprepFile "F�jl" 0
menuText H OprepFileText "Nyomtat�s sz�vegf�jlba..." 10
menuText H OprepFileHtml "Nyomtat�s HTML-f�jlba..." 10
menuText H OprepFileLaTeX "Nyomtat�s LaTeX-f�jlba..." 10
menuText H OprepFileOptions "Be�ll�t�sok..." 0
menuText H OprepFileClose "Ablak bez�r�sa" 0
menuText H OprepHelp "Seg�ts�g" 0
menuText H OprepHelpReport "Seg�ts�g a megnyit�si �sszefoglalhoz" 0
menuText H OprepHelpIndex "Tartalom" 0

# Repertoire editor:
menuText H RepFile "F�jl" 0
menuText H RepFileNew "�j" 0
menuText H RepFileOpen "Megnyit�s..." 3
menuText H RepFileSave "Ment�s..." 0
menuText H RepFileSaveAs "Ment�s m�sk�nt..." 5
menuText H RepFileClose "Ablak bez�r�sa" 0
menuText H RepEdit "Szerkeszt�s" 0
menuText H RepEditGroup "Csoport hozz�ad�sa" 0
menuText H RepEditInclude "Beleveend el�gaz�s" 0
menuText H RepEditExclude "Kiz�rand el�gaz�s" 0
menuText H RepView "N�zet" 0
menuText H RepViewExpand "Az �sszes csoportot kibontja" 20
menuText H RepViewCollapse "Az �sszes csoportot �sszeh�zza" 20
menuText H RepSearch "Keres�s" 0
menuText H RepSearchAll "Az eg�sz reperto�rban..." 3
menuText H RepSearchDisplayed "Csak a megjelen�tett el�gaz�sokban..." 0
#Ez igen gyan�s!
menuText H RepHelp "Seg�ts�g" 0
menuText H RepHelpRep "Seg�ts�g a reperto�rhoz" 0
menuText H RepHelpIndex "Tartalom" 0
translate H RepSearch "Keres�s a reperto�rban"
translate H RepIncludedLines "beleveend el�gaz�sok"
translate H RepExcludedLines "kiz�rand el�gaz�sok"
translate H RepCloseDialog {Ebben a reperto�rban elmentetlen v�ltoztat�sok vannak.

T�nyleg folytatni akarod, �s elvetni a l�trehozott v�ltoztat�sokat?
}

# Header search:
translate H HeaderSearch {Keres�s fejl�c alapj�n}
translate H GamesWithNoECO {J�tszm�k ECO n�lk�l?}
translate H GameLength {J�tszmahossz}
translate H FindGamesWith {Megjel�lt j�tszm�k}
translate H StdStart {K�l�nleges ind�t�s}
translate H Promotions {�tv�ltoz�sok}
translate H Comments {Megjegyz�sek}
translate H Variations {V�ltozatok}
translate H Annotations {Jegyzetek}
translate H DeleteFlag {Megjel�l�s t�rl�se}
translate H WhiteOpFlag {Megnyit�s vil�gossal}
translate H BlackOpFlag {Megnyit�s s�t�ttel}
translate H MiddlegameFlag {K�z�pj�t�k}
translate H EndgameFlag {V�gj�t�k}
translate H NoveltyFlag {�j�t�s}
translate H PawnFlag {Gyalogszerkezet}
translate H TacticsFlag {Taktika}
translate H QsideFlag {Vez�rsz�rnyi j�t�k}
translate H KsideFlag {Kir�lysz�rnyi j�t�k}
translate H BrilliancyFlag {Csillog�s}
translate H BlunderFlag {Eln�z�s}
translate H UserFlag {Felhaszn�l}
translate H PgnContains {A PGN-ben sz�veg van.}

# Game list window:
translate H GlistNumber {Sz�m}
translate H GlistWhite {Vil�gos}
translate H GlistBlack {S�t�t}
translate H GlistWElo {Vil�gos �lje}
translate H GlistBElo {S�t�t �lje}
translate H GlistEvent {Esem�ny}
translate H GlistSite {Helysz�n}
translate H GlistRound {Fordul}
translate H GlistDate {D�tum}
translate H GlistYear {�v}
translate H GlistEDate {Az esem�ny d�tuma}
translate H GlistResult {Eredm�ny}
translate H GlistLength {Hossz}
translate H GlistCountry {Orsz�g}
translate H GlistECO {ECO}
translate H GlistOpening {Megnyit�s}
translate H GlistEndMaterial {V�gs anyagi helyzet}
translate H GlistDeleted {T�r�lt}
translate H GlistFlags {Megjel�l�sek}
translate H GlistVars {Variations}
translate H GlistComments {Megjegyz�sek}
translate H GlistAnnos {Jegyzetek}
translate H GlistStart {Kezdet}
translate H GlistGameNumber {A j�tszma sorsz�ma}
translate H GlistFindText {Sz�veg keres�se}
translate H GlistMoveField {L�p�s}
translate H GlistEditField {Konfigur�l�s}
translate H GlistAddField {Hozz�ad}
translate H GlistDeleteField {Elt�vol�t}
translate H GlistWidth {Sz�less�g}
translate H GlistAlign {Igaz�t}
translate H GlistColor {Sz�n}
translate H GlistSep {Elv�laszt}

# Maintenance window:
translate H DatabaseName {Az adatb�zis neve:}
translate H TypeIcon {T�pusikon:}
translate H NumOfGames {J�tszm�k:}
translate H NumDeletedGames {T�r�lt j�tszm�k:}
translate H NumFilterGames {Sz�rt j�tszm�k:}
translate H YearRange {�vtartom�ny:}
translate H RatingRange {�rt�ksz�mtartom�ny:}
translate H Description {Le�r�s}
translate H Flag {Megjel�l�s}
translate H DeleteCurrent {T�rli az aktu�lis j�tszm�t.}
translate H DeleteFilter {T�rli a sz�rt j�tszm�kat.}
translate H DeleteAll {Minden j�tszm�t t�r�l.}
translate H UndeleteCurrent {Helyre�ll�tja az aktu�lis j�tszm�t.}
translate H UndeleteFilter {Helyre�ll�tja a sz�rt j�tszm�kat.}
translate H UndeleteAll {Minden j�tszm�t helyre�ll�t.}
translate H DeleteTwins {T�rli az ikerj�tszm�kat.}
translate H MarkCurrent {Kijel�li az aktu�lis j�tszm�t.}
translate H MarkFilter {Kijel�li a sz�rt j�tszm�kat.}
translate H MarkAll {Minden j�tszm�t kijel�l.}
translate H UnmarkCurrent {Megsz�nteti az aktu�lis j�tszma kijel�l�s�t.}
translate H UnmarkFilter {Megsz�nteti a sz�rt j�tszm�k kijel�l�s�t.}
translate H UnmarkAll {Minden j�tszma kijel�l�s�t megsz�nteti.}
translate H Spellchecking {Helyes�r�s-ellenrz�s}
translate H Players {J�t�kosok}
translate H Events {Esem�nyek}
translate H Sites {Helysz�nek}
translate H Rounds {Fordulk}
translate H DatabaseOps {Adatb�zism�veletek}
translate H ReclassifyGames {ECO alapj�n oszt�lyozza a j�tszm�kat.}
translate H CompactDatabase {Adatb�zis t�m�r�t�se}
translate H SortDatabase {Adatb�zis rendez�se}
translate H AddEloRatings {�l-�rt�ksz�mok hozz�ad�sa}
translate H AutoloadGame {J�tszmasorsz�m automatikus bet�lt�se}
#Igaz ez?
translate H StripTags {PGN-c�mk�k elt�ntet�se}
translate H StripTag {C�mke elt�ntet�se}
translate H Cleaner {Takar�t}
translate H CleanerHelp {
SCID Takar�tja el fogja v�gezni az aktu�lis adatb�zison az �sszes olyan gondoz�si feladatot, amelyet az al�bbi list�rl kijel�lsz.

Az ECO-oszt�lyoz�sra �s az ikert�rl�sre vonatkoz jelenlegi be�ll�t�sok akkor jutnak �rv�nyre, ha ezeket a feladatokat is kijel�l�d.
}
translate H CleanerConfirm {
Ha a Takar�t m�r elindult, t�bb� nem lehet meg�ll�tani!

Nagy adatb�zison a kiv�lasztott feladatoktl �s aktu�lis be�ll�t�saiktl f�ggen a m�velet sok�ig eltarthat.

Biztos, hogy neki akarsz l�tni a kijel�lt gondoz�si feladatoknak?
}

# Comment editor:
translate H AnnotationSymbols  {Jegyzetszimblumok:}
translate H Comment {Megjegyz�s:}
translate H InsertMark {Jel�l�s besz�r�sa}

# Board search:
translate H BoardSearch {�ll�s keres�se}
translate H FilterOperation {Elv�gzend m�velet az aktu�lis sz�rn:}
translate H FilterAnd {�S (Sz�r sz�k�t�se)}
translate H FilterOr {VAGY (Sz�r bv�t�se)}
translate H FilterIgnore {SEMMI (Sz�r t�rl�se)}
translate H SearchType {A keres�s fajt�ja:}
translate H SearchBoardExact {Pontos �ll�s (minden figura azonos mezn)}
translate H SearchBoardPawns {Gyalogok (azonos anyag, minden gyalog azonos mezn)}
translate H SearchBoardFiles {Vonalak (azonos anyag, minden gyalog azonos vonalon)}
translate H SearchBoardAny {B�rmi (azonos anyag, gyalogok �s figur�k b�rhol)}
translate H LookInVars {V�ltozatokban is keres.}

# Material search:
translate H MaterialSearch {Keres�s anyagra}
translate H Material {Anyag}
translate H Patterns {Alakzatok}
translate H Zero {Nulla}
translate H Any {B�rmi}
translate H CurrentBoard {Aktu�lis �ll�s}
translate H CommonEndings {Gyakori v�gj�t�kok}
translate H CommonPatterns {Gyakori alakzatok}
translate H MaterialDiff {Anyagk�l�nbs�g}
translate H squares {mezk}
translate H SameColor {Azonos sz�n}
translate H OppColor {Ellenkez sz�n}
translate H Either {B�rmelyik}
translate H MoveNumberRange {L�p�startom�ny}
translate H MatchForAtLeast {Egyezzen legal�bb}
translate H HalfMoves {f�l l�p�sig.}
#�gy kell?
# Game saving:
translate H Today {Ma}
translate H ClassifyGame {J�tszma oszt�lyoz�sa}

# Setup position:
translate H EmptyBoard {T�bla letakar�t�sa}
translate H InitialBoard {Alap�ll�s}
translate H SideToMove {Ki l�p?}
translate H MoveNumber {L�p�s sz�ma}
translate H Castling {S�ncol�s}
translate H EnPassantFile {"En passant" f�jl}
translate H ClearFen {FEN t�rl�se}
translate H PasteFen {FEN beilleszt�se}

# Replace move dialog:
translate H ReplaceMove {L�p�s cser�je}
translate H AddNewVar {�j v�ltozat besz�r�sa}
translate H ReplaceMoveMessage {Itt m�r van l�p�s.

Kicser�lheted, mi�ltal az �sszes t k�vet l�p�s elv�sz, vagy l�p�sedet besz�rhatod �j v�ltozatk�nt.

(Ha a j�vben nem akarod l�tni ezt az �zenetet, kapcsold ki a Be�ll�t�sok:L�p�sek men�ben a "L�p�s cser�je eltt r�k�rdez." be�ll�t�st.)}

# Make database read-only dialog:
translate H ReadOnlyDialog {Ha ezt az adatb�zist kiz�rlag olvashatv� teszed, nem lehet v�ltoztat�sokat v�gezni rajta. Nem lehet j�tszm�kat elmenteni vagy kicser�lni, sem a t�rl�skijel�l�seket megv�ltoztatni. Minden rendez�s vagy ECO-oszt�lyoz�s csak �tmeneti lesz.

K�nnyen �jra �rhatv� teheted az adatb�zist, ha bez�rod, majd �jbl megnyitod.

T�nyleg kiz�rlag olvashatv� akarod tenni ezt az adatb�zist?}

# Clear game dialog:
translate H ClearGameDialog {Ez a j�tszma megv�ltozott.

T�nyleg folytatni akarod, �s elvetni a l�trehozott v�ltoztat�sokat?
}

# Exit dialog:
translate H ExitDialog {T�nyleg ki akarsz l�pni SCID-bl?}
translate H ExitUnsaved {A k�vetkez adatb�zisokban elmentetlen j�tszmav�ltoztat�sok vannak. Ha most kil�psz, ezek a v�ltoztat�sok elvesznek.}

# Import window:
translate H PasteCurrentGame {Beilleszti az aktu�lis j�tszm�t.}
translate H ImportHelp1 {Bevisz vagy beilleszt egy PGN-form�tum� j�tszm�t a fenti keretbe.}
translate H ImportHelp2 {Itt jelennek meg az import�l�s k�zben fell�p hib�k.}

# ECO Browser:
translate H ECOAllSections {az �sszes ECO-szakasz}
translate H ECOSection {ECO-szakasz}
#Ez bizony�ra valami �l�sszak, szval am�g foglalkozik vel�k.
translate H ECOSummary {�sszefoglal�s:}
translate H ECOFrequency {Alkdok gyakoris�ga:}

# Opening Report:
translate H OprepTitle {Megnyit�si �sszefoglal}
translate H OprepReport {�sszefoglal}
translate H OprepGenerated {K�sz�tette:}
#Lehet, hogy ez "k�sz�lt"?
translate H OprepStatsHist {Statisztika �s t�rt�net}
translate H OprepStats {Statisztika}
translate H OprepStatAll {Az �sszefoglal �sszes j�tszm�ja}
translate H OprepStatBoth {Mindkett:}
translate H OprepStatSince {Idszak kezdete:}
translate H OprepOldest {A legr�gibb j�tszm�k}
translate H OprepNewest {A leg�jabb j�tszm�k}
translate H OprepPopular {Jelenlegi n�pszer�s�g}
translate H OprepFreqAll {Gyakoris�g a teljes idszakban:   }
translate H OprepFreq1   {Az utbbi 1 �vben: }
translate H OprepFreq5   {Az utbbi 5 �vben: }
translate H OprepFreq10  {Az utbbi 10 �vben: }
translate H OprepEvery {minden %u j�tszm�ban egyszer}
translate H OprepUp {%u%s n�veked�s az �vek sor�n}
translate H OprepDown {%u%s cs�kken�s az �vek sor�n}
translate H OprepSame {nincs v�ltoz�s az �vek sor�n}
translate H OprepMostFrequent {Leggyakoribb j�t�kosok}
translate H OprepRatingsPerf {�rt�ksz�m �s teljes�tm�ny}
translate H OprepAvgPerf {�tlagos �rt�ksz�m �s teljes�tm�ny}
translate H OprepWRating {Vil�gos �rt�ksz�ma}
translate H OprepBRating {S�t�t �rt�ksz�ma}
translate H OprepWPerf {Vil�gos teljes�tm�nye}
translate H OprepBPerf {S�t�t teljes�tm�nye}
translate H OprepHighRating {A legnagyobb �tlag�rt�ksz�m� j�tszm�k}
translate H OprepTrends {Tendenci�k}
translate H OprepResults {Eredm�ny hossz�s�g �s gyakoris�g szerint}
translate H OprepLength {J�tszmahossz}
translate H OprepFrequency {Gyakoris�g}
translate H OprepWWins {Vil�gos nyer: }
translate H OprepBWins {S�t�t nyer: }
translate H OprepDraws {D�ntetlen:      }
translate H OprepWholeDB {teljes adatb�zis}
translate H OprepShortest {A legr�videbb gyzelmek}
translate H OprepMovesThemes {L�p�sek �s t�m�k}
translate H OprepMoveOrders {A vizsg�lt �ll�shoz vezet l�p�ssorrendek}
translate H OprepMoveOrdersOne \
  {Csak egy l�p�ssorrend vezetett ehhez az �ll�shoz:}
translate H OprepMoveOrdersAll \
  {%u l�p�ssorrend vezetett ehhez az �ll�shoz:}
translate H OprepMoveOrdersMany \
  {%u l�p�ssorrend vezetett ehhez az �ll�shoz. Az els %u:}
translate H OprepMovesFrom {A vizsg�lt �ll�sban tett l�p�sek}
translate H OprepThemes {Poz�cis t�m�k}
translate H OprepThemeDescription {T�m�k gyakoris�ga a %u-ik l�p�sben}
translate H OprepThemeSameCastling {S�ncol�s azonos oldalra}
translate H OprepThemeOppCastling {S�ncol�s ellenkez oldalra}
translate H OprepThemeNoCastling {Egyik kir�ly sem s�ncolt.}
translate H OprepThemeKPawnStorm {Kir�lysz�rnyi gyalogroham}
translate H OprepThemeQueenswap {Vez�rcsere}
translate H OprepThemeIQP {Elszigetelt vez�rgyalog}
translate H OprepThemeWP567 {Vil�gos gyalog az 5./6./7. soron}
translate H OprepThemeBP234 {S�t�t gyalog a 4./3./2. soron}
translate H OprepThemeOpenCDE {Ny�lt c/d/e-vonal}
translate H OprepTheme1BishopPair {Csak az egyik f�lnek van futp�rja.}
translate H OprepEndgames {V�gj�t�kok}
translate H OprepReportGames {Az �sszefoglal j�tszm�i}
translate H OprepAllGames    {Az �sszes j�tszma}
translate H OprepEndClass {Anyagi viszonyok az egyes j�tszm�k v�g�n}
translate H OprepTheoryTable {Elm�lett�bl�zat}
translate H OprepTableComment {a legnagyobb �rt�ksz�m� %u j�tszma alapj�n}
translate H OprepExtraMoves {A k�l�n megjegyz�ssel ell�tott l�p�sek sz�ma az elm�lett�bl�zatban}
translate H OprepMaxGames {Az elm�lett�bl�zat l�trehoz�s�hoz felhaszn�lhat j�tszm�k maxim�lis sz�ma}

# Piece Tracker window:
translate H TrackerSelectSingle {A bal eg�rgomb kiv�lasztja ezt a figur�t.}
translate H TrackerSelectPair {A bal eg�rgomb kiv�lasztja ezt a figur�t; a jobb eg�rgomb a p�rj�t is kiv�lasztja.}
translate H TrackerSelectPawn {A bal eg�rgomb kiv�lasztja ezt a gyalogot; a jobb eg�rgomb az �sszes gyalogot kiv�lasztja.}
translate H TrackerStat {Statisztika}
translate H TrackerGames {J�tszm�k %-a, amelyekben erre a mezre l�pett}
translate H TrackerTime {Id %-a, amelyet az egyes mezk�n t�lt�tt}
translate H TrackerMoves {L�p�sek}
translate H TrackerMovesStart {Add meg a l�p�s sz�m�t, amelyn�l a nyomk�vet�snek el kell kezddnie.}
translate H TrackerMovesStop {Add meg a l�p�s sz�m�t, amelyn�l a nyomk�vet�snek be kell fejezdnie.}

# Game selection dialogs:
translate H SelectAllGames {Az adatb�zis �sszes j�tszm�ja}
translate H SelectFilterGames {Csak a sz�rt j�tszm�k}
translate H SelectTournamentGames {Csak az aktu�lis verseny j�tszm�i}
translate H SelectOlderGames {Csak r�gebbi j�tszm�k}

# Delete Twins window:
translate H TwinsNote {K�t j�tszma akkor iker, ha ugyanazok j�tssz�k ket, �s megfelelnek az alant meghat�rozhat krit�riumoknak. Az ikerp�rbl a r�videbb j�tszma t�rldik.
Javaslat: ikrek t�rl�se eltt �rdemes helyes�r�s-ellenrz�st v�gezni az adatb�zison, mert az jav�tja az ikerfelder�t�st.}
translate H TwinsCriteria {Krit�riumok: Az ikerj�tszm�k k�z�s tulajdons�gai...}
translate H TwinsWhich {Megvizsg�lja, melyik j�tszma}
translate H TwinsColors {Azonos sz�n?}
translate H TwinsEvent {Ugyanaz az esem�ny?}
translate H TwinsSite {Azonos helysz�n?}
translate H TwinsRound {Ugyanaz a fordul?}
translate H TwinsYear {Azonos �v?}
translate H TwinsMonth {Azonos hnap?}
translate H TwinsDay {Ugyanaz a nap?}
translate H TwinsResult {Azonos eredm�ny?}
translate H TwinsECO {Azonos ECO-kd?}
translate H TwinsMoves {Azonos l�p�sek?}
translate H TwinsPlayers {A j�t�kosok nev�nek �sszehasonl�t�sakor:}
translate H TwinsPlayersExact {Teljes egyez�s kell.}
translate H TwinsPlayersPrefix {El�g az els 4 bet�nek egyeznie.}
translate H TwinsWhen {Ikerj�tszm�k t�rl�sekor:}
translate H TwinsSkipShort {Hagyjuk figyelmen k�v�l az 5 l�p�sn�l r�videbb j�tszm�kat?}
translate H TwinsUndelete {Elsz�r �ll�tsuk helyre az �sszes j�tszm�t?}
translate H TwinsSetFilter {A sz�rt �ll�tsuk az �sszes t�r�lt ikerj�tszm�ra?}
translate H TwinsComments {A megjegyz�sekkel ell�tott j�tszm�kat mindig tartsuk meg?}
translate H TwinsVars {A v�ltozatokat tartalmaz j�tszm�kat mindig tartsuk meg?}
translate H TwinsDeleteWhich {Melyik j�tszm�t t�r�ljem?}
translate H TwinsDeleteShorter {A r�videbbet}
translate H TwinsDeleteOlder {A kisebb sorsz�m�t}
translate H TwinsDeleteNewer {A nagyobb sorsz�m�t}
translate H TwinsDelete {J�tszm�k t�rl�se}

# Name editor window:
translate H NameEditType {Szerkesztend n�vt�pus}
translate H NameEditSelect {Szerkesztend j�tszm�k}
translate H NameEditReplace {Amit cser�l}
translate H NameEditWith {Amire cser�li}
translate H NameEditMatches {Egyez�sek: Ctrl+1...Ctrl+9 v�laszt.}

# Classify window:
translate H Classify {Oszt�lyoz}
translate H ClassifyWhich {Mely j�tszm�k ECO-oszt�lyoz�s�t v�gezze el?}
translate H ClassifyAll {Az �sszes�t (�rja fel�l a r�gi ECO-kdokat)}
translate H ClassifyYear {Az utbbi �vben j�tszott j�tszm�k�t}
translate H ClassifyMonth {Az utbbi hnapban j�tszott j�tszm�k�t}
translate H ClassifyNew {Csak az eddig m�g nem oszt�lyozott j�tszm�k�t}
translate H ClassifyCodes {Haszn�land ECO-kdok:}
translate H ClassifyBasic {Csak az alapkdok ("B12", ...)}
translate H ClassifyExtended {Kiterjesztett SCID-kdok ("B12j", ...)}

# Compaction:
translate H NameFile {N�vf�jl}
translate H GameFile {J�tszmaf�jl}
translate H Names {Nevek}
translate H Unused {Haszn�laton k�v�l}
translate H SizeKb {M�ret (kB)}
translate H CurrentState {Jelenlegi �llapot}
translate H AfterCompaction {T�m�r�t�s ut�n}
translate H CompactNames {N�vf�jl t�m�r�t�se}
translate H CompactGames {J�tszmaf�jl t�m�r�t�se}

# Sorting:
translate H SortCriteria {Krit�riumok}
translate H AddCriteria {Krit�riumok hozz�ad�sa}
translate H CommonSorts {Szok�sos rendez�sek}
translate H Sort {Rendez�s}

# Exporting:
translate H AddToExistingFile {J�tszm�k hozz�ad�sa l�tez f�jlhoz?}
translate H ExportComments {Megjegyz�sek export�l�sa?}
translate H ExportVariations {V�ltozatok export�l�sa?}
translate H IndentComments {Megjegyz�sek igaz�t�sa?}
translate H IndentVariations {V�ltozatok igaz�t�sa?}
translate H ExportColumnStyle {Oszlop st�lusa (soronk�nt egy l�p�s)?}
translate H ExportSymbolStyle {Szimblumok st�lusa:}
translate H ExportStripMarks {Kivegye a megjegyz�sekbl a mez- �s ny�lmegjel�l�seket?}

# Goto game/move dialogs:
translate H LoadGameNumber {A bet�ltend j�tszma sorsz�ma:}
translate H GotoMoveNumber {Ugr�s a k�vetkez l�p�shez:}

# Copy games dialog:
translate H CopyGames {J�tszm�k m�sol�sa}
translate H CopyConfirm {
 T�nyleg �t akarod m�solni
 a [thousands $nGamesToCopy] sz�rt j�tszm�t
 a "$fromName" adatb�zisbl
 a "$targetName" adatb�zisba?
}
translate H CopyErr {Nem tudom �tm�solni a j�tszm�kat.}
translate H CopyErrSource {forr�s}
translate H CopyErrTarget {c�l}
translate H CopyErrNoGames {sz�rj�ben nincsenek j�tszm�k.}
translate H CopyErrReadOnly {kiz�rlag olvashat.}
translate H CopyErrNotOpen {nincs megnyitva.}

# Colors:
translate H LightSquares {Vil�gos mezk}
translate H DarkSquares {S�t�t mezk}
translate H SelectedSquares {Kiv�lasztott mezk}
translate H SuggestedSquares {Javasolt l�p�sek mezi}
translate H WhitePieces {Vil�gos figur�k}
translate H BlackPieces {S�t�t figur�k}
translate H WhiteBorder {Vil�gos k�rvonal}
translate H BlackBorder {S�t�t k�rvonal}

# Novelty window:
translate H FindNovelty {�j�t�s keres�se}
translate H Novelty {�j�t�s}
translate H NoveltyInterrupt {�j�t�skeres�s le�ll�tva}
translate H NoveltyNone {Ebben a j�tszm�ban nem tal�ltam �j�t�st.}
translate H NoveltyHelp {
SCID megkeresi az aktu�lis j�tszma els olyan l�p�s�t, amely nem szerepel sem a kiv�lasztott adatb�zisban, sem az ECO megnyit�st�rban.
}

# Upgrading databases:
translate H Upgrading {Fel�j�t�s}
translate H ConfirmOpenNew {
Ez r�gi form�tum� (SCID 2) adatb�zis, amelyet SCID 3 nem tud megnyitni, de m�r l�trehozott egy �j form�tum� (SCID 3) verzit.

Szeretn�d megnyitni az adatb�zis �j form�tum� verzij�t?
}
translate H ConfirmUpgrade {
Ez r�gi form�tum� (SCID 2) adatb�zis. �j form�tum� verzit kell l�trehozni belle, hogy SCID 3 haszn�lni tudja.

A fel�j�t�s �j verzit hoz l�tre az adatb�zisbl. Az eredeti f�jlok s�rtetlen�l megmaradnak.

Az elj�r�s eltarthat egy darabig, de csak egyszer kell elv�gezni. Megszak�thatod, ha t�l sok�ig tart.

Szeretn�d most fel�j�tani ezt az adatb�zist?
}

# Recent files options:
translate H RecentFilesMenu {Az aktu�lis f�jlok sz�ma a F�jl-men�ben}
translate H RecentFilesExtra {Az aktu�lis f�jlok sz�ma a kieg�sz�t almen�ben}

}
# end of hungary.tcl

