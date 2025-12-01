import nodemailer from 'nodemailer';

export const sendEmail = async (to, subject, html) => {
  const transporter = nodemailer.createTransport({
    host: process.env.SMTP_HOST,
    port: Number(process.env.SMTP_PORT),
    secure: false,
    auth: {
      user: process.env.SMTP_USER,
      pass: process.env.SMTP_PASSWORD,
    },
  });

  const mailOptions = {
    from: process.env.SMTP_FROM,
    to,
    subject,
    html,
  };

  console.log('📧 Attempting to send email:', {
    from: process.env.SMTP_FROM,
    to,
    host: process.env.SMTP_HOST,
    port: process.env.SMTP_PORT,
  });

  return transporter.sendMail(mailOptions);
};

