'use strict';

let test = {
    makeReq : (method, url, params) => {
        return new Promise((resolve, reject) => {
            let xhr = new XMLHttpRequest();
            xhr.open(method, url, true);
            xhr.onload = () => {
                if(xhr.readyState === 4 && xhr.status === 200) {
                    resolve(xhr.response);
                } else {
                    reject(new Error(xhr.statusText));
                }
            };
            xhr.onerror = () => {
                reject(new Error(xhr.statusText));
            };
            if(params.type) {
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

    const test1 = new Vue({
        el: "#test1",
        data: {
            message: 'Test result will be displayed here'
        },
        methods: {
            test1Func: function() {
                test.makeReq("GET", "http://127.0.0.1/test1").then((res) => {
                    this.message = res;
                }).catch(e => {
                    console.error(e);
                })
            }
        }
    });

    const test2 = new Vue({
        el: "#test2",
        data: {
            message: 'Test result will be displayed here'
        },
        methods: {
            test2FuncGet: function() {
                test.makeReq("GET", "http://127.0.0.1/test2").then((res) => {
                    this.message = res;
                }).catch(e => {
                    console.error(e);
                })
            },
            test2FuncPost: function() {
                test.makeReq("POST", "http://127.0.0.1/test2").then((res) => {
                    this.message = res;
                }).catch(e => {
                    console.error(e);
                })
            }
        }
    });

    const test3 = new Vue({
        el: "#test3",
        data: {
            message: 'Test result will be displayed here'
        },
        methods: {
            test3Func: function() {
                test.makeReq("GET", "http://127.0.0.1/test3/sub").then((res) => {
                    this.message = res;
                }).catch(e => {
                    console.error(e);
                })
            }
        }
    });

    const test4 = new Vue({
        el: "#test4",
        data: {
            message: 'Test result will be displayed here'
        },
        methods: {
            test4FuncPlain: function() {
                test.makeReq("GET", "http://127.0.0.1/test4", {type: 'text/plain'}).then((res) => {
                    this.message = res;
                }).catch(e => {
                    console.error(e);
                })
            },
            test4FuncJson: function() {
                test.makeReq("GET", "http://127.0.0.1/test4", {type: 'application/json'}).then((res) => {
                    this.message = res;
                }).catch(e => {
                    console.error(e);
                })
            },
            test4FuncHtml: function() {
                test.makeReq("GET", "http://127.0.0.1/test4", {type: 'text/html'}).then((res) => {
                    this.message = res;
                }).catch(e => {
                    this.message = e;
                })
            }
        }
    });

})();