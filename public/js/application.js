function goBack() {
    window.history.back()
}

// This hides imperfect search results
function noDisplay() {
  if $('.bm-item-artists:not("Monet")')
    $('.bm-item-artists').hide();
}();


