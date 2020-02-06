function showTab(tab){
  $('.nav-tabs a[href="#' + tab + '"]').tab('show');
};

function notifySuccess(title, message, positionClass){
  var dfltPositionClass = "toast-top-right";
  if(positionClass){
    dfltPositionClass = positionClass;
  }
  var opts = {
    "closeButton": true,
    "debug": false,
    "positionClass": dfltPositionClass,
    "onclick": null,
    "showDuration": "300",
    "hideDuration": "1000",
    "timeOut": "5000",
    "extendedTimeOut": "1000",
    "showEasing": "swing",
    "hideEasing": "linear",
    "showMethod": "fadeIn",
    "hideMethod": "fadeOut"
  };
  
  toastr.success(message, title, opts);
}

function notifyError(title, message, positionClass){
  var dfltPositionClass = "toast-top-right"
  if(positionClass){
    dfltPositionClass = positionClass
  }
  var opts = {
    "closeButton": true,
    "debug": false,
    "positionClass": dfltPositionClass,
    "onclick": null,
    "showDuration": "300",
    "hideDuration": "1000",
    "timeOut": "5000",
    "extendedTimeOut": "1000",
    "showEasing": "swing",
    "hideEasing": "linear",
    "showMethod": "fadeIn",
    "hideMethod": "fadeOut"
  };
  
  toastr.error(message, title, opts);
}

function notifyInfo(title, message, positionClass){
  var dfltPositionClass = "toast-top-right"
  if(positionClass){
    dfltPositionClass = positionClass
  }
  var opts = {
    "closeButton": true,
    "debug": false,
    "positionClass": dfltPositionClass,
    "onclick": null,
    "showDuration": "300",
    "hideDuration": "1000",
    "timeOut": "5000",
    "extendedTimeOut": "1000",
    "showEasing": "swing",
    "hideEasing": "linear",
    "showMethod": "fadeIn",
    "hideMethod": "fadeOut"
  };
  
  toastr.info(message, title, opts);
}

// Pass formID to this method and it will set the mouse pointer focus on the first element.
// A prerequiste is that the first input element should have class set to 'first-input'
function setFocusOnFirstInput(formId){
  $('#' + formId + ' *:input[type!=hidden]:input[data-dismiss!=alert]:input[type!=button]:input:not([disabled]):first').focus();
}

// Show and Hide Loader
function showLoader(){
  $("#LOADER").show();
}

function hideLoader(){
  $("#LOADER").hide();
}


// Show Loader till the page loads completely.
// $(window).load(function() {
$(document).ready(function() {
  hideLoader();
});

$(document).on('ajax:send',window, function () {
  showLoader();
});

$(document).on('ajax:complete',window, function () {
  hideLoader();
});