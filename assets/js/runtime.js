(function () {
  const slides = Array.from(document.querySelectorAll(".slide"));
  const params = new URLSearchParams(window.location.search);
  const printMode = params.get("print") === "1";
  let index = Math.max(0, Math.min(slides.length - 1, Number(params.get("slide") || 1) - 1));
  let status;
  let touchStartX = 0;
  let touchStartY = 0;

  function setPageNumbers() {
    slides.forEach((slide, i) => {
      const number = slide.querySelector(".page-number");
      if (number) number.dataset.page = String(i + 1);
    });
  }

  function show(nextIndex) {
    if (!slides.length || document.body.classList.contains("is-overview")) return;
    index = Math.max(0, Math.min(slides.length - 1, nextIndex));
    slides.forEach((slide, i) => slide.classList.toggle("active", i === index));
    if (status) status.textContent = `${index + 1} / ${slides.length}`;
    history.replaceState(null, "", `#${index + 1}`);
  }

  function toggleOverview() {
    document.body.classList.toggle("is-overview");
    if (!document.body.classList.contains("is-overview")) show(index);
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
      slide.addEventListener("click", () => {
        if (!document.body.classList.contains("is-overview")) return;
        index = i;
        toggleOverview();
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
      show(event.deltaX > 0 ? index + 1 : index - 1);
    }, { passive: true });
  }

  setPageNumbers();

  if (printMode) {
    document.body.classList.add("is-print");
    slides.forEach((slide) => slide.classList.add("active"));
    return;
  }

  const hashIndex = Number((window.location.hash || "").replace("#", ""));
  if (hashIndex > 0) index = Math.max(0, Math.min(slides.length - 1, hashIndex - 1));
  addControls();
  show(index);
  bindKeys();
  bindSwipe();
})();
