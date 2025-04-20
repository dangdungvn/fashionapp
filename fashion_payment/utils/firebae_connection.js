const admin = require('firebase-admin')
const serviceAccount = require('../serviceKey.json')

const fireBaseConnection = async () => {
    admin.initializeApp({
        credential: admin.credential.cert(serviceAccount),
      });
      console.log("SERVER IS CONNECTED TO FIREBASE");
}


module.exports = {fireBaseConnection};