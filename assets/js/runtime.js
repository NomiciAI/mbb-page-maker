(function () {
  const slides = Array.from(document.querySelectorAll(".slide"));
  const params = new URLSearchParams(window.location.search);
  const printMode = params.get("print") === "1";
  const exportMode = params.get("export") === "1";
  const previewMode = params.has("preview");
  const requestedSlide = previewMode ? params.get("preview") : params.get("slide");
  let index = Math.max(0, Math.min(slides.length - 1, Number(requestedSlide || 1) - 1));
  let status;
  let touchStartX = 0;
  let touchStartY = 0;
  let lastWheelAt = 0;

  function parseColor(value) {
    if (!value || value === "transparent") return null;
    const hex = value.trim().match(/^#([0-9a-f]{3}|[0-9a-f]{6})$/i);
    if (hex) {
      const raw = hex[1].length === 3
        ? hex[1].split("").map((part) => part + part).join("")
        : hex[1];
      return {
        r: Number.parseInt(raw.slice(0, 2), 16),
        g: Number.parseInt(raw.slice(2, 4), 16),
        b: Number.parseInt(raw.slice(4, 6), 16),
        a: 1
      };
    }
    const match = value.match(/rgba?\(([^)]+)\)/i);
    const srgb = value.match(/color\(srgb\s+([^)]+)\)/i);
    if (!match && !srgb) return null;
    const parts = (match ? match[1] : srgb[1]).split(/[\s,\/]+/).filter(Boolean).map(Number);
    if (parts.length < 3 || parts.some((part, i) => i < 3 && !Number.isFinite(part))) return null;
    const multiplier = srgb ? 255 : 1;
    return {
      r: Math.max(0, Math.min(255, parts[0] * multiplier)),
      g: Math.max(0, Math.min(255, parts[1] * multiplier)),
      b: Math.max(0, Math.min(255, parts[2] * multiplier)),
      a: Number.isFinite(parts[3]) ? Math.max(0, Math.min(1, parts[3])) : 1
    };
  }

  function luminance(color) {
    const channel = (value) => {
      const ratio = value / 255;
      return ratio <= 0.03928 ? ratio / 12.92 : ((ratio + 0.055) / 1.055) ** 2.4;
    };
    return 0.2126 * channel(color.r) + 0.7152 * channel(color.g) + 0.0722 * channel(color.b);
  }

  function contrastRatio(foreground, background) {
    const lighter = Math.max(luminance(foreground), luminance(background));
    const darker = Math.min(luminance(foreground), luminance(background));
    return (lighter + 0.05) / (darker + 0.05);
  }

  function colorToRgb(color) {
    return `rgb(${Math.round(color.r)}, ${Math.round(color.g)}, ${Math.round(color.b)})`;
  }

  function effectiveBackground(element) {
    let current = element;
    while (current && current.nodeType === Node.ELEMENT_NODE) {
      const style = window.getComputedStyle(current);
      const color = parseColor(style.backgroundColor);
      if (color && color.a > 0.05) return color;
      if (style.backgroundImage && style.backgroundImage !== "none") {
        const tokenColor = parseColor(style.getPropertyValue("--color-bg").trim())
          || parseColor(style.getPropertyValue("--theme-dark-bg").trim())
          || parseColor(style.getPropertyValue("--theme-light-bg").trim());
        if (tokenColor) return tokenColor;
      }
      current = current.parentElement;
    }
    return parseColor(window.getComputedStyle(document.body).backgroundColor) || { r: 255, g: 255, b: 255, a: 1 };
  }

  function hasDarkContext(slide) {
    return slide.matches(".dark, [data-mode='dark'], [data-tone='dark'], .dark-cover, [data-variant='dark-cover'], .auto-dark");
  }

  function syncAutoColorMode() {
    slides.forEach((slide) => {
      if (hasDarkContext(slide)) return;
      const background = effectiveBackground(slide);
      if (background && luminance(background) < 0.28) {
        slide.classList.add("auto-dark");
        slide.dataset.autoMode = "dark";
      }
    });
  }

  function readPxVar(name, fallback) {
    const value = window.getComputedStyle(document.documentElement).getPropertyValue(name).trim();
    const parsed = Number.parseFloat(value);
    return Number.isFinite(parsed) ? parsed : fallback;
  }

  function syncSlideScale() {
    if (printMode || document.body.classList.contains("is-overview")) return;
    const slideWidth = readPxVar("--slide-width", 1600);
    const slideHeight = readPxVar("--slide-height", 900);
    const inset = 24;
    const scale = Math.min(
      (window.innerWidth - inset) / slideWidth,
      (window.innerHeight - inset) / slideHeight,
      1
    );
    const safeScale = Math.max(0.1, scale);
    document.documentElement.style.setProperty("--deck-scale", safeScale.toFixed(5));
    document.documentElement.style.setProperty("--deck-frame-width", `${slideWidth * safeScale}px`);
    document.documentElement.style.setProperty("--deck-frame-height", `${slideHeight * safeScale}px`);
  }

  function setPageNumbers() {
    slides.forEach((slide, i) => {
      const number = slide.querySelector(".page-number");
      if (number) number.dataset.page = String(i + 1);
    });
  }

  function show(nextIndex) {
    if (!slides.length || document.body.classList.contains("is-overview")) return;
    syncSlideScale();
    const previousIndex = index;
    const boundedIndex = Math.max(0, Math.min(slides.length - 1, nextIndex));
    if (boundedIndex === index && nextIndex !== index) {
      bump(nextIndex < index ? "left" : "right");
      return;
    }
    index = boundedIndex;
    slides.forEach((slide) => {
      slide.classList.remove("active", "is-enter-next", "is-enter-prev", "is-bump-left", "is-bump-right");
    });
    const active = slides[index];
    syncAutoColorMode();
    active.classList.add("active");
    if (index !== previousIndex) {
      active.classList.add(index > previousIndex ? "is-enter-next" : "is-enter-prev");
      active.addEventListener("animationend", () => {
        active.classList.remove("is-enter-next", "is-enter-prev");
      }, { once: true });
    }
    if (status) status.textContent = `${index + 1} / ${slides.length}`;
    if (!previewMode && !exportMode) history.replaceState(null, "", `#${index + 1}`);
  }

  function bump(direction) {
    const active = slides[index];
    if (!active) return;
    const className = direction === "left" ? "is-bump-left" : "is-bump-right";
    active.classList.remove("is-bump-left", "is-bump-right");
    active.offsetHeight;
    active.classList.add(className);
    active.addEventListener("animationend", () => {
      active.classList.remove(className);
    }, { once: true });
  }

  function toggleOverview() {
    document.body.classList.toggle("is-overview");
    if (!document.body.classList.contains("is-overview")) {
      syncSlideScale();
      show(index);
    }
  }

  function addControls() {
    const controls = document.createElement("nav");
    controls.className = "deck-controls";
    controls.setAttribute("aria-label", "Deck controls");
    controls.innerHTML = [
      '<button type="button" data-action="prev" title="Previous slide">‹</button>',
      '<span class="deck-status" aria-live="polite"></span>',
      '<button type="button" data-action="next" title="Next slide">›</button>',
      '<button type="button" data-action="overview" title="Overview">□</button>'
    ].join("");
    status = controls.querySelector(".deck-status");
    controls.addEventListener("click", (event) => {
      const action = event.target && event.target.dataset.action;
      if (action === "prev") show(index - 1);
      if (action === "next") show(index + 1);
      if (action === "overview") toggleOverview();
    });
    document.body.appendChild(controls);
  }

  function bindKeys() {
    document.addEventListener("keydown", (event) => {
      if (event.key === "ArrowRight" || event.key === "PageDown" || event.key === " ") {
        event.preventDefault();
        show(index + 1);
      }
      if (event.key === "ArrowLeft" || event.key === "PageUp") {
        event.preventDefault();
        show(index - 1);
      }
      if (event.key.toLowerCase() === "o") toggleOverview();
      if (event.key === "Escape" && document.body.classList.contains("is-overview")) toggleOverview();
    });

    slides.forEach((slide, i) => {
      slide.addEventListener("click", (event) => {
        if (event.target.closest(".deck-controls")) return;
        if (document.body.classList.contains("is-overview")) {
          index = i;
          toggleOverview();
          return;
        }
        const x = event.clientX;
        const midpoint = window.innerWidth / 2;
        show(x < midpoint ? index - 1 : index + 1);
      });
    });
  }

  function bindSwipe() {
    document.addEventListener("touchstart", (event) => {
      const touch = event.changedTouches[0];
      touchStartX = touch.clientX;
      touchStartY = touch.clientY;
    }, { passive: true });

    document.addEventListener("touchend", (event) => {
      if (document.body.classList.contains("is-overview")) return;
      const touch = event.changedTouches[0];
      const dx = touch.clientX - touchStartX;
      const dy = touch.clientY - touchStartY;
      if (Math.abs(dx) < 48 || Math.abs(dx) < Math.abs(dy) * 1.4) return;
      show(dx < 0 ? index + 1 : index - 1);
    }, { passive: true });

    document.addEventListener("wheel", (event) => {
      if (document.body.classList.contains("is-overview")) return;
      if (Math.abs(event.deltaX) < 80 || Math.abs(event.deltaX) < Math.abs(event.deltaY) * 1.2) return;
      const now = Date.now();
      if (now - lastWheelAt < 460) return;
      lastWheelAt = now;
      show(event.deltaX > 0 ? index + 1 : index - 1);
    }, { passive: true });
  }

  function visibleTextNodes() {
    const walker = document.createTreeWalker(document.body, NodeFilter.SHOW_TEXT, {
      acceptNode(node) {
        if (!node.textContent || !node.textContent.trim()) return NodeFilter.FILTER_REJECT;
        const element = node.parentElement;
        if (!element || element.closest("script, style, noscript, .deck-controls, #deck-audit-report")) {
          return NodeFilter.FILTER_REJECT;
        }
        const style = window.getComputedStyle(element);
        if (style.visibility === "hidden" || style.display === "none" || Number.parseFloat(style.opacity) === 0) {
          return NodeFilter.FILTER_REJECT;
        }
        const rect = element.getBoundingClientRect();
        if (rect.width < 1 || rect.height < 1) return NodeFilter.FILTER_REJECT;
        return NodeFilter.FILTER_ACCEPT;
      }
    });
    const nodes = [];
    while (walker.nextNode()) nodes.push(walker.currentNode);
    return nodes;
  }

  function runDeckAudit() {
    if (params.get("audit") !== "1") return;
    syncAutoColorMode();
    const failures = [];
    visibleTextNodes().forEach((node) => {
      const element = node.parentElement;
      const style = window.getComputedStyle(element);
      const foreground = parseColor(style.color);
      const background = effectiveBackground(element);
      if (!foreground || !background) return;
      const ratio = contrastRatio(foreground, background);
      const fontSize = Number.parseFloat(style.fontSize) || 0;
      const fontWeight = Number.parseInt(style.fontWeight, 10) || 400;
      const largeText = fontSize >= 24 || (fontSize >= 18.66 && fontWeight >= 700);
      const minimum = largeText ? 3 : 4.5;
      if (ratio + 0.01 < minimum) {
        const slide = element.closest(".slide");
        failures.push({
          slide: slide ? slides.indexOf(slide) + 1 : null,
          text: node.textContent.trim().slice(0, 80),
          ratio: Number(ratio.toFixed(2)),
          minimum,
          color: style.color,
          background: colorToRgb(background)
        });
      }
    });
    const report = document.createElement("pre");
    report.id = "deck-audit-report";
    report.hidden = true;
    report.textContent = failures.length
      ? `DECK_AUDIT_FAIL ${JSON.stringify(failures)}`
      : "DECK_AUDIT_PASS []";
    document.body.appendChild(report);
    document.body.dataset.auditStatus = failures.length ? "fail" : "pass";
    if (failures.length) {
      console.warn("Deck contrast audit failed", failures);
    }
  }

  setPageNumbers();
  window.addEventListener("resize", syncSlideScale);

  if (printMode) {
    document.body.classList.add("is-print");
    slides.forEach((slide) => slide.classList.add("active"));
    syncAutoColorMode();
    runDeckAudit();
    return;
  }

  const hashIndex = Number((window.location.hash || "").replace("#", ""));
  if (hashIndex > 0) index = Math.max(0, Math.min(slides.length - 1, hashIndex - 1));
  if (previewMode) document.body.classList.add("is-preview");
  if (exportMode || previewMode) document.body.classList.add("is-export");
  if (!exportMode && !previewMode) addControls();
  show(index);
  if (!exportMode && !previewMode) {
    bindKeys();
    bindSwipe();
  }
  runDeckAudit();
})();
