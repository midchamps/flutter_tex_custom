import { mathjax } from 'mathjax-full/js/mathjax';
import { liteAdaptor } from 'mathjax-full/js/adaptors/liteAdaptor';
import { RegisterHTMLHandler } from 'mathjax-full/js/handlers/html';
import { TeX } from 'mathjax-full/js/input/tex';
import { MathML } from 'mathjax-full/js/input/mathml';
import { AsciiMath } from 'mathjax-full/js/input/asciimath';
import { SVG } from 'mathjax-full/js/output/svg';

const adaptor = liteAdaptor();

RegisterHTMLHandler(adaptor);

const html = mathjax.document('', { InputJax: getInputType("ascii", {}), OutputJax: new SVG() });


function TeX2SVG(math: string, options?: any): string {
    return adaptor.outerHTML(html.convert(math, options))
}

function getInputType(input: string, input_options: any) {

    switch (input) {
        case 'tex':
            return new TeX(input_options);
        case 'mathml':
            return new MathML(input_options);
        case 'ascii':
            return new AsciiMath(input_options);
        default:
            return new TeX(input_options);
    }

}

(window as any).TeX2SVG = TeX2SVG;