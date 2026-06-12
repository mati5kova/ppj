const s = document.createElement("script");

s.onload = () => {
    const el = document.querySelector('#region-main, main, [role="main"]');

    if (!el) {
        console.error("Main Moodle content not found");
        return;
    }

    const turndownService = new TurndownService();
    const markdown = turndownService.turndown(el.innerHTML);

    const textarea = document.createElement("textarea");
    textarea.value = markdown;
    textarea.style.position = "fixed";
    textarea.style.left = "20px";
    textarea.style.top = "20px";
    textarea.style.width = "90vw";
    textarea.style.height = "70vh";
    textarea.style.zIndex = "999999";
    textarea.style.background = "white";
    textarea.style.color = "black";
    textarea.style.fontSize = "14px";

    document.body.appendChild(textarea);
    textarea.focus();
    textarea.select();

    console.log("Markdown is selected in the textarea. Press Ctrl+C or Cmd+C.");
};

s.src = "https://unpkg.com/turndown/dist/turndown.js";
document.body.appendChild(s);
