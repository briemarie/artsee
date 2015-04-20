function goBack() {
    window.history.back()
}

// This will be a function to hide imperfect search results
function noDisplay() {
  if $('.bm-item-artists:not("Monet")')
    $('.bm-item-artists').hide();
}


