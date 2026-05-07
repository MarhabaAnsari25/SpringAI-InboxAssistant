# 🚀 QUICK START GUIDE

## ✅ Your System is Ready!

I've checked your system and everything is installed:
- ✓ **Java 17.0.12** - Ready!
- ✓ **Maven 3.9.9** - Ready!
- ✓ **Node.js v22.17.0** - Ready!
- ✓ **Project Built Successfully** - Ready to run!

---

## 🎯 3 SIMPLE STEPS TO RUN

### **STEP 1: Get Your Google Gemini API Key** 🔑

1. Go to: https://ai.google.dev/gemini-api/docs/api-key
2. Click **"Get API Key"**
3. Sign in with your Google account
4. Copy your API key

### **STEP 2: Set Environment Variables** ⚙️

**For Windows PowerShell (Recommended):**
```powershell
$env:GEMINI_URL="https://generativelanguage.googleapis.com/v1beta/models/gemini-pro:generateContent?key="
$env:GEMINI_KEY="YOUR_ACTUAL_API_KEY_HERE"
```

**For Windows CMD:**
```cmd
set GEMINI_URL=https://generativelanguage.googleapis.com/v1beta/models/gemini-pro:generateContent?key=
set GEMINI_KEY=YOUR_ACTUAL_API_KEY_HERE
```

**For Git Bash:**
```bash
export GEMINI_URL="https://generativelanguage.googleapis.com/v1beta/models/gemini-pro:generateContent?key="
export GEMINI_KEY="YOUR_ACTUAL_API_KEY_HERE"
```

### **STEP 3: Run the Application** 🏃

#### **Option A: Using the Start Scripts (Easiest)**

**For Windows:**
```cmd
start-backend.bat
```

**For Git Bash:**
```bash
./start-backend.sh
```

#### **Option B: Manual Start**

**Backend (Terminal 1):**
```bash
./mvnw spring-boot:run
```

**Frontend (Terminal 2):**
```bash
cd email-writer-react
npm install
npm run dev
```

---

## 🌐 Access Your Application

Once running, you can access:

- **Backend API**: http://localhost:9191
- **Frontend UI**: http://localhost:5173 (after running npm run dev)
- **API Endpoint**: http://localhost:9191/api/email/generate

---

## 🧪 TEST THE API

### Using curl:
```bash
curl -X POST "http://localhost:9191/api/email/generate" \
-H "Content-Type: application/json" \
-d "{\"emailContent\": \"Hi, I need help with my order\", \"tone\": \"professional\"}"
```

### Using PowerShell:
```powershell
$body = @{
    emailContent = "Hi, I need help with my order"
    tone = "professional"
} | ConvertTo-Json

Invoke-RestMethod -Uri "http://localhost:9191/api/email/generate" -Method Post -Body $body -ContentType "application/json"
```

### Expected Response:
```
Dear [Recipient],

Thank you for reaching out regarding your order. I'd be happy to assist you...

Best regards,
[Your Name]
```

---

## 📱 BROWSER EXTENSIONS

### Install Email Reply Extension:

1. Open Chrome or Edge
2. Navigate to `chrome://extensions/` or `edge://extensions/`
3. Enable **"Developer mode"** (toggle in top right)
4. Click **"Load unpacked"**
5. Select the `Email-Reply-Extension` folder
6. Extension installed! ✅

---

## 🎨 WHAT THIS APPLICATION DOES

### **Backend (Spring Boot + Gemini AI)**
- REST API for email generation
- Integrates with Google Gemini AI
- Supports multiple tones (professional, casual, friendly, formal)
- CORS enabled for frontend integration

### **Frontend (React + Vite)**
- Modern React UI
- Email composition interface
- Tone selection
- Real-time API integration

### **Browser Extensions**
- Quick email reply generation
- Direct integration with email clients
- One-click AI assistance

---

## 📊 PROJECT STRUCTURE

```
SpringAI-InboxAssistant/
├── src/main/java/              # Backend Java code
│   └── com/email/writer/
│       ├── EmailWriterApplication.java
│       └── app/
│           ├── EmailGeneratorController.java
│           ├── EmailGeneratorService.java
│           └── EmailRequest.java
├── email-writer-react/         # Frontend React app
│   ├── src/
│   │   ├── App.jsx
│   │   └── main.jsx
│   └── package.json
├── Email-Reply-Extension/      # Chrome extension
├── pom.xml                     # Maven config
├── start-backend.bat           # Windows start script
└── start-backend.sh            # Bash start script
```

---

## 🛑 TROUBLESHOOTING

### Backend won't start?
- ✅ Check if port 9191 is free
- ✅ Verify GEMINI_API_KEY is set correctly
- ✅ Check console for error messages

### API returns errors?
- ✅ Verify your Gemini API key is valid
- ✅ Check your internet connection
- ✅ Look at backend logs for details

### Frontend won't connect?
- ✅ Make sure backend is running first
- ✅ Check if backend is on port 9191
- ✅ Verify CORS is enabled (already configured)

---

## 📝 API DOCUMENTATION

### Endpoint: `/api/email/generate`
- **Method**: POST
- **Content-Type**: application/json

### Request Body:
```json
{
  "emailContent": "Original email or context",
  "tone": "professional"
}
```

### Supported Tones:
- `professional`
- `casual`
- `friendly`
- `formal`
- `enthusiastic`

### Response:
```
Generated email reply text
```

---

## 🎓 NEXT STEPS

1. ✅ **Get your Gemini API key**
2. ✅ **Set environment variables**
3. ✅ **Run the backend**: `./mvnw spring-boot:run`
4. ✅ **Test the API** with curl or Postman
5. ✅ **Run the frontend**: `cd email-writer-react && npm run dev`
6. ✅ **Install browser extension** (optional)

---

## 🔗 USEFUL LINKS

- [Google Gemini API Docs](https://ai.google.dev/gemini-api/docs)
- [Spring Boot Documentation](https://spring.io/projects/spring-boot)
- [React Documentation](https://reactjs.org/)
- [Chrome Extensions Guide](https://developer.chrome.com/docs/extensions)

---

## 💡 TIPS

- Keep your API key secret and never commit it to Git
- The backend must be running before the frontend can work
- Check console logs for detailed error messages
- Use the browser extension for quick email replies

---

**Need Help?** Check the logs or refer to `RUN-INSTRUCTIONS.md` for detailed information!

**Happy Coding! 🎉**
