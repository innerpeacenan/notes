	// 属于配送中的订单状态 indexOf 是强类型比较
				if(_.indexOf(status_on_deliver, parseInt(status_sign_stauts[0])) !== -1){
					today_statistic.on_deliver += count;
				}
