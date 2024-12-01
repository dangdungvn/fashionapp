const admin = require('firebase-admin')


 const sendPushNotification = async (deviceToken,title, body, data, ) => {
    const message = {
        notification: {
            title: title,
            body: body,
        },
        data: data,
        token: deviceToken
    }

    try {
        await admin.messaging().send(message);
        console.log('Push notification sent successfully');
    } catch (error) {
        console.log('Error:', "Error sending push notification: ");
    }
}


module.exports = {sendPushNotification};