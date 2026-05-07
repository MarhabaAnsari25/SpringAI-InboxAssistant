# 🚀 How to Run the Email Writer Application

## ✅ Prerequisites (Already Installed!)
- ✓ Java 17 (Installed: 17.0.12)
- ✓ Maven 3.9+ (Installed: 3.9.9)
- ✓ Node.js (Installed: v22.17.0)

## 🔑 Step 1: Get Google Gemini API Key

1. Visit: https://ai.google.dev/gemini-api/docs/api-key
2. Click "Get API Key" button
3. Sign in with your Google account
4. Create a new API key or use an existing one
5. Copy the API key

## ⚙️ Step 2: Configure Environment Variables

### Option A: Using Environment Variables (Recommended for Windows)
Set these environment variables in your terminal:

```bash
export GEMINI_URL="https://generativelanguage.googleapis.com/v1beta/models/gemini-pro:generateContent?key="
export GEMINI_KEY="YOUR_ACTUAL_API_KEY_HERE"
```

For Windows PowerShell:
```powershell
$env:GEMINI_URL="https://generativelanguage.googleapis.com/v1beta/models/gemini-pro:generateContent?key="
$env:GEMINI_KEY="YOUR_ACTUAL_API_KEY_HERE"
```

### Option B: Edit application.properties
Edit `src/main/resources/application.properties` and replace:
```properties
gemini.api.url=https://generativelanguage.googleapis.com/v1beta/models/gemini-pro:generateContent?key=
gemini.api.key=YOUR_ACTUAL_API_KEY_HERE
```

## 🏃 Step 3: Run the Backend (Spring Boot)

Open a terminal in the project root and run:

```bash
./mvnw clean install
./mvnw spring-boot:run
```

The backend will start on: **http://localhost:9191**

You should see:
```
Started EmailWriterApplication in X.XXX seconds
```

## 🎨 Step 4: Run the Frontend (React)

Open a NEW terminal and run:

```bash
cd email-writer-react
npm install
npm run dev
```

The frontend will start on: **http://localhost:5173** (or another port if 5173 is busy)

## 🧪 Step 5: Test the API

### Using curl:
```bash
curl -X POST "http://localhost:9191/api/email/generate" \
-H "Content-Type: application/json" \
-d "{\"emailContent\": \"Hi, I need help with my order\", \"tone\": \"professional\"}"
```

### Using the React App:
1. Open http://localhost:5173 in your browser
2. Enter email content
3. Select a tone (professional, casual, friendly, etc.)
4. Click "Generate Reply"

## 🔌 Browser Extensions

### Email Reply Extension:
1. Open Chrome/Edge
2. Go to `chrome://extensions/`
3. Enable "Developer mode"
4. Click "Load unpacked"
5. Select the `Email-Reply-Extension` folder
6. The extension is now installed!

### Hello World Extension (Test):
Same steps as above, but select the `Hello-world-extension-test` folder

## 📡 Available API Endpoints

| Endpoint | Method | Description |
|----------|--------|-------------|
| `/api/email/generate` | POST | Generate AI-powered email responses |

### Request Body Example:
```json
{
  "emailContent": "Thank you for your inquiry about our product.",
  "tone": "professional"
}
```

### Response Example:
```json
"Dear [Recipient],

Thank you for reaching out regarding our product. I appreciate your interest...

Best regards,
[Your Name]"
```

## 🛑 Troubleshooting

### Backend won't start:
- Check if port 9191 is already in use
- Verify GEMINI_API_KEY is set correctly
- Run `./mvnw clean install` first

### Frontend won't start:
- Delete `node_modules` and run `npm install` again
- Check if port 5173 is available
- Try `npm cache clean --force`

### API returns errors:
- Verify your Gemini API key is valid
- Check your internet connection
- Look at backend console logs for detailed errors

## 📝 Project Structure

```
├── src/main/java/              # Spring Boot backend
│   └── com/email/writer/
│       ├── EmailWriterApplication.java
│       └── app/
│           ├── EmailGeneratorController.java
│           ├── EmailGeneratorService.java
│           └── EmailRequest.java
├── email-writer-react/         # React frontend
│   ├── src/
│   │   ├── App.jsx
│   │   └── main.jsx
│   └── package.json
├── Email-Reply-Extension/      # Chrome extension
└── pom.xml                     # Maven configuration
```

## 🎯 What This Application Does

1. **AI Email Generation**: Uses Google Gemini AI to generate professional email replies
2. **Tone Customization**: Supports different tones (professional, casual, friendly, formal)
3. **REST API**: Provides a RESTful API for email generation
4. **Web Interface**: React-based UI for easy interaction
5. **Browser Extension**: Chrome extension for quick email replies

## 🔗 Useful Links

- [Spring Boot Documentation](https://spring.io/projects/spring-boot)
- [Google Gemini API](https://ai.google.dev/gemini-api/docs)
- [React Documentation](https://reactjs.org/)
- [Chrome Extensions Guide](https://developer.chrome.com/docs/extensions)

---

**Need Help?** Check the console logs for detailed error messages!
