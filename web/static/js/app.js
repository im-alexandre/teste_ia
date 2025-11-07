document.addEventListener('DOMContentLoaded', () => {
  const nav = document.querySelector('[data-nav]');
  const toggle = document.querySelector('.nav-toggle');
  const yearEl = document.getElementById('year');

  if (yearEl) yearEl.textContent = new Date().getFullYear();

  if (toggle && nav) {
    toggle.addEventListener('click', () => {
      const open = nav.classList.toggle('open');
      toggle.setAttribute('aria-expanded', String(open));
    });
  }
});

