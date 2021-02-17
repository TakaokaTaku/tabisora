$(function() {
  $(".form-open").click(function() {
    $(".form-box").css("display", "block");
    $(".photo-delete-form").css("display", "none");
    $(this).css("display", "none");
  });

  $(".form-close").click(function() {
    $(".form-box").css("display", "none");
    $(".form-open").css("display", "block");
    $(".photo-delete-form").css("display", "block");
  });
});
