#!/bin/bash
# Setup script for Email Writer Application

echo "==================================="
echo "Email Writer Application Setup"
echo "==================================="
echo ""

# Check if .env file exists
if [ -f .env ]; then
    echo "✓ .env file already exists"
else
    echo "Creating .env file..."
    cat > .env << 'EOF'
# Google Gemini API Configuration
GEMINI_URL=https://generativelanguage.googleapis.com/v1beta/models/gemini-pro:generateContent?key=
GEMINI_KEY=YOUR_API_KEY_HERE

# Server Configuration
SERVER_PORT=9191
EOF
    echo "✓ .env file created"
fi

echo ""
echo "==================================="
echo "IMPORTANT: Get your Gemini API Key"
echo "==================================="
echo "1. Visit: https://ai.google.dev/gemini-api/docs/api-key"
echo "2. Click 'Get API Key'"
echo "3. Copy your API key"
echo "4. Edit the .env file and replace YOUR_API_KEY_HERE with your actual key"
echo ""
echo "After setting up the API key, run:"
echo "  - Backend: ./mvnw spring-boot:run"
echo "  - Frontend: cd email-writer-react && npm install && npm run dev"
echo "==================================="
