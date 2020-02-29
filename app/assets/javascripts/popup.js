var smallModalId = "DIV_MODAL_SMALL";

// Show Modal Methods

function showSmallModal(heading, bodyContent, showHeading){
  $('#' + smallModalId + ' .modal-header .modal-title').text(heading);
  $('#' + smallModalId + ' .modal-content').html(bodyContent);
  $('#' + smallModalId).modal({show: true, backdrop: 'static', keyboard: false});
  
  if(showHeading){
    $('#' + smallModalId + ' .modal-header').show();
  }
  else {
    $('#' + smallModalId + ' .modal-header').hide();
  }

  setTimeout(function() {
    $('#' + smallModalId).modal('handleUpdate'); //Update backdrop on modal show
    $('#' + smallModalId).scrollTop(0); //reset modal to top position
  }, 1000);
}

// Close Modal Methods

function closeSmallModal(){
  $('#' + smallModalId).modal('hide');
}