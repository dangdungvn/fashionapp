const express = require("express");
const Stripe = require("stripe");
const fs = require("fs");
const path = require("path");
require("dotenv").config();

const stripe = Stripe(process.env.STRIPE_SECRET);

const router = express.Router();

const checkoutSuccessPage = fs.readFileSync(
  path.join(__dirname, "checkout-success.html")
);

router.get("/checkout-success", (req, res) => {
  res.set("Content-Type", "text/html");
  res.send(checkoutSuccessPage);
});

const checkoutCancel = fs.readFileSync(path.join(__dirname, "cancel.html"));

router.get("/cancel", (req, res) => {
  res.set("Content-Type", "text/html");
  res.send(checkoutCancel);
});

// https://e0e5-146-70-95-181.ngrok-free.app/stripe/create-checkout-session
router.post("/create-checkout-session", async (req, res) => {
  const customer = await stripe.customers.create({
    metadata: {
      address: req.body.address,
      accesstoken: req.body.accesstoken,
      fcm: req.body.fcm,
      cart: JSON.stringify(req.body.cartItems),
    },
  });

  const deliveryFee = 1000; // Assuming delivery fee is $10.00
  const deliveryFeeItem = {
    price_data: {
      currency: "usd",
      product_data: {
        name: "Delivery Fee",
      },
      unit_amount: deliveryFee,
    },
    quantity: 1,
  };

  const lineItems = req.body.cartItems.map((item) => {
    return {
      price_data: {
        currency: "usd",
        product_data: {
          name: item.name,
          description: item.name,
          metadata: {
            id: item.accessToken,
            address: item.address,
          },
        },
        unit_amount: item.price * 100,
      },
      quantity: item.cartQuantity,
    };
  });

  lineItems.push(deliveryFeeItem);

  const session = await stripe.checkout.sessions.create({
    payment_method_types: ["card"],

    phone_number_collection: {
      enabled: false,
    },
    line_items: lineItems, // Use lineItems instead of line_items
    mode: "payment",
    customer: customer.id,
    success_url:
      "https://smoothly-pro-scorpion.ngrok-free.app/stripe/checkout-success",
    cancel_url: "https://smoothly-pro-scorpion.ngrok-free.app/stripe/cancel",
  });

  res.send({ url: session.url });
});

module.exports = router;
