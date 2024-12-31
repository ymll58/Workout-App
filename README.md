
# Workout-App
iOS-Training-Anwendung, die entwickelt wurde, um Benutzern dabei zu helfen, ihre Fitnessziele zu erreichen, indem sie ihnen eine Vielzahl von Übungen anzeigt und ihren Fortschritt verfolgt.
Die App bietet eine große Auswahl an Übungen für verschiedene Muskelgruppen und Fitnessziele. Jede Übung ist detailliert beschrieben und mit Videoanleitungen versehen, um eine korrekte Ausführung sicherzustellen.

# Verwendete Ressourcen
   
* **Firebase**
 
* **GoogleAdMobs**
   
* **UserNotifications Library**

# Entwickler

* **Khaled Trabelsi**
* **Youssef Mellouli**

# Über die App
   
Diese App enthält eine Sammlung von Trainingsübungen, aber auch einen Abschnitt Maße, der es dem Benutzer erlaubt, seine persönlichen Daten wie Gewicht, Größe und Körperfettmasse zu speichern. Es gibt auch eine Grafik, die die Messwerte in Diagrammform mit spezifischem Datum und Uhrzeit ausgibt.
   
Beachten Sie, dass die App nur mit den neuesten Apple-Geräten kompatibel ist. (Iphone 11 Pro Max zum Testen verwendet)
   
 
**App View :**
   
enthält ein TabView, das dem Benutzer hilft, von Ansicht zu Ansicht zu navigieren, wie hier geschrieben:
   
    > TabView{
   
        ContentView()
   
            .tabItem{
   
            Image(systemName: "list.dash")
   
            .font(.title)
   
            Text("Exercices")
                
            }
   
 
**Main view :**
   
enthält eine Liste der Körperteile, die den Benutzer zu den entsprechenden Übungen weiterleitet.
   
Dies wurde mit einer **Navigationsansicht** gemacht, ex :
   
    > NavigationView{
   
        List{
   
        ForEach(bodyParts) {
   
        bodyPart in
   
        if(bodyPart.name=="Chest"){
   
        NavigationLink(destination : GeneralView(str: bodyPart.name)){
   
        ContentRow(name: bodyPart.name)
   
    }
   
 
**Measures :**
   
 
Das TabView "Measures" ist mit dem View "Userinput.swift" verknüpft.


userinput enthält im wesentlichen Textfelder, die die vom Benutzer eingegebenen Werte aufnehmen und Sie in der Datenbank setzen.


Die Elemente werden dann in dieser Form gespeichert:
   
 
Sammlung: PID->("eindeutige Telefon-ID")->Maßnahmen->("Datum")==>
   
 
  - Datum
   
 
  - Fettmasse
   
 
  - Höhe
   
 
  - Gewicht
   
 
unsere Datenbank speichert die eindeutige Telefon-ID "PID" und speichert dann die Maße jedes pid, so dass jeder Benutzer nur auf seine "Diagramme" zugreifen kann.
   
 
und so wurden die Benutzer Messungen in unsere firestore-Datenbank eingegeben.
   
 
In den Benutzereingaben wurden einige if-Anweisungen implementiert, um den Benutzer daran zu hindern, andere Symbole als "Double" Zahlen einzugeben. Wenn der Benutzer also ein ungeffültes Feld lässt oder ein Sonderzeichen eingibt, erscheint ein Alert, um ihn über seinen Fehler zu informieren.Eine weitere Alert angezeigt, wenn der Benutzer die richtigen Werte eingibt.
   
 
(wenn der Benutzer ein Gerät benutzt, erscheint in Wirklichkeit nur der Nummernblock, so dass er kein anderes Symbol als Zahlen eingeben kann,die if-Anweisungen wurden zum Zweck der Simulation tatsächlich kodiert ).
   
 
**Charts :**
   
 
Das "Charts" TabView ist mit der "BargraphView.swift" verknüpft, hier wird die "PID collection" innerhalb der getGraphData()-Klasse aufgerufen und dank eines Snapshot-Listeners stellt die Datenbank alle Änderungen in Echtzeit zur Verfügung.
   
 
Nach dem Abrufen der Benutzerdaten berechnet die getBMI()-Funktion die bmi des Benutzers, die später Seite an Seite mit dem Gewicht des Benutzers in Form von Graphen angezeigt wird.
   
 
die Balkenlängen wurden dank der Funktionen "getbmibarlength() und get barlength()" ermittelt.
   
 
Die Ansicht chartLegend ist selbsterklärend, es ist eine Legende, die die Elemente im Diagramm erklärt.
   
 
**More View:**
   
Diese Ansicht enthält mehrere Schaltflächen, die uns zu einem Popup-Fenster weiterleiten.
   
Es erlaubt dem Benutzer, die Anwendung durch das Ausfüllen von Sternen zu bewerten (eingereichte Sterne bleiben gespeichert, auch wenn wir die Anwendung neu starten, und zwar dank der Funktion UserDefault) die Mitwirkenden der App zu sehen, mit den Entwicklern in Kontakt zu treten, die Version der App zu sehen und sie auch durch das Ansehen einer Anzeige zu unterstützen.
   
 
**General View :**
   
diese Ansicht ist eine allgemeine Ansicht für alle Körperteile, die in der App.
   
GeneralView erhält einen Konstruktor, damit es weiß, welche Liste von Übungen es aus unserer Datenbank (Cloud Firestore) aufrufen muss, wie hier zu sehen:
   
    > NavigationLink(destination : GeneralView(str: bodyPart.name))
   
    die Klasse getData() iteriert durch die Dokumente in der Datenbank und speichert die Daten in einem Platzhalter vom Typ Exercice :
   
    > struct Exercice : Identifiable {
   
        var id: String
   
        var title: String
   
        var description:String
   
        var pic:String
   
    }
   
 
mit Hilfe seiner Funktion retrieve(str : String), die später aufgerufen wird, um den Inhalt jeder Übung in der Ansicht ContentDescription auszugeben.
   
Bilder werden auch mit der Klasse ImageLoader aus dem Speicher abgerufen
   
    >func loadImage(url: String) {
   
        let imageRef = Storage.storage().reference(forURL: url)
   
        imageRef.getData(maxSize: 1 * 1024 * 1024) { data, error in
   
        if let error = error {
   
        print("\(error)")
   
    }
   
    guard let data = data else { return }
   
        DispatchQueue.main.async {
    
        self.data = data
   
            }
   
        }
   
    }
   
 
und werden so in der Funktion URLImage transformiert, dass sie unserer Ansicht nach richtig gesehen wird:
   
    >Image(uiImage:
   
        imageLoader.data != nil ? UIImage(data: imageLoader.data!)! : UIImage())
   
        .resizable()
   
        .frame(width: 250, height: 140.0)
   
        .background(Color.gray)
   
        .clipShape(RoundedRectangle(cornerRadius: 5.0))
   
        .scaleEffect(finalAmount + currentAmount)
   
        .gesture(
   
        MagnificationGesture()
   
        .onChanged { amount in
   
        self.currentAmount = amount - 1
   
    }
   
    .onEnded { amount in
   
        self.finalAmount += self.currentAmount
   
        self.currentAmount = 0
   
        }
   
)
   
Die Funktion MagnificationGesture() erlaubt es uns, die Größe des Bildes durch Einklemmen zu ändern, wodurch es für den Benutzer klarer zu sehen ist
   
 
**Notifications :**
   
Push-Benachrichtigungen können mit Hilfe dieses Codes in unserem AppDelegate aktiviert werden. Der Benutzer wird gefragt, ob er sie zulassen möchte oder nicht:
   
     > func registerForPushNotifications() {
   
        UNUserNotificationCenter.current()
   
       .requestAuthorization(options: [.alert, .sound, .badge]) {(granted, error) in
   
        print("Permission granted: \(granted)")
   
        }
   
    }
   
 
Beachten Sie, um die Push-Benachrichtigung im Simulator auszuführen, und zwar durch Drag & Drop der "notif.apns"-Datei auf den Telefonbildschirm. 
-die notif.apns enthält die Bundle-ID und die Nachricht der Benachrichtigung, dass dies nicht funktioniert, wenn die App läuft! ( eine .apns-Datei kann zum Testen gefunden werden)
   
 
**SwiftUIAdBanner & SwiftUIAdInterstitial:**
   
Diese Codedateien erlauben es uns, Anzeigen mit den Methoden Banner() und showAd() anzuzeigen. Sie sind eigentlich eine Konvertierung der Anzeigen von UIKit zu SwiftUI
 
>>>>>>> f11e5d0 (°)
