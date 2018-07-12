// 二分查找循环版

int BinSerch1(int a[] ,int k){

    int left = 0, right = 11;
    while (left <right ) //循环条件
    {
        int mid = (left + right) / 2;//1.不断分割
        if (a[mid] == k)//找到了  查找的三种情况
        {
            return mid;
        }
        else if ( k < a[mid]) //
        {
            right = mid - 1;
        }
        else{
            left = mid + 1;
        }

    }
    return -1;
}



