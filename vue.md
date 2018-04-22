
Vue 的 inserted, update, unbind 等四种 life hook.

``` javascript
    /**
     * Helper that recursively merges two data objects together.
     */
    function mergeData (to, from) {
        if (!from) { return to }
        var key, toVal, fromVal;
        var keys = Object.keys(from);
        for (var i = 0; i < keys.length; i++) {
            key = keys[i];
            toVal = to[key];
            fromVal = from[key];
            if (!hasOwn(to, key)) {
                set(to, key, fromVal);
            } else if (isPlainObject(toVal) && isPlainObject(fromVal)) {
                mergeData(toVal, fromVal);
            }
        }
        return to
    }

```




markdown 和 highlight 调用的频率实在太高了，严重影响了性能。对次做了调整：
将hightlight指令改为:

```

    Vue.directive('highlightjs', {
        inserted: function (el) {
            var blocks = el.querySelectorAll('pre code');
            Array.prototype.forEach.call(blocks, hljs.highlightBlock);
        },
        update: function (el) {
            var blocks = el.querySelectorAll('pre code');
            Array.prototype.forEach.call(blocks, hljs.highlightBlock);
        }
    });
```

通过此次改造之后，不许要时时更新。 但是仍然存在一个比较严重的问题，就是渲染的时候会更新全文的所有节点，这个是出乎意料的，目前原因还没有弄清楚，等待进一步排查问题

这个问题已经弄清楚了 vue 处理数组的机制,解决方案如下:

```
    Vue.directive('highlightjs', {
        inserted: function (el) {
            var blocks = el.querySelectorAll('pre code');
            Array.prototype.forEach.call(blocks, hljs.highlightBlock);
        },
        update: function (el, binding, vnode, oldVnode) {
            if (vnode.data.domProps.innerHTML !== oldVnode.data.domProps.innerHTML) {
                var blocks = el.querySelectorAll('pre code');
                Array.prototype.forEach.call(blocks, hljs.highlightBlock);
            }

        }
    });

```

通过 vnode.data.domProps.innerHTML 前后比较,避免了不必要的highlightBlock



