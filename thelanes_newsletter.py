import requests
import smtplib
from email.mime.multipart import MIMEMultipart
from email.mime.text import MIMEText
from email.mime.base import MIMEBase
from email import encoders
from bs4 import BeautifulSoup

# Function to download the correct PDF
def download_pdf():
    # URL of the webpage containing the PDF link
    webpage_url = "https://www.thelanes.notts.sch.uk/weekly-newsletters-16/"
    response = requests.get(webpage_url)
    soup = BeautifulSoup(response.text, 'html.parser')

    # Find the correct PDF link (looking for PDFs with "newsletter" in the filename)
    pdf_link_tag = soup.find('a', href=lambda href: href and 'newsletter' in href and '.pdf' in href)
    if pdf_link_tag:
        pdf_link = pdf_link_tag['href']
        if not pdf_link.startswith('http'):
            pdf_link = "https://www.thelanes.notts.sch.uk" + pdf_link
        
        # Download the PDF
        pdf_response = requests.get(pdf_link)
        pdf_filename = pdf_link.split('/')[-1]  # Extract filename from URL
        
        with open(pdf_filename, "wb") as f:
            f.write(pdf_response.content)
        print(f"PDF downloaded: {pdf_filename}")

        send_email(pdf_filename)
    else:
        print("No PDF link found on the page.")

# Function to send email with the PDF
def send_email(file_path):
    # Email configuration
    sender_email = "mikeasghar@gmail.com"
    receiver_email = ["masghar92@hotmail.co.uk", "dianatsy92@gmail.com"]  # Update recipient list
    subject = "Weekly Newsletter"
    body = "Please find attached the latest newsletter."

    # Create the email message
    msg = MIMEMultipart()
    msg['From'] = sender_email
    msg['To'] = ', '.join(receiver_email)
    msg['Subject'] = subject
    msg.attach(MIMEText(body, 'plain'))

    # Attach the PDF file
    with open(file_path, "rb") as attachment:
        part = MIMEBase('application', 'octet-stream')
        part.set_payload(attachment.read())
        encoders.encode_base64(part)
        part.add_header('Content-Disposition', f'attachment; filename= {file_path}')
        msg.attach(part)

    # Send email via Hotmail's SMTP server
    with smtplib.SMTP('smtp.gmail.com', 587) as server:
        server.starttls()
        server.login(sender_email, 'ilqa srju tmsq mnpn')  # Use your Hotmail/Outlook password or app-specific password
        server.sendmail(sender_email, receiver_email, msg.as_string())

    print("Email sent successfully")

# Run the download and email function immediately for debugging
download_pdf()













