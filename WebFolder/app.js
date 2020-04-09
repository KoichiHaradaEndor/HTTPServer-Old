'use strict';

let test = {
    makeReq : (method, url, params) => {
        return new Promise((resolve, reject) => {
            let xhr = new XMLHttpRequest();
            xhr.open(method, url, true);
            xhr.onload = () => {
                if(xhr.readyState === 4 && xhr.status === 200) {
                    resolve(xhr);
                } else {
                    reject(new Error(xhr.statusText));
                }
            };
            xhr.onerror = () => {
                reject(new Error(xhr.statusText));
            };
            if(params && params.type) {
                xhr.setRequestHeader('Accept', params.type)
            }
            xhr.send(null);
        });
    },
    makeSideNav : () => {

        let i = 0, chapterDivElem;
        let menuBuf = document.createDocumentFragment();

        do {
            i += 1;
            chapterDivElem = document.getElementById('chapter' + i);
            if(chapterDivElem) {
                let h2Elem = chapterDivElem.getElementsByTagName('h2')[0],
                    h2ol = document.createElement('ol'),
                    h2li = document.createElement('li'),
                    h2anchor = document.createElement('a');

                h2anchor.href = '#' + h2Elem.parentNode.id;
                h2anchor.textContent = h2Elem.textContent;
                h2li.appendChild(h2anchor);
                h2ol.appendChild(h2li);
                h2ol.classList.add('h2list');
                menuBuf.appendChild(h2ol);

                let h3Elems = chapterDivElem.getElementsByTagName('h3'),
                    h3ol = document.createElement('ol');
                for (let j = 0, len = h3Elems.length; j < len; j+=1) {
                    let h3li = document.createElement('li'),
                        h3anchor = document.createElement('a');

                    h3anchor.href = '#' + h3Elems[j].parentNode.id;
                    h3anchor.textContent = h3Elems[j].textContent;
                    h3li.appendChild(h3anchor);
                    h3ol.appendChild(h3li);
                    h3ol.classList.add('h3list')
                }
                h2li.appendChild(h3ol);
            }
        } while (chapterDivElem)

        document.getElementById('sideNav').appendChild(menuBuf);
    }
};

(function() {

    test.makeSideNav();

    const test1_1 = new Vue({
        el: "#test1-1",
        data: {
            message_1_1: 'Test result will be displayed here'
        },
        methods: {
            test1_1Func: function() {
                test.makeReq("GET", "http://127.0.0.1/test1-1").then((res) => {
                    this.message_1_1 = res.responseText;
                }).catch(e => {
                    console.error(e);
                })
            }
        },
    });
    
    const test1_2 = new Vue({
        el: "#test1-2",
        data: {
            message_1_2: 'Test result will be displayed here'
        },
        methods: {
            test1_2FuncGet: function() {
                test.makeReq("GET", "http://127.0.0.1/test1-2").then((res) => {
                    this.message_1_2 = res.responseText;
                }).catch(e => {
                    console.error(e);
                })
            },
            test1_2FuncPost: function() {
                test.makeReq("POST", "http://127.0.0.1/test1-2").then((res) => {
                    this.message_1_2 = res.responseText;
                }).catch(e => {
                    console.error(e);
                })
            }
        }
    });

    const test1_3 = new Vue({
        el: "#test1-3",
        data: {
            message_1_3: 'Test result will be displayed here'
        },
        methods: {
            test1_3Func: function() {
                test.makeReq("GET", "http://127.0.0.1/test1-3/sub").then((res) => {
                    this.message_1_3 = res.responseText;
                }).catch(e => {
                    console.error(e);
                })
            }
        }
    });

    const test2_1 = new Vue({
        el: "#test2-1",
        data: {
            message_2_1: 'Test result will be displayed here'
        },
        methods: {
            test2_1FuncPlain: function() {
                test.makeReq("GET", "http://127.0.0.1/test2-1", {type: 'text/plain'}).then((res) => {
                    this.message_2_1 = 'Content-Type: ' + res.getResponseHeader('Content-Type') + '\n';
                    this.message_2_1 += 'Content: ' + res.responseText;
                }).catch(e => {
                    console.error(e);
                })
            },
            test2_1FuncJson: function() {
                test.makeReq("GET", "http://127.0.0.1/test2-1", {type: 'application/json'}).then((res) => {
                    this.message_2_1 = 'Content-Type: ' + res.getResponseHeader('Content-Type') + '\n';
                    this.message_2_1 += 'Content: ' + res.responseText;
                }).catch(e => {
                    console.error(e);
                })
            },
            test2_1FuncHtml: function() {
                test.makeReq("GET", "http://127.0.0.1/test2-1", {type: 'text/html'}).then((res) => {
                    this.message_2_1 = 'Content-Type: ' + res.getResponseHeader('Content-Type') + '\n';
                    this.message_2_1 += 'Content: ' + res.responseText;
                }).catch(e => {
                    this.message_2_1 = e;
                })
            }
        }
    });

    const test2_2 = new Vue({
        el: "#test2-2",
        data: {
            message_2_2: 'Test result will be displayed here'
        },
        methods: {
            test2_2Func: function() {
                test.makeReq("GET", "http://127.0.0.1/test2-2").then((res) => {
                    this.message_2_2 = 'Content-Type: ' + res.getResponseHeader('Content-Type') + '\n';
                    this.message_2_2 += 'Content: ' + res.responseText;
                }).catch(e => {
                    console.error(e);
                })
            }
        }
    });

    const test2_3 = new Vue({
        el: "#test2-3",
        data: {
            message_2_3: 'Test result will be displayed here'
        },
        methods: {
            test2_3Func: function() {
                test.makeReq("GET", "http://127.0.0.1/test2-3").then((res) => {
                    this.message_2_3 = 'Content-Type: ' + res.getResponseHeader('Content-Type') + '\n';
                    this.message_2_3 += 'Content: ' + res.responseText;
                }).catch(e => {
                    console.error(e);
                })
            }
        }
    });

    const test2_4 = new Vue({
        el: "#test2-4",
        data: {
            message_2_4: 'Test result will be displayed here'
        },
        methods: {
            test2_4Func: function() {
                test.makeReq("GET", "http://127.0.0.1/test2-4").then((res) => {
                    this.message_2_4 = 'Content-Disposition: ' + res.getResponseHeader('Content-Disposition') + '\n';
                    this.message_2_4 += 'Content-Type: ' + res.getResponseHeader('Content-Type') + '\n';
                    this.message_2_4 += 'Content: ' + res.responseText;
                }).catch(e => {
                    console.error(e);
                })
            }
        }
    });

    const test3_1 = new Vue({
        el: "#test3-1",
        data: {
            message_3_1: 'Test result will be displayed here'
        },
        methods: {
            test3_1FuncMain: function() {
                test.makeReq("GET", "http://127.0.0.1/test3-1").then((res) => {
                    this.message_3_1 = res.responseText;
                }).catch(e => {
                    console.error(e);
                })
            },
            test3_1FuncVhost: function() {
                test.makeReq("GET", "http://test.mycompany.com/test3-1").then((res) => {
                    this.message_3_1 = res.responseText;
                }).catch(e => {
                    console.error(e);
                })
            }
        }
    });

})();