
###  Email Reminder Bot – Flask Web App
This project is a Flask-based Email Reminder Bot that allows users to schedule email reminders through a simple web interface. Built with Python, Flask, and integrated email services, the bot helps users automate their daily reminders for tasks, meetings, and more.

####  Features
- User login and session management
- Reminder creation via web form
- Automated email delivery using SMTP
- Dockerized deployment on an Azure VM

####  Stack
- **Backend:** Python, Flask
- **Frontend:** HTML (Jinja2 Templates)
- **Email Service:** SMTP (Gmail)
*********************************************************************************************************************************************************************************************************************
*********************************************************************************************************************************************************************************************************************

### Email Reminder Bot (VM + Logic Apps + Outlook)
- Read dynamic reminder content from an Azure VM and send it via email using Logic Apps.
### STEP 1: Create the Azure Virtual Machine
- •	Go to Azure Portal
- •	Click Create a resource > Search Virtual Machine
- Fill in:
- •	Name: ReminderVM
- •	Image: Ubuntu 20.04 LTS
- •	Size: B1s (free under student subscription)
- •	Authentication: Password or key 
- Networking:
- •	Public IP: Enabled
- •	Inbound ports: Allow SSH (22) and Custom port 5000
- •	Click Review + Create, then Create
- ![image](https://github.com/user-attachments/assets/229232d0-33bd-4150-a27a-488ca2a8b473)
- VM is ready
- •	Login VM into our host machine with your public ip and key that you download while you setup the VM 
![image](https://github.com/user-attachments/assets/a7711c1c-f2d8-4740-83da-25c7691744e4)
![image](https://github.com/user-attachments/assets/87ecc69a-396c-4dba-91df-cae48e50ac6b)
### STEP 2: Set Up Flask App Inside VM
- Opened SSH terminal:
- Run the following setup:
- •	sudo apt update
- •	sudo apt install python3-pip -y
- •	pip3 install flask
- Create the Flask API:
- •	nano app.py 
- copy the code that I write in app.py . 
### NOTE : you can run it now for checking the connection and the next we running integrate with logical app designer in  azure. We will see in next steps  here for case it showing the login requests because I run it after integrate with azure logical app designer
![image](https://github.com/user-attachments/assets/dcca0793-97bf-49fd-b73b-149bdfe54aa7)


- Make sure port 7000 is open:
- Go to VM > Networking > Add inbound port rule
- Port: 7000, Protocol: TCP, Allow from Any


### STEP 3: Integrate the API  with logical app design 
 ![image](https://github.com/user-attachments/assets/07641285-e849-4d3e-a705-25372222e7fe)
![image](https://github.com/user-attachments/assets/236ee07d-4d69-4051-abee-b8fc1245281e)

 
- IN SEND an email we some bunch emails
![image](https://github.com/user-attachments/assets/96686640-5884-4b2f-a9a3-b7d06b21e9c5)
- After save we run the app1.py in our terminal 
![image](https://github.com/user-attachments/assets/10830af7-fa7e-4e80-b94a-fbb8c5c1c0b4)

### RESULT: 

![image](https://github.com/user-attachments/assets/f360b460-2935-4f8d-8fb7-30404f649dd1)
![image](https://github.com/user-attachments/assets/caf335ec-6ea5-4dcd-94eb-44b4232d55b3)

- By clicking the link in email we are redirect to our interface 
- For Client Login –
- Username – user
- Password – pass
![image](https://github.com/user-attachments/assets/70e582fb-0727-4436-96ce-6ee35a9fdb20)
![image](https://github.com/user-attachments/assets/a6a08a41-3845-4de0-b7ad-ad4c66a2739c)
![image](https://github.com/user-attachments/assets/6cf5f954-5b8c-449e-a510-fe33409d2a47)
- For Admin Login – 
- Username – admin
- Password – admin

- After logging in as an admin, you can add unique meeting links for each individual meeting.

![image](https://github.com/user-attachments/assets/e3f99337-a9cc-4398-b996-1324965a3376)

![image](https://github.com/user-attachments/assets/aa6ef488-42e9-46ba-b2fd-e83c54df3736)
- In user dashboard we can see link that we provide in admin panel 

- AND HERE WE SEE THE USER ACTIVITY
![image](https://github.com/user-attachments/assets/0e3b0944-c6a9-45b4-b1d2-bc454a514b15)
- The requests here showing that (GET,POST)
- For GET   --> I am accessible the page 
- For POST  --> entered some credentials in my page  i.e.  password, username so that  reflects here i post something in page
