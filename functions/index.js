/**
 * Import function triggers from their respective submodules:
 *
 * const {onCall} = require("firebase-functions/v2/https");
 * const {onDocumentWritten} = require("firebase-functions/v2/firestore");
 *
 * See a full list of supported triggers at https://firebase.google.com/docs/functions
 */
const { onDocumentCreated } = require("firebase-functions/v2/firestore");
const admin = require("firebase-admin");

admin.initializeApp({ credential: admin.credential.applicationDefault() });

exports.myFunction = onDocumentCreated("chat/{messageId}", (event) => {
    const snap = event.data;
    return admin.messaging().sendToTopic("chat", {
        notification: {
            title: snap.data()['username'],
            body: snap.data()['text'],
            clickAction: "FLUTTER_NOTIFICATION_CLICK",
        }
    });
});