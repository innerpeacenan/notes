tpl压缩
fis.media('debug').match('/template/**/*.tpl', {
	optimizer: fis.plugin('tpl-compress')
});

tpl不压缩
fis.media('offline').match('*.tpl', {
    optimizer: false
});