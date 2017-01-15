//= require jquery
//= require jquery_ujs
//= require ajax_setup
//= require ajax_modal
//= require bootstrap
//= require flash_message
//= require visibility_map
//= require modal
//= require select2
//= require select2_init

//= require bootstrap-toggle

//= require jquery.dataTables.min
//= require dataTables.bootstrap.min

//= require Chart

//= require fancybox

//= require jquery.countdown

//= require jquery.flexslider-min

//= require moment
//= require bootstrap-datetimepicker

//= require metisMenu.min
//= require sb-admin-2

$(document).on('ready page:change', function() {
  $('input[type="checkbox"].toggle').bootstrapToggle(); // assumes the checkboxes have the class "toggle"
});

$(document).ready(function() {

    function exportTableToCSV($table, filename) {
        var $rows = $table.find('tr:has(td)'),
            // Temporary delimiter characters unlikely to be typed by keyboard
            // This is to avoid accidentally splitting the actual contents
            tmpColDelim = String.fromCharCode(11), // vertical tab character
            tmpRowDelim = String.fromCharCode(0), // null character

            // actual delimiter characters for CSV format
            colDelim = '","',
            rowDelim = '"\r\n"',

            // Grab text from table into CSV formatted string
            csv = '"' + $rows.map(function (i, row) {
                var $row = $(row),
                    $cols = $row.find('td');

                return $cols.map(function (j, col) {
                    var $col = $(col),
                        text = $col.text();

                    return text.replace(/"/g, '""'); // escape double quotes

                }).get().join(tmpColDelim);

            }).get().join(tmpRowDelim)
                .split(tmpRowDelim).join(rowDelim)
                .split(tmpColDelim).join(colDelim) + '"',

            // Data URI
            csvData = 'data:application/csv;charset=utf-8,' + encodeURIComponent(csv);

        $(this)
            .attr({
            'download': filename,
                'href': csvData,
                'target': '_blank'
        });
    }

    // This must be a hyperlink
    $(".export1").on('click', function (event) {
        // CSV
        exportTableToCSV.apply(this, [$('#dvData1>table'), 'performance.csv']);

        // IF CSV, don't do event.preventDefault() or return false
        // We actually need this to be a typical hyperlink
    });
    $(".export2").on('click', function (event) {
        // CSV
        exportTableToCSV.apply(this, [$('#dvData2>table'), 'admintrainingrequests.csv']);

        // IF CSV, don't do event.preventDefault() or return false
        // We actually need this to be a typical hyperlink
    });
    



  function formatFA(icon) {
    if (!icon.id) {
        return icon.text;
    }
    var $icon = $('<i class="fa fa-'+icon.text+'"></i>').css({
        'color': icon.text
    }).text(icon.text).css("font-family", "FontAwesome,Arial");
    return $icon;
  };
  $('#iconSelect').select2({templateResult: formatFA});
  $('#colourSelect').select2({templateResult: formatFA});
  $('table.table-striped').DataTable();
  $(".js-example-responsive").select2();
  $(".js-example-basic-single").select2();
  $(".js-example-basic-single-category").select2({});
  $('.datetimepicker').datetimepicker();
  $("[data-toggle=popover]").popover({html:true})
  $("a.fancybox").fancybox({
  afterLoad: function() {this.title = 'Employee photo evidence' + this.title;},helpers : {title: {type: 'inside'}}});
  $(window).load(function() {
    $('.flexslider').flexslider({
      animation: "slide",
      animationLoop: true,
      itemWidth: 250,
      itemMargin: 0,
      slideDirection: "horizontal",   //String: Select the sliding direction, "horizontal" or "vertical"
      slideshow: true,                //Boolean: Animate slider automatically
      slideshowSpeed: 3000,           //Integer: Set the speed of the slideshow cycling, in milliseconds
      animationDuration: 6000,        //Integer: Set the speed of animations, in milliseconds
      directionNav: false,
      controlNav: false,
    });
  });
});
