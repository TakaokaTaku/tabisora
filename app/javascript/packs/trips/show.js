$(function() {
  $(".photo-delete-form").click(function() {
    $(".photo-delete-btn").css("display", "block");
    $(".check-box").css("display", "block");
    $(".form-open").css("display", "none");
    $(".garally").attr("data-toggle", "");
    $(this).css("display", "none");
  });

  $(".photo-reset-btn").click(function() {
    $(".photo-delete-btn").css("display", "none");
    $(".check-box").css("display", "none");
    $(".photo-delete-form").css("display", "block");
    $(".form-open").css("display", "block");
    $(".garally").attr("data-toggle", "modal");
  });
});
