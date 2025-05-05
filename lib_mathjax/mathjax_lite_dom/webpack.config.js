
const path = require('path');


module.exports = {
    mode: 'development',
    entry: './src/index.ts',

    module: {
        rules: [
            {
                test: /\.ts$/,
                exclude: /node_modules/,
                use: {
                    loader: 'babel-loader',
                    options: {
                        presets: [
                            '@babel/preset-env',
                            '@babel/preset-typescript',
                        ],
                    },
                },
            },
        ],
    },
    output: {
        path: path.resolve(__dirname, 'dist/'),
        filename: 'mathjax_lite_dom.js',
    },
    devServer: {
        static: 'dist/',
        hot: true
    }

};