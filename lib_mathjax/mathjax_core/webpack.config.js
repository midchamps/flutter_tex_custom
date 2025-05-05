const PACKAGE = require('mathjax-full/components/webpack.common.js');

module.exports = PACKAGE(
    'index',                     // the name of the package to build
    'node_modules/mathjax-full/js',    // location of the mathjax library
    [],                                   // packages to link to
    __dirname,                            // our directory
    'dist'                                   // where to put the packaged component
);