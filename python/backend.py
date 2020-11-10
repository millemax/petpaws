import firebase_admin
from firebase_admin import credentials
from firebase_admin import firestore
from datetime import datetime, timedelta
import time
import requests
import json

# initializations  credential
cred = credentials.Certificate('/home/jhon/development/ayniApps/petpaws/python/petpaws-bd.json')
firebase_admin.initialize_app(cred)
db = firestore.client()
while True:
    #format datetime now to milliseconds
    today = datetime.now()
    mediahora=timedelta(minutes=30)
    notification=today+mediahora
    seconds_since_epoch = time.mktime(notification.timetuple()) * 1000

    print(today)
    print(today.strftime("%X"))
    print(notification.strftime("%X"))

    #reading data from firestore 
    emp_ref = db.collection('reservas').where('fechareservaunix','==',seconds_since_epoch)
    docs = emp_ref.stream()
    for doc in docs:
        reser=doc.to_dict()['fechareservaunix']
        print(reser)
        #FCM google cloud
        serverToken = 'AAAAWEGRfTk:APA91bEHXB-C6aa6H0p1eT5T7WP6zYmNi0b6BKy57To_54knAjUi1nwRzB4KgtpL0ZYP-ycxyMQNbZbzAgWZ2pyYIWDYCZag5V23yOW9ikD9u2gEdvzwl2llJoQB2MsQdgziUXxGtpYL'
        deviceToken = doc.to_dict()['tokenDevice']
        horainicio = doc.to_dict()['horainicioreserva']
        headers = {
            'Content-Type': 'application/json',
            'Authorization': 'key=' + serverToken,
        }


        body = {
            'notification': {
                'title': doc.to_dict()['nombredueno'],
                'body': 'Tiene una reserva a las {}, ¿Desea posponerlo?'.format(horainicio),
            },
            'to': deviceToken,
            'priority': 'high',
            'data' : {
            'title' : 'TITLE_HERE',
            'message' : 'MESSAGE_HERE',
            'click_action':'FLUTTER_NOTIFICATION_CLICK'
            }
        }
        response = requests.post("https://fcm.googleapis.com/fcm/send",headers = headers, data=json.dumps(body))
        print(response.status_code)
        print(response.json())
    time.sleep(1)
        