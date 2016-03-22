'use strict';
var global = require('./../../../globalDefinition');
var productRepository = require('../../product/repositories/productRepository');
var databaseIntance = require('./../../core/connection/connection')();
var productService = require('../../product/services/productService')(productRepository, databaseIntance);


module.exports = function (app, modules){

    var routeServer = modules.express.Router();

    routeServer.use(function(req, res, next){
        global.allowCros(res);
        next();
    });

    routeServer.get('/products/:brandId?', function(req, res) {
        var brandId = req.params.brandId;

        productService.getProductsByBrandId(brandId, function(data){
            res.send(200, data);
        });
    });

    routeServer.get('/products/:productId/reviews', function(req, res) {
        var productId = req.params.productId;

        productService.getReviewsByProductId(productId, function(data){
            res.send(200, data);
        });

    });

    routeServer.get('/product/:productId', function(req, res) {
        var productId = req.params.productId;

        productService.getProductById(productId, function(data){
            res.send(200, data);
        });

    });

    routeServer.post('/products/add', function(req, res){
        var body, post;

        req.on('data', function (data) {
            if (data.length > 1e6) {
                // Flood attack, nuke request.
                res.json({ error: 'Request entity too large.' }, 413);
            }
            body += data;
        });

        req.on('end', function () {
            body = body.replace('undefined', '');
            post = JSON.parse(body);
            productService.addReview(post, function(data){
                res.send(200, data);
            });
        });


    });

    app.use('/api', routeServer);
};


