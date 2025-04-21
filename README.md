### 📧 Email Reminder Bot – Flask Web App
This project is a Flask-based Email Reminder Bot that allows users to schedule email reminders through a simple web interface. Built with Python, Flask, and integrated email services, the bot helps users automate their daily reminders for tasks, meetings, and more.

#### 🚀 Features
- User login and session management
- Reminder creation via web form
- Automated email delivery using SMTP
- Dockerized deployment on an Azure VM

#### 🛠️ Stack
- **Backend:** Python, Flask
- **Frontend:** HTML (Jinja2 Templates)
- **Email Service:** SMTP (Gmail)

#### 🐛 Issue Encountered
While running the Flask app, the server encountered a `jinja2.exceptions.TemplateNotFound: login.html` error. This was due to the missing `login.html` file inside the `templates/` directory.

**Fix:** Created a `templates` folder in the root directory and added the missing `login.html` template to resolve the rendering issue.

#### 📁 Project Structure
```
/EmailReminderBot
├── app.py (in this file only we write the html,css everything don't worry) 

#### 📌 Usage
```bash
# Run the Flask app
python3 app.py
*************************************************************************************************************

