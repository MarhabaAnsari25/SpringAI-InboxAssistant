// ============================================================
// script.js — popup UI logic
// Sends POST to backend and displays the generated reply
// ============================================================

const API_URL = "http://localhost:9191/api/email/generate";

const generateBtn  = document.getElementById("generateBtn");
const emailContent = document.getElementById("emailContent");
const toneSelect   = document.getElementById("tone");
const statusEl     = document.getElementById("status");
const resultBox    = document.getElementById("resultBox");
const replyOutput  = document.getElementById("replyOutput");
const copyBtn      = document.getElementById("copyBtn");

function setStatus(message, type = "") {
    statusEl.textContent = message;
    statusEl.className = type;
}

function setLoading(loading) {
    if (loading) {
        generateBtn.disabled = true;
        generateBtn.innerHTML = '<span class="spinner"></span> Generating…';
    } else {
        generateBtn.disabled = false;
        generateBtn.innerHTML = "✨ Generate Reply";
    }
}

generateBtn.addEventListener("click", async () => {
    const content = emailContent.value.trim();
    if (!content) {
        setStatus("Please paste an email to reply to.", "error");
        return;
    }

    setLoading(true);
    setStatus("");
    resultBox.style.display = "none";

    try {
        // Matches Java EmailRequest { emailContent, tone }
        const response = await fetch(API_URL, {
            method: "POST",
            headers: { "Content-Type": "application/json" },
            body: JSON.stringify({
                emailContent: content,
                tone: toneSelect.value
            })
        });

        if (!response.ok) {
            throw new Error(`Server returned ${response.status}: ${response.statusText}`);
        }

        const reply = await response.text();
        replyOutput.value = reply;
        resultBox.style.display = "block";
        setStatus("Reply generated successfully!", "success");

    } catch (err) {
        console.error("[AI Reply Popup]", err);
        if (err.message.includes("Failed to fetch")) {
            setStatus("Cannot reach backend. Is the Spring Boot server running on port 9191?", "error");
        } else {
            setStatus(err.message, "error");
        }
    } finally {
        setLoading(false);
    }
});

copyBtn.addEventListener("click", () => {
    navigator.clipboard.writeText(replyOutput.value).then(() => {
        copyBtn.textContent = "✔ Copied!";
        setTimeout(() => { copyBtn.textContent = "📋 Copy to Clipboard"; }, 2000);
    });
});
