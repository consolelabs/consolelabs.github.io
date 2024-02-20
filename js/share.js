window.onload = function () {
  document.addEventListener("mousedown", (e) => {
    const tooltip = document.querySelector("#tooltip");
    console.log(e.target);
    if (tooltip === e.target || tooltip.contains(e.target)) return;
    tooltip.classList.remove("pop--visible");
  });
  document.addEventListener("mouseup", () => {
    const tooltip = document.querySelector("#tooltip");
    const selection = window.getSelection();
    const text = selection.toString();
    if (!text) return;
    tooltip.classList.add("pop--visible");

    tooltip.href = `https://twitter.com/intent/tweet?text=${encodeURIComponent(
      text + "\n" + window.location.href
    )}`;
    Popper.createPopper(selection.getRangeAt(0), tooltip, {
      placement: "top",
      modifiers: [
        {
          name: "offset",
          options: {
            offset: [0, 10],
          },
        },
      ],
    });
  });

  console.log("share script init ok");
};
