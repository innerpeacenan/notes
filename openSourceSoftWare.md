todo 目的是存放一些第三方工具,库的使用经验


/**
 * Pinyin.
 * @access
 * @param $str
 * @return string
 * Created by User: LiJun
 * Last Modify User: LiJun
 * Date: ${DATE}
 * Time: ${TIME}
 * Description: 转换成拼音
 * 特殊字符无法转拼音
 */
public static function Pinyin($str)
{
	$replace = array('◆', '♂', '（', '）', '=', '+', '$', '￥', '-', '、', '、', '：', ';', '！', '!', '/', 'x', '(', ')', ',', '°', '×', ' ');
	$py = new Pinyin();
	$py->set('delimiter', '');
	$py->set('uppercase', true);
	$match = str_replace($replace, '', $str);
	return $py->letter($match);
}