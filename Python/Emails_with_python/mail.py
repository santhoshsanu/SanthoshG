import os
from email.message import EmailMessage
import ssl
import smtplib

email_sender = 'santhoshgullapudi323@gmail.com'
email_password = 'bmii whal cbkn txaf'
email_receiver = "amazonwebservices834@gmail.com"

subject = 'Hi this is the Message from santhosh to thor'
body = """
Please update to avengers for thor movies
"""


em = EmailMessage()
em['From'] = email_sender
em['To'] = email_receiver
em['Subject'] = subject
em.set_content(body)

context = ssl.create_default_context()

try:
    with smtplib.SMTP_SSL('smtp.gmail.com', 465, context=context) as smtp:
        smtp.login(email_sender, email_password)
        smtp.sendmail(email_sender, email_receiver, em.as_string())
        print("Email sent successfully!")  # Success message
except Exception as e:
    print(f"Failed to send email: {e}")  # Error message