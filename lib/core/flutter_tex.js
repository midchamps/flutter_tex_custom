"use strict";
var isWeb = false;
var teXView;

const app_assets_uri = "../../..";


function initTeXViewMobile(rawData) {
    teXView = document.getElementById('TeXView');
    teXView.innerHTML = '';
    teXView.appendChild(createTeXView(rawData));
    renderTeXView(renderCompleted);
}

function initTeXViewWeb(viewId, rawData) {
    isWeb = true
    var initiated = false;
    var iframeElement = document.getElementById(viewId);
    if (iframeElement) {
        var iframeContent = iframeElement.contentWindow;
        if (iframeContent) {
            teXView = iframeContent.document.getElementById('TeXView');
            if (teXView) {
                teXView.innerHTML = '';
                teXView.appendChild(createTeXView(JSON.parse(rawData)));
                var renderTeXViewFn = iframeContent.renderTeXView;
                if (renderTeXViewFn) {
                    renderTeXViewFn(renderCompleted);
                    initiated = true;
                }
            }
        }
    }

    if (!initiated) setTimeout(function () {
        initTeXViewWeb(viewId, rawData)
    }, 100);
}


function createTeXView(rootData) {
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
            element.appendChild(createTeXView(data));
            break;
        }
        case 'leaf': {
            if (meta['tag'] === 'img') {
                if (classList === 'tex-view-asset-image') {
                    element.setAttribute('src', app_assets_uri + '/' + data);
                } else {
                    element.setAttribute('src', data);
                    element.addEventListener("load", renderCompleted);
                }
            } else {
                element.innerHTML = data;
            }

            break;
        }
        case 'internal_child': {
            element.appendChild(createTeXView(data));
            if (classList === 'tex-view-ink-well') clickManager(element, id, rootData['rippleEffect']);
            break;
        }

        default: {
            if (classList === 'tex-view-group') {
                createTeXViewGroup(element, rootData);
            } else {
                data.forEach(function (childViewData) {
                    element.appendChild(createTeXView(childViewData));
                });
            }
        }
    }
    return element;
}


var lastHeight = 0;

function renderCompleted() {
    const height = getTeXViewHeight(teXView);
    const rendered = lastHeight === height;
    lastHeight = height;

    if (isWeb) {
        TeXViewRenderedCallback(height);
    } else {
        TeXViewRenderedCallback.postMessage(height);
    }

    if (!rendered) {
        console.log('TeXView not fully rendered yet! Retrying in 250ms...');
        setTimeout(renderCompleted, 250);
    }
}

function clickManager(element, id, rippleEffect, callback) {
    element.addEventListener('click', function (e) {
        if (callback != null) {
            callback(id);
        } else {
            onTapCallback(id);
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


function onTapCallback(message) {
    if (isWeb) {
        OnTapCallback(message);
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

function createTeXViewGroup(element, rootData) {

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
            renderCompleted();
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