import { mathjax } from 'mathjax-full/js/mathjax';
import { liteAdaptor } from 'mathjax-full/js/adaptors/liteAdaptor';
import { RegisterHTMLHandler } from 'mathjax-full/js/handlers/html';
import { TeX } from 'mathjax-full/js/input/tex';
import { MathML } from 'mathjax-full/js/input/mathml';
import { AsciiMath } from 'mathjax-full/js/input/asciimath';
import { SVG } from 'mathjax-full/js/output/svg';
import { AllPackages } from 'mathjax-full/js/input/tex/AllPackages.js'; // Or list specific ones



const adaptor = liteAdaptor();
RegisterHTMLHandler(adaptor);

const inputOptions = {}

const texInput = new TeX({
    packages: AllPackages,
    ...inputOptions
})
const mathmlInput = new MathML(inputOptions);
const asciiInput = new AsciiMath(inputOptions);

const outputJax = new SVG()

function teX2SVG(math: string, inputType: string, options?: any): string {
    return adaptor.innerHTML(mathjax.document('', {
        InputJax: getInputType(inputType), OutputJax: outputJax
    }).convert(math, options))
}

function getInputType(input: string) {
    switch (input) {
        case 'teX':
            return texInput;
        case 'mathML':
            return mathmlInput;
        case 'asciiMath':
            return asciiInput;
        default:
            return texInput;
    }
}

(window as any).teX2SVG = teX2SVG;