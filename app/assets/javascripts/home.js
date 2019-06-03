$(function(){
  // aboutのへのページスクロール
  $('#header_about').click(function(){
    var id = $(this).attr('href');
    var position = $(id).offset().top;
    $('html, body').animate({
      'scrollTop': position
    }, 700);
  });
});
