/*jshint strict:false*/
/*global CasperError, console, phantom, require*/
var casper = require("casper").create();
var links = [];

casper.start('http://www.strimillinn.is/i/efni/id-2', function() {
    links = this.evaluate(function() {
        var li = [];
        var stuff = jQuery("tr > td:first-child > a");
        stuff.each(function() {
            li.push({
                'href': "http://www.strimillinn.is" + jQuery(this).attr('href'),
                'date': jQuery(this).text().replace(/\./g, '-')
            });
        });
        return li;
    });
});

casper.then(function() {
    var index = 0;
    casper.each(links, function(self, link) {
        casper.thenOpen(link['href'], function() {
            var image_url = this.evaluate(function() {
                var src = jQuery('#content .span3 img').attr('src');
                return "http://www.strimillinn.is" + src;
            });
            var target = index + "-" + link['date'] + '.jpg';
            casper.echo("Downloading " + image_url + " to " + target);
            casper.download(image_url, target);
            index++;
        });
    });
});

casper.run();