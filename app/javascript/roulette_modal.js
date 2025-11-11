function initRouletteModal() {
  const modal = document.getElementById('roulette-modal');
  const openBtn = document.getElementById('open-roulette-modal');
  const closeBtn = document.getElementById('close-roulette-modal');

  if (!modal || !openBtn || !closeBtn) {
    return;
  }

  const openModal = () => modal.classList.remove('hidden');
  const closeModal = () => modal.classList.add('hidden');

  openBtn.addEventListener('click', openModal);
  closeBtn.addEventListener('click', closeModal);

  // モーダルの外側をクリックしたときに閉じる
  modal.addEventListener('click', (event) => {
    if (event.target === modal) {
      closeModal();
    }
  });
}

// Turbo Driveによるページ遷移でも関数が実行されるようにする
document.addEventListener('turbo:load', initRouletteModal);