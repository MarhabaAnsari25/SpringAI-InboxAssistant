# 🚀 HOW TO RUN THE ENTIRE PROJECT

## 📋 Quick Start (Easiest Way)

### **Option 1: One-Click Start (Recommended)**

Just double-click this file:
```
start-entire-project.bat
```

This will:
- ✅ Check all prerequisites
- ✅ Install frontend dependencies (if needed)
- ✅ Start the backend server
- ✅ Start the frontend application
- ✅ Open your browser automatically

**That's it!** Everything will be running in 30-40 seconds.

---

## 📁 Available Batch Files

### **1. start-entire-project.bat** ⭐ RECOMMENDED
**What it does:**
- Checks if Node.js, Java, and Maven are installed
- Installs frontend dependencies automatically (first time only)
- Starts backend server in a new window (Blue)
- Starts frontend application in a new window (Yellow)
- Opens browser to http://localhost:5173
- Shows colored status messages

**When to use:** First time running or anytime you want everything started automatically

**How to use:**
```
Double-click: start-entire-project.bat
```

---

### **2. start-project-simple.bat**
**What it does:**
- Simplified version with less output
- Starts backend and frontend
- Opens browser

**When to use:** If you prefer a simpler, quieter startup

**How to use:**
```
Double-click: start-project-simple.bat
```

---

### **3. setup-frontend.bat**
**What it does:**
- Installs frontend dependencies only
- Runs `npm install` in the email-writer-react folder

**When to use:** 
- If you want to install frontend dependencies separately
- If frontend dependencies get corrupted

**How to use:**
```
Double-click: setup-frontend.bat
```

---

### **4. start-backend.bat**
**What it does:**
- Starts only the backend server
- Runs on port 9191

**When to use:** 
- When you only need the API
- When testing backend separately

**How to use:**
```
Double-click: start-backend.bat
```

---

### **5. stop-project.bat**
**What it does:**
- Stops all running backend and frontend processes
- Kills Java and Node processes
- Frees up ports 9191 and 5173

**When to use:** 
- When you want to stop everything
- When ports are stuck/busy
- Before restarting the application

**How to use:**
```
Double-click: stop-project.bat
```

---

## 🎯 Step-by-Step Guide

### **First Time Setup:**

1. **Run the main launcher:**
   ```
   Double-click: start-entire-project.bat
   ```

2. **Wait for installation:**
   - First time will take 2-3 minutes (installing npm packages)
   - Subsequent runs will be much faster (30 seconds)

3. **Two windows will open:**
   - **Blue Window** = Backend Server (Port 9191)
   - **Yellow Window** = Frontend Application (Port 5173)

4. **Browser opens automatically:**
   - Frontend UI: http://localhost:5173
   - Backend API: http://localhost:9191

5. **Start using the application!**

---

## 🖥️ What You'll See

### **Main Launcher Window:**
```
============================================
  AI Email Management System
  Starting Full Application...
============================================

[1/3] Setting up environment...
     API Key: Configured
     Port: 9191 (Backend)
     Port: 5173 (Frontend)

[2/3] Checking prerequisites...
     Node.js: Found
     Java: Found
     Maven: Found

[3/3] Checking frontend dependencies...
     Frontend dependencies: Found

[4/4] Starting services...

Starting Backend Server...
Waiting for backend to initialize (20 seconds)...
Starting Frontend Application...
Waiting for frontend to initialize (10 seconds)...

============================================
  APPLICATION STARTED SUCCESSFULLY!
============================================

Backend API:  http://localhost:9191
Frontend UI:  http://localhost:5173

Two new windows have been opened:
  1. Backend Server (Blue)
  2. Frontend Application (Yellow)

Opening browser in 5 seconds...

============================================
  READY TO USE!
============================================
```

