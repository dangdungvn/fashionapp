const express = require('express')
const app = express();
const cors = require('cors');
const Stripe = require("stripe");
const dotenv = require('dotenv');
const stripeRouter = require("./routes/stripe");
const bodyParser = require('body-parser');
const { fireBaseConnection } = require('./utils/firebae_connection');
const { sendPushNotification } = require('./utils/send_notification')

dotenv.config()
const stripe = Stripe(process.env.STRIPE_SECRET);
const endpointSecret = process.env.ENDPOINT_SECRET;

fireBaseConnection();

app.post('/webhook', express.raw({ type: 'application/json' }), (request, response) => {
  const sig = request.headers['stripe-signature'];

  let event;

  try {
    event = stripe.webhooks.constructEvent(request.body, sig, endpointSecret);
  } catch (err) {
    response.status(400).send(`Webhook Error: ${err.message}`);
    return;
  }


  // Handle the event
  switch (event.type) {
    case 'payment_intent.succeeded':
      paymentIntentSucceeded = event.data.object;
      break;

    case 'checkout.session.completed':
      const checkoutData = event.data.object;
      console.log("Session Completed");
      stripe.customers
        .retrieve(checkoutData.customer)
        .then(async (customer) => {
          try {
            const data = JSON.parse(customer.metadata.cart);

            const products = data.map((item) => ({
              product: item.id,
              quantity: item.cartQuantity,
              size: item.size,
              color: item.color,
            }));


            const totalQuantity = products.reduce((total, item) => total + item.quantity, 0);

            const payload = {
              customer_id: checkoutData.customer,
              order_products: products,
              total_quantity: totalQuantity,
              address: customer.metadata.address,
              subtotal: checkoutData.amount_subtotal / 100,
              total: checkoutData.amount_total / 100,
              payment_status: checkoutData.payment_status,
              delivery_status: "Pending",
            };

            console.log('====================================');
            console.log(payload);
            console.log('====================================');

            await createOrder(payload, customer.metadata.accesstoken, customer.metadata.fcm)

          } catch (err) {
            console.log(err.message);
          }
        })
        .catch((err) => console.log(err.message));
      break;

    default:
      console.log(`Unhandled event type ${event.type}`);
  }

  response.send();
});

app.use(bodyParser.json({ limit: '10mb' }));
app.use(bodyParser.urlencoded({ limit: '10mb', extended: true }));

app.use("/stripe", stripeRouter);

app.listen(process.env.PORT || port, () => console.log(`App listening on port ${process.env.PORT}!`))

const createOrder = async (payload, accessToken, fcm) => {

  try {
    const response = await fetch(
      "http://127.0.0.1:8000/api/orders/add",
      {
        method: "POST",
        headers: {
          "Content-Type": "application/json",
          "Authorization": `Token ${accessToken}`,
        },
        body: JSON.stringify(payload),
      }
    );


    if (response.status === 201) {
      const responseData = await response.json();
      const data = {
        'id': responseData['id'].toString()
      }
      const title = 'Order Successfully Placed'
      const message = 'Your payment has been successfully completed and your order is now being processed'
      // if (fcm !== '') {
      //   sendPushNotification(fcm, title, message, data);
      // }
    }
  } catch (error) {
    console.log('====================================');
    console.log(error);
    console.log('====================================');
    // const data = {
    //   'id': 'error'
    // }
    // const title = 'Failed Placing Order'
    // const message = 'Your payment has failed completed and please reorder or contact our team'
    // sendPushNotification(fcm, title, message, data);
  }
};

