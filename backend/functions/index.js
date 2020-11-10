// Import the Firebase SDK for Google Cloud Functions.
const functions = require('firebase-functions');
// Import and initialize the Firebase Admin SDK.
const admin = require('firebase-admin');

admin.initializeApp(functions.config().functions);

var newData;

exports.makeUppercase = functions.firestore.document('/reservas/{documentId}')
    .onCreate(async(snapshot, context) => {
        if (snapshot.empty) {
            console.log('No Devices');
            return;
        }
        newData = snapshot.data();
        //variables de fecha y hora actual
        var fecha = DateTime.now();
        var _timeunix  = fecha.toUtc().millisecondsSinceEpoch;

        const reservas = await admin
        .firestore()
        .collection('Reservas')
        .where('fechareservaunix', isGreaterThanOrEqualTo, _timeunix)
        .get()
        
        var tokens = [];
        for (var cita of reservas.docs) {
            tokens.push(cita.data());
        }

        tokens.forEach((tokenDoc) => {

            var date = new DateTime.fromMillisecondsSinceEpoch(tokenDoc['fechaunix']);
            var dateSubstract = date.subtract(Duration(minutes, 30));
            var scheduledTime=DateFormat('YYYY-MM-DD HH:MM:SS', 'es_ES').format(dateSubstract);

            var payload = {
                notification: {
                    title: 'Push Title',
                    body: 'Push Body',
                    sound: 'default',
                   

                },
                data: {
                    push_key: 'Push Key Value',
                    key1: newData.data,
                },
            };
         
            try {
                const response = await admin.messaging().sendToDevice(tokens, payload);
                console.log('Notification sent successfully');
            } catch (err) {
                console.log(err);
            }

        });

        console.log('holaaa');
        console.log(tokens);
        
    });

    
   
//exports.messageTrigger = functions.FirebaseFirestore.documents('reservas/{reservasId}').onCreateasync(snapshot, context);

// // Create and Deploy Your First Cloud Functions
// // https://firebase.google.com/docs/functions/write-firebase-functions
//
// exports.helloWorld = functions.https.onRequest((request, response) => {
//   functions.logger.info("Hello logs!", {structuredData: true});
//   response.send("Hello from Firebase!");
// });
