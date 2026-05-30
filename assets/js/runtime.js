(function () {
  const slides = Array.from(document.querySelectorAll(".slide"));
  const params = new URLSearchParams(window.location.search);
  const printMode = params.get("print") === "1";
  let index = Math.max(0, Math.min(slides.length - 1, Number(params.get("slide") || 1) - 1));

  function show(nextIndex) {
    if (!slides.length) return;
    index = Math.max(0, Math.min(slides.length - 1, nextIndex));
    slides.forEach((slide, i) => slide.classList.toggle("active", i === index));
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
    });
  }

  if (printMode) {
    document.body.classList.add("is-print");
    slides.forEach((slide) => slide.classList.add("active"));
    return;
  }

  const hashIndex = Number((window.location.hash || "").replace("#", ""));
  if (hashIndex > 0) index = Math.max(0, Math.min(slides.length - 1, hashIndex - 1));
  show(index);
  bindKeys();
})();
