import * as functions from "firebase-functions";
import * as admin from "firebase-admin";
import * as nodemailer from "nodemailer";

admin.initializeApp();
const db = admin.firestore();

// ⚙️ Cấu hình Gmail SMTP (dùng App Password Gmail)
const transporter = nodemailer.createTransport({
  service: "gmail",
  auth: {
    user: "YOUR_GMAIL@gmail.com", // 👉 thay bằng Gmail của bạn
    pass: "YOUR_APP_PASSWORD", // 👉 thay bằng App Password (16 ký tự)
  },
});

// 📨 Gửi mã OTP
export const sendOTP = functions.https.onCall(async (data, context) => {
  const email = data.email;
  if (!email) throw new functions.https.HttpsError("invalid-argument", "Email required");

  const otp = Math.floor(100000 + Math.random() * 900000).toString();

  const mailOptions = {
    from: "SmartTasks <YOUR_GMAIL@gmail.com>",
    to: email,
    subject: "SmartTasks Verification Code",
    text: `Your verification code is: ${otp}`,
  };

  await transporter.sendMail(mailOptions);

  await db.collection("otp_codes").doc(email).set({
    otp,
    createdAt: admin.firestore.FieldValue.serverTimestamp(),
  });

  return { success: true };
});

// ✅ Xác minh mã OTP
export const verifyOTP = functions.https.onCall(async (data, context) => {
  const { email, otp } = data;
  const doc = await db.collection("otp_codes").doc(email).get();

  if (!doc.exists) throw new functions.https.HttpsError("not-found", "OTP not found");

  const savedOtp = doc.data()?.otp;
  if (otp !== savedOtp) {
    throw new functions.https.HttpsError("permission-denied", "Invalid OTP");
  }

  await db.collection("otp_codes").doc(email).delete();
  return { success: true };
});
