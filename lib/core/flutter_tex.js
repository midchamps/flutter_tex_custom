"use strict";

const appAssetsUri = "../../..";

var isWeb;

function initTeXViewMobile(flutterTeXData) {
    var teXViewElement = document.getElementById('TeXView');
    teXViewElement.innerHTML = '';
    teXViewElement.appendChild(createTeXView(flutterTeXData), teXViewElement, "");
    renderTeXView(() => renderCompleted(teXViewElement, ""));
}

function initTeXViewWeb(iframeContentWindow, iframeId, flutterTeXData) {
    isWeb = true;
    var teXViewElement = iframeContentWindow.document.getElementById('TeXView');
    teXViewElement.innerHTML = '';
    teXViewElement.appendChild(createTeXView(JSON.parse(flutterTeXData), teXViewElement, iframeId));
    iframeContentWindow.renderTeXView(() => renderCompleted(teXViewElement, iframeId));
}


function createTeXView(rootData, teXViewElement, iframeId) {

    var meta = rootData['meta'];
    var data = rootData['data'];
    var id = meta['id']
    var classList = meta['classList'];

    var element = document.createElement(meta['tag']);
    element.classList.add(classList);
    element.setAttribute('style', rootData['style']);
    element.setAttribute('id', id)

    switch (meta['node']) {
        case 'root': {
            element.appendChild(createTeXView(data, teXViewElement, iframeId));
            break;
        }
        case 'leaf': {
            if (meta['tag'] === 'img') {
                if (classList === 'tex-view-asset-image') {
                    element.setAttribute('src', appAssetsUri + '/' + data);
                } else {
                    element.setAttribute('src', data);
                    element.addEventListener("load", () =>
                        renderCompleted(teXViewElement, iframeId)

                    );
                }
            } else {
                element.innerHTML = data;
            }

            break;
        }
        case 'internal_child': {
            element.appendChild(createTeXView(data, teXViewElement, iframeId));

            if (classList === 'tex-view-ink-well') clickManager(iframeId, element, id, rootData['rippleEffect']);
            break;
        }

        default: {
            if (classList === 'tex-view-group') {
                createTeXViewGroup(teXViewElement, element, rootData);
            } else {
                data.forEach(function (childViewData) {
                    element.appendChild(createTeXView(childViewData, teXViewElement, iframeId));
                });
            }
        }
    }
    return element;
}

function renderCompleted(texViewElement, iframeId) {
    let lastHeight;

    function execute() {
        const height = getTeXViewHeight(texViewElement);
        const rendered = lastHeight === height;
        lastHeight = height;

        if (isWeb) {
            OnTeXViewRenderedCallback(height, iframeId);
        } else {
            OnTeXViewRenderedCallback.postMessage(height);
        }

        if (!rendered) {
            console.log('TeXView not fully rendered yet! Retrying in 250ms...');
            setTimeout(() => execute(texViewElement), 250);
        }
    }
    execute();
}


function clickManager(iframeId, element, id, rippleEffect, callback) {
    element.addEventListener('click', function (e) {
        if (callback != null) {
            callback(id);
        } else {
            onTapCallback(id, iframeId);
        }

        if (rippleEffect) {
            var ripple = document.createElement('div');
            this.appendChild(ripple);
            var d = Math.max(this.clientWidth, this.clientHeight);
            ripple.style.width = ripple.style.height = d + 'px';
            var rect = this.getBoundingClientRect();
            ripple.style.left = e.clientX - rect.left - d / 2 + 'px';
            ripple.style.top = e.clientY - rect.top - d / 2 + 'px';
            ripple.classList.add('ripple');
        }
    });
}


function onTapCallback(message, iframeId) {
    if (isWeb) {
        OnTapCallback(message, iframeId);
    } else {
        OnTapCallback.postMessage(message);
    }
}

function getTeXViewHeight(view) {
    var height = view.offsetHeight,
        style = window.getComputedStyle(view)
    return ['top', 'bottom']
        .map(function (side) {
            return parseInt(style["margin-" + side]);
        })
        .reduce(function (total, side) {
            return total + side;
        }, height)
}

///////////////////////////////////////////////////////// Deprecated /////////////////////////////////////////////////

function createTeXViewGroup(teXView, element, rootData) {

    var normalStyle = rootData['normalItemStyle'];
    var selectedStyle = rootData['selectedItemStyle'];
    var single = rootData['single'];

    var selected = rootData['selected'];

    var selectedIds = [];

    rootData['data'].forEach(function (data) {
        data['style'] = normalStyle;
        var item = createTeXView(data);
        var id = data['meta']['id'];
        item.setAttribute('id', id);

        if (single && selected === id) {
            item.setAttribute('style', selectedStyle);
        }

        clickManager(item, id, rootData['rippleEffect'], function (clickedId) {
            if (clickedId === id) {
                if (single) {
                    if (selected !== null) element.querySelector('#' + selected).setAttribute('style', normalStyle);
                    item.setAttribute('style', selectedStyle);
                    selected = clickedId;
                    onTapCallback(clickedId);
                } else {
                    if (arrayContains(selectedIds, clickedId)) {
                        document.getElementById(clickedId).setAttribute('style', normalStyle);
                        selectedIds.splice(selectedIds.indexOf(clickedId), 1);
                    } else {
                        document.getElementById(clickedId).setAttribute('style', selectedStyle);
                        selectedIds.push(clickedId);
                    }
                    onTapCallback(JSON.stringify(selectedIds));
                }
            }
            renderCompleted(teXView);
        });
        element.appendChild(item);
    });
}

function arrayContains(array, obj) {
    var i = array.length;
    while (i--) {
        if (array[i] === obj) {
            return true;
        }
    }
    return false;
}