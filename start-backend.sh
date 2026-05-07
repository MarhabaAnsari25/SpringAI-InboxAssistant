#!/bin/bash
# Start Backend Script

echo "========================================="
echo "Starting Email Writer Backend Server"
echo "========================================="
echo ""

# Check if environment variables are set
if [ -z "$GEMINI_KEY" ]; then
    echo "⚠️  WARNING: GEMINI_KEY environment variable is not set!"
    echo ""
    echo "Please set it using:"
    echo "  export GEMINI_KEY='your-api-key-here'"
    echo ""
    echo "Or for Windows PowerShell:"
    echo "  \$env:GEMINI_KEY='your-api-key-here'"
    echo ""
    read -p "Press Enter to continue anyway or Ctrl+C to exit..."
fi

echo "Starting Spring Boot application..."
echo "Server will be available at: http://localhost:9191"
echo ""

./mvnw spring-boot:run
