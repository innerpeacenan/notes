* 面包屑递归
```php
       public static function navparent($id, $navArray = [])
    {
        $currentNav = SysNode::find()->where(['id' => $id])->one();
        array_unshift($navArray,'<span class="c-gray en">&gt;</span>' . $currentNav['name']);
        if ($currentNav['pid'] > 0){
            return self::navparent($currentNav['pid'], $navArray);
        } else {
            return $navArray;
        }
    }
```

```php
public function get_pos($myid, &$newarr)
    {
        $a = array();
        if (!isset($this->arr[$myid])) return false;
        $newarr[] = $this->arr[$myid];
        $pid = $this->arr[$myid]['pid'];
        if (isset($this->arr[$pid])) {
            $this->get_pos($pid, $newarr);
        }
        if (is_array($newarr)) {
            krsort($newarr);
            foreach ($newarr as $v) {
                $a[$v['id']] = $v;
            }
        }
        return $a;
    }
```
