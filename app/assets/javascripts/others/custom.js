$( document ).ready(function() {
  //CKEditor

  alert("ff")
  CKEDITOR.replace('ckeditor');
  CKEDITOR.config.height = 300;
  //CKEDITOR.config.removeButtons = 'Source';
  CKEDITOR.config.removeButtons = 'Underline,Subscript,Superscript';
});