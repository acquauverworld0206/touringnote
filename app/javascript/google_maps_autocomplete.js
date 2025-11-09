function initAutocomplete() {
  const addressField = document.getElementById('spot_address');
  if (addressField) {
    const autocomplete = new google.maps.places.Autocomplete(addressField, {
      types: ['geocode', 'establishment'], // 住所と施設名で検索
      fields: ['place_id', 'geometry', 'name', 'formatted_address'] // 取得する情報
    });
  }
}

// Turbo Driveによるページ遷移でも関数が実行されるようにする
document.addEventListener('turbo:load', initAutocomplete);
// 初回読み込み時にも実行
document.addEventListener('DOMContentLoaded', initAutocomplete);