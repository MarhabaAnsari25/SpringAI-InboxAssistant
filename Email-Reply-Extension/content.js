// ============================================================
// content.js — injected into Gmail pages
// Reads email content from DOM, sends to backend, inserts reply
// ============================================================

const API_URL = "http://localhost:9191/api/email/generate";

// ── DOM helpers ──────────────────────────────────────────────

function getEmailContent() {
    const selectors = [
        ".h7",
        ".a3s.aiL",
        ".gmail_quote",
        "[role='presentation']"
    ];
    for (const selector of selectors) {
        const el = document.querySelector(selector);
        if (el && el.innerText.trim()) {
            return el.innerText.trim();
        }
    }
    return "";
}

function findComposeToolbar() {
    const selectors = [".btC", ".aDh", "[role='toolbar']", ".gU.Up"];
    for (const selector of selectors) {
        const el = document.querySelector(selector);
        if (el) return el;
    }
    return null;
}

function findComposeBox() {
    return document.querySelector("[role='textbox'][g_editable='true']");
}

// ── UI components ────────────────────────────────────────────

function createAIButton() {
    const btn = document.createElement("button");
    btn.className = "ai-reply-button";
    btn.textContent = "✨ AI Reply";
    Object.assign(btn.style, {
        marginRight: "8px",
        padding: "8px 18px",
        borderRadius: "6px",
        backgroundColor: "#1a73e8",
        color: "white",
        fontWeight: "500",
        fontSize: "14px",
        cursor: "pointer",
        border: "none",
        transition: "background-color 0.2s, box-shadow 0.2s",
        boxShadow: "0 1px 2px rgba(0,0,0,0.15)",
        height: "36px",
        display: "inline-flex",
        alignItems: "center",
        gap: "6px"
    });
    btn.addEventListener("mouseover", () => {
        if (!btn.disabled) btn.style.backgroundColor = "#1557b0";
    });
    btn.addEventListener("mouseout", () => {
        if (!btn.disabled) btn.style.backgroundColor = "#1a73e8";
    });
    return btn;
}

function createToneSelector() {
    const wrapper = document.createElement("div");
    wrapper.style.position = "relative";
    wrapper.style.display = "inline-block";

    const select = document.createElement("select");
    select.className = "ai-tone-selector";
    Object.assign(select.style, {
        padding: "8px 28px 8px 10px",
        borderRadius: "6px",
        border: "1px solid #dadce0",
        fontSize: "14px",
        color: "#3c4043",
        backgroundColor: "white",
        cursor: "pointer",
        appearance: "none",
        height: "36px"
    });

    [
        ["professional", "Professional"],
        ["friendly",     "Friendly"],
        ["formal",       "Formal"],
        ["casual",       "Casual"],
        ["enthusiastic", "Enthusiastic"],
        ["empathetic",   "Empathetic"],
        ["direct",       "Direct"],
        ["diplomatic",   "Diplomatic"]
    ].forEach(([value, label]) => {
        const opt = document.createElement("option");
        opt.value = value;
        opt.textContent = label;
        select.appendChild(opt);
    });

    const arrow = document.createElement("span");
    arrow.textContent = "▼";
    Object.assign(arrow.style, {
        position: "absolute",
        right: "8px",
        top: "50%",
        transform: "translateY(-50%)",
        pointerEvents: "none",
        fontSize: "10px",
        color: "#5f6368"
    });

    wrapper.appendChild(select);
    wrapper.appendChild(arrow);
    return wrapper;
}

function createLoadingSpinner() {
    const spinner = document.createElement("span");
    spinner.className = "ai-spinner";
    Object.assign(spinner.style, {
        display: "inline-block",
        width: "14px",
        height: "14px",
        border: "2px solid rgba(255,255,255,0.4)",
        borderTopColor: "white",
        borderRadius: "50%",
        animation: "ai-spin 0.7s linear infinite"
    });

    if (!document.getElementById("ai-spinner-style")) {
        const style = document.createElement("style");
        style.id = "ai-spinner-style";
        style.textContent = "@keyframes ai-spin { to { transform: rotate(360deg); } }";
        document.head.appendChild(style);
    }
    return spinner;
}

function showNotification(message, isError = false) {
    const note = document.createElement("div");
    Object.assign(note.style, {
        position: "fixed",
        bottom: "24px",
        right: "24px",
        padding: "12px 20px",
        borderRadius: "8px",
        backgroundColor: isError ? "#d93025" : "#1e8e3e",
        color: "white",
        fontSize: "14px",
        zIndex: "99999",
        boxShadow: "0 2px 8px rgba(0,0,0,0.25)",
        transition: "opacity 0.3s ease"
    });
    note.textContent = message;
    document.body.appendChild(note);
    setTimeout(() => {
        note.style.opacity = "0";
        setTimeout(() => note.remove(), 300);
    }, 3000);
}

function createActionButtons(generatedText, composeBox, aiButton) {
    const container = document.createElement("div");
    Object.assign(container.style, {
        display: "flex",
        gap: "8px",
        marginTop: "8px"
    });

    const makeBtn = (label, bg, hoverBg) => {
        const btn = document.createElement("button");
        btn.textContent = label;
        Object.assign(btn.style, {
            padding: "7px 18px",
            borderRadius: "4px",
            border: "none",
            cursor: "pointer",
            fontWeight: "500",
            fontSize: "13px",
            backgroundColor: bg,
            color: "white",
            transition: "background-color 0.2s"
        });
        btn.addEventListener("mouseover", () => { btn.style.backgroundColor = hoverBg; });
        btn.addEventListener("mouseout",  () => { btn.style.backgroundColor = bg; });
        return btn;
    };

    const acceptBtn = makeBtn("✔ Accept", "#1e8e3e", "#137333");
    const rejectBtn = makeBtn("✖ Reject", "#d93025", "#b31412");

    acceptBtn.addEventListener("click", () => {
        composeBox.innerHTML = generatedText;
        container.remove();
        aiButton.disabled = false;
        aiButton.innerHTML = "✨ AI Reply";
        showNotification("Reply accepted and inserted!");
    });

    rejectBtn.addEventListener("click", () => {
        composeBox.innerHTML = "";
        container.remove();
        aiButton.disabled = false;
        aiButton.innerHTML = "✨ AI Reply";
        showNotification("Reply rejected.", true);
    });

    container.appendChild(acceptBtn);
    container.appendChild(rejectBtn);
    return container;
}

// ── API call ─────────────────────────────────────────────────

async function generateReply(emailContent, tone) {
    const response = await fetch(API_URL, {
        method: "POST",
        headers: { "Content-Type": "application/json" },
        // Matches EmailRequest { emailContent, tone }
        body: JSON.stringify({ emailContent, tone })
    });

    if (!response.ok) {
        throw new Error(`Server error: ${response.status} ${response.statusText}`);
    }
    return response.text();
}

// ── Button injection ─────────────────────────────────────────

function injectButton() {
    // Avoid duplicate injection
    if (document.querySelector(".ai-reply-button")) return;

    const toolbar = findComposeToolbar();
    if (!toolbar) return;

    // Outer wrapper inserted above the toolbar
    const wrapper = document.createElement("div");
    Object.assign(wrapper.style, {
        display: "flex",
        flexDirection: "column",
        padding: "8px 12px",
        backgroundColor: "#f8f9fa",
        borderRadius: "8px",
        margin: "6px 0",
        boxShadow: "0 1px 3px rgba(0,0,0,0.1)"
    });

    const controls = document.createElement("div");
    Object.assign(controls.style, {
        display: "flex",
        alignItems: "center",
        gap: "10px",
        flexWrap: "wrap"
    });

    const aiButton     = createAIButton();
    const toneSelector = createToneSelector();

    controls.appendChild(aiButton);
    controls.appendChild(toneSelector);
    wrapper.appendChild(controls);
    toolbar.insertBefore(wrapper, toolbar.firstChild);

    // ── Click handler ──
    aiButton.addEventListener("click", async () => {
        if (aiButton.disabled) return;

        const emailContent = getEmailContent();
        if (!emailContent) {
            showNotification("Could not find email content to reply to.", true);
            return;
        }

        const tone = toneSelector.querySelector("select").value;

        // Loading state
        aiButton.disabled = true;
        aiButton.innerHTML = "Generating…";
        aiButton.appendChild(createLoadingSpinner());

        // Remove any previous action buttons
        const prev = wrapper.querySelector(".ai-action-buttons");
        if (prev) prev.remove();

        try {
            const reply = await generateReply(emailContent, tone);

            const composeBox = findComposeBox();
            if (!composeBox) throw new Error("Compose box not found.");

            // Insert reply as plain paragraphs
            composeBox.innerHTML = reply
                .split("\n")
                .map(line => line.trim()
                    ? `<div>${line}</div>`
                    : `<div><br></div>`)
                .join("");

            // Show accept / reject buttons
            const actionBtns = createActionButtons(composeBox.innerHTML, composeBox, aiButton);
            actionBtns.className = "ai-action-buttons";
            wrapper.appendChild(actionBtns);

        } catch (err) {
            console.error("[AI Reply]", err);
            showNotification(err.message || "Failed to generate reply.", true);
            aiButton.disabled = false;
            aiButton.innerHTML = "✨ AI Reply";
        }
    });
}

// ── Observer: watch for Gmail compose window ─────────────────

const observer = new MutationObserver(() => {
    if (document.querySelector(".btC, .aDh, [role='toolbar']")) {
        injectButton();
    }
});

observer.observe(document.body, { childList: true, subtree: true });