### **Backend Window (Blue):**
```
============================================
  BACKEND SERVER - Port 9191
============================================

  .   ____          _            __ _ _
 /\\ / ___'_ __ _ _(_)_ __  __ _ \ \ \ \
( ( )\___ | '_ | '_| | '_ \/ _` | \ \ \ \
 \\/  ___)| |_)| | | | | || (_| |  ) ) ) )
  '  |____| .__|_| |_|_| |_\__, | / / / /
 =========|_|==============|___/=/_/_/_/
 :: Spring Boot ::                (v3.4.2)

Started EmailWriterApplication in 2.5 seconds
Tomcat started on port 9191
```

### **Frontend Window (Yellow):**
```
============================================
  FRONTEND APPLICATION - Port 5173
============================================

  VITE v6.0.5  ready in 1234 ms

  ➜  Local:   http://localhost:5173/
  ➜  Network: use --host to expose
  ➜  press h + enter to show help
```

---

## 🛑 How to Stop the Application

### **Method 1: Use the Stop Script (Recommended)**
```
Double-click: stop-project.bat
```

### **Method 2: Close Windows Manually**
- Close the Blue window (Backend)
- Close the Yellow window (Frontend)

### **Method 3: Press Ctrl+C**
- In each window, press `Ctrl+C`
- Type `Y` when asked to terminate

---

## 🔄 How to Restart

1. **Stop the application:**
   ```
   Double-click: stop-project.bat
   ```

2. **Start again:**
   ```
   Double-click: start-entire-project.bat
   ```

---

## 🧪 Testing the Application

Once running, you can test the API:

### **Using PowerShell:**
```powershell
$body = @{
    emailContent = "Hi, I need help with my order"
    tone = "professional"
} | ConvertTo-Json

Invoke-RestMethod -Uri "http://localhost:9191/api/email/generate" -Method Post -Body $body -ContentType "application/json"
```

### **Using the Frontend:**
1. Open http://localhost:5173 in your browser
2. Enter your email content
3. Select a tone
4. Click "Generate Reply"

---

## ⚠️ Troubleshooting

### **"Port already in use" error:**
```
Solution: Run stop-project.bat first
```

### **"Node.js not found" error:**
```
Solution: Install Node.js from https://nodejs.org/
```

### **Frontend won't start:**
```
Solution: Run setup-frontend.bat first
```

### **Backend won't start:**
```
Solution: Check if Java 17 is installed
Run: java -version
```

### **API returns errors:**
```
Solution: Check if backend window shows "Started EmailWriterApplication"
Wait 30 seconds after starting
```

---

## 📊 Ports Used

- **Backend API**: Port 9191
- **Frontend UI**: Port 5173

Make sure these ports are not used by other applications.

---

## 🎓 What Each Component Does

### **Backend (Spring Boot)**
- REST API for email generation
- Integrates with Google Gemini AI
- Handles business logic
- Runs on port 9191

### **Frontend (React + Vite)**
- User interface
- Email composition form
- Tone selection
- Displays generated emails
- Runs on port 5173

---

## 📝 Configuration

### **API Key:**
The Gemini API key is configured in the batch files:
```
set GEMINI_KEY=PasteYourGeminiKeyCodeHere
```

If you need to change it, edit:
- `start-entire-project.bat`
- `start-project-simple.bat`
- `start-backend.bat`

---

## 🔗 URLs

- **Frontend**: http://localhost:5173
- **Backend API**: http://localhost:9191
- **API Endpoint**: http://localhost:9191/api/email/generate

---

## 💡 Tips

1. **Keep windows open** - Don't close the Blue and Yellow windows while using the app
2. **First run is slower** - Installing dependencies takes time
3. **Use stop-project.bat** - Cleanest way to stop everything
4. **Check the logs** - Blue and Yellow windows show useful information
5. **Wait for startup** - Backend takes ~20 seconds, frontend takes ~10 seconds

---

## 🎉 You're All Set!

Just run `start-entire-project.bat` and you're good to go!

**Need help?** Check the other documentation files:
- `SUCCESS-GUIDE.md` - Usage examples
- `RUN-INSTRUCTIONS.md` - Detailed instructions
- `QUICK-START.md` - Quick reference

---

**Happy Coding! 🚀**
