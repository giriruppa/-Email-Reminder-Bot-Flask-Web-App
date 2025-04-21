from flask import Flask, request, redirect, url_for, render_template_string, session
from datetime import datetime, time
import pytz

app = Flask(__name__)
app.secret_key = 'supersecretkey'  # Required for session

# Dummy database for meeting links
meeting_links = [""] * 7

# Fixed meeting times and titles
fixed_times = [
    time(9, 30),
    time(10, 30),
    time(11, 30),
    time(12, 30),
    time(14, 0),
    time(15, 30),
    time(16, 30),
]
meeting_data = [
    {"title": "Team Standup", "desc": "Daily team sync-up meeting"},
    {"title": "Client Call", "desc": "Project discussion with the client"},
    {"title": "Design Review", "desc": "Review the new dashboard design"},
    {"title": "Lunch & Learn", "desc": "Skill-sharing session over lunch"},
    {"title": "Sprint Planning", "desc": "Plan tasks for next sprint"},
    {"title": "Security Briefing", "desc": "Monthly cybersecurity updates"},
    {"title": "Wrap-up Meeting", "desc": "End-of-day check-in"},
]

@app.route('/')
def home():
    return redirect('/login')

@app.route('/login', methods=['GET', 'POST'])
def login():
    html = """
    <form method="POST">
        <h2>🔐 Login</h2>
        Username: <input name="username"><br><br>
        Password: <input name="password" type="password"><br><br>
        <button type="submit">Login</button>
    </form>
    {% if error %}
        <p style='color:red'>{{ error }}</p>
    {% endif %}
    """
    error = None
    if request.method == 'POST':
        username = request.form['username']
        password = request.form['password']
        if username == 'user' and password == 'pass':
            session['role'] = 'user'
            return redirect('/reminder')
        elif username == 'admin' and password == 'admin':
            session['role'] = 'admin'
            return redirect('/admin')
        else:
            error = 'Invalid Credentials'
    return render_template_string(html, error=error)

@app.route('/admin', methods=['GET', 'POST'])
def admin_panel():
    if session.get('role') != 'admin':
        return redirect('/login')

    if request.method == 'POST':
        for i in range(7):
            link = request.form.get(f'link{i}')
            if link:
                meeting_links[i] = link.strip()

    form_html = """
    <h2>👨‍💼 Admin Panel - Add Meeting Links</h2>
    <form method="POST">
    """
    for i, meeting in enumerate(meeting_data):
        form_html += f"""
        <label>{meeting['title']} Link:</label>
        <input name="link{i}" value="{meeting_links[i]}" style="width: 60%"><br><br>
        """
    form_html += """
        <button type="submit">Save Links</button>
    </form><br><a href='/reminder'>Go to Schedule View</a>
    """
    return render_template_string(form_html)

@app.route('/reminder')
def reminder():
    if session.get('role') not in ['user', 'admin']:
        return redirect('/login')

    timezone = pytz.timezone('Asia/Kolkata')
    today = datetime.now(timezone).date()

    meetings = []
    for i, meeting in enumerate(meeting_data):
        dt = datetime.combine(today, fixed_times[i])
        dt = timezone.localize(dt)
        meetings.append({
            "timestamp": int(dt.timestamp()) * 1000,
            "title": meeting["title"],
            "desc": meeting["desc"],
            "time_str": dt.strftime("%I:%M %p"),
            "date_str": dt.strftime("%B %d, %Y"),
            "link": meeting_links[i] if meeting_links[i] else ""
        })

    # Build HTML page
    html = f"""
    <html>
    <head>
        <title>Meeting Schedule</title>
        <style>
            body {{ font-family: 'Segoe UI'; background: #f4f6fa; padding: 20px; }}
            .container {{ max-width: 800px; margin: auto; background: white; padding: 20px; border-radius: 12px; }}
            .meeting {{ background: #e7f1ff; padding: 15px; margin: 10px 0; border-left: 5px solid #0078D7; border-radius: 8px; }}
            .title {{ font-size: 20px; color: #0078D7; }}
            .desc, .time {{ color: #555; }}
            .link {{ margin-top: 10px; }}
            .countdown {{ color: #e63946; background: #ffe5e5; padding: 5px 10px; border-radius: 6px; animation: pulse 1.5s infinite; }}
            @keyframes pulse {{
                0% {{ transform: scale(1); }}
                50% {{ transform: scale(1.05); }}
                100% {{ transform: scale(1); }}
            }}
        </style>
    </head>
    <body>
        <div class="container">
            <h2>📅 Meeting Schedule with Countdown</h2>
    """

    for idx, m in enumerate(meetings):
        html += f"""
        <div class="meeting">
            <div class="title">📌 {m['title']}</div>
            <div class="time">🕒 {m['time_str']} on {m['date_str']}</div>
            <div class="desc">{m['desc']}</div>
            {"<div class='link'>🔗 <a href='" + m['link'] + "' target='_blank'>Join Meeting</a></div>" if m['link'] else ""}
            <div class="countdown" id="countdown-{idx}">Loading...</div>
        </div>
        """

    html += "<script>\nconst timestamps = ["
    html += ",".join([str(m['timestamp']) for m in meetings])
    html += "];\n"

    html += """
    timestamps.forEach((ts, index) => {
        const el = document.getElementById(`countdown-${index}`);
        function updateCountdown() {
            const now = new Date().getTime();
            const distance = ts - now;
            if (distance <= 0) {
                el.innerHTML = "🟢 Meeting started!";
                el.style.background = "#e0f7f1";
                el.style.color = "#2a9d8f";
                return;
            }
            const hrs = Math.floor((distance % (1000*60*60*24)) / (1000*60*60));
            const mins = Math.floor((distance % (1000*60*60)) / (1000*60));
            const secs = Math.floor((distance % (1000*60)) / 1000);
            el.innerHTML = `⏳ Starts in ${hrs}h ${mins}m ${secs}s`;
        }
        updateCountdown();
        setInterval(updateCountdown, 1000);
    });
    </script>
    </div></body></html>
    """
    return html

if __name__ == '__main__':
    app.run(host='0.0.0.0', port=7000)
