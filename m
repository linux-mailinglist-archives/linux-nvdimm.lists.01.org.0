Return-Path: <linux-nvdimm-bounces@lists.01.org>
X-Original-To: lists+linux-nvdimm@lfdr.de
Delivered-To: lists+linux-nvdimm@lfdr.de
Received: from ml01.01.org (ml01.01.org [IPv6:2001:19d0:306:5::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D8A1E1530E4
	for <lists+linux-nvdimm@lfdr.de>; Wed,  5 Feb 2020 13:38:40 +0100 (CET)
Received: from ml01.vlan13.01.org (localhost [IPv6:::1])
	by ml01.01.org (Postfix) with ESMTP id 382DE100780A9;
	Wed,  5 Feb 2020 04:41:56 -0800 (PST)
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=156.151.31.85; helo=userp2120.oracle.com; envelope-from=dan.carpenter@oracle.com; receiver=<UNKNOWN> 
Received: from userp2120.oracle.com (userp2120.oracle.com [156.151.31.85])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ml01.01.org (Postfix) with ESMTPS id ECB111007B1F2
	for <linux-nvdimm@lists.01.org>; Wed,  5 Feb 2020 04:41:53 -0800 (PST)
Received: from pps.filterd (userp2120.oracle.com [127.0.0.1])
	by userp2120.oracle.com (8.16.0.27/8.16.0.27) with SMTP id 015Cbw4I056966;
	Wed, 5 Feb 2020 12:38:34 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to : cc
 : subject : message-id : mime-version : content-type; s=corp-2019-08-05;
 bh=OEMxxPwwhKsM5Sp37byb5Qz7CZsNO5DAQdV4US530lQ=;
 b=k8Yiou0wQaplMwc3ncV7BIYCtMQPweaB2TgoW3DoPRlUA0Y+DImdsJKXfH74KA5zh4PI
 13XHzrMJB9iIUGkO6MxuLO1TdSFK8/YmhYj7N0POPe4RbiGvaA948OZLJ/jalTAB1JPo
 NzTTOxJb1bqAQTK81fIfYOCTaOIOKk2Kj9Vtp9IrAayNYXQkh0HqfKTRwEU6+wwrq4Os
 LSrnTz98z8MXtLHLTD9LQDhRHEdzs3cwd5wIei5HsBVNJe6DdWTOgW/Q5bwXRAaG1XGM
 ZcZodYpPVNWXXH0jE7x42bZBdu2HsBWr9B4LWW6NR5CXU+9CpozeP6JD50t6h9GsmhYD WQ==
Received: from userp3020.oracle.com (userp3020.oracle.com [156.151.31.79])
	by userp2120.oracle.com with ESMTP id 2xykbpaq9a-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 05 Feb 2020 12:38:34 +0000
Received: from pps.filterd (userp3020.oracle.com [127.0.0.1])
	by userp3020.oracle.com (8.16.0.27/8.16.0.27) with SMTP id 015CcPF1182347;
	Wed, 5 Feb 2020 12:38:34 GMT
Received: from aserv0122.oracle.com (aserv0122.oracle.com [141.146.126.236])
	by userp3020.oracle.com with ESMTP id 2xykc2s1ta-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 05 Feb 2020 12:38:34 +0000
Received: from abhmp0017.oracle.com (abhmp0017.oracle.com [141.146.116.23])
	by aserv0122.oracle.com (8.14.4/8.14.4) with ESMTP id 015CcX7s028391;
	Wed, 5 Feb 2020 12:38:33 GMT
Received: from kili.mountain (/129.205.23.165)
	by default (Oracle Beehive Gateway v4.0)
	with ESMTP ; Wed, 05 Feb 2020 04:38:32 -0800
Date: Wed, 5 Feb 2020 15:38:26 +0300
From: Dan Carpenter <dan.carpenter@oracle.com>
To: dan.j.williams@intel.com
Subject: [bug report] libnvdimm, nvdimm: dimm driver and base libnvdimm
 device-driver infrastructure
Message-ID: <20200205123826.kdvtsm47iy2ihw6r@kili.mountain>
MIME-Version: 1.0
Content-Disposition: inline
User-Agent: NeoMutt/20170113 (1.7.2)
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9521 signatures=668685
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=1 malwarescore=0
 phishscore=0 bulkscore=0 spamscore=0 mlxscore=0 mlxlogscore=861
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.0.1-1911140001 definitions=main-2002050102
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9521 signatures=668685
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 priorityscore=1501 malwarescore=0
 suspectscore=1 phishscore=0 bulkscore=0 spamscore=0 clxscore=1015
 lowpriorityscore=0 mlxscore=0 impostorscore=0 mlxlogscore=910 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.0.1-1911140001
 definitions=main-2002050102
Message-ID-Hash: 52OLDIB7R2C64Q55PBLJNTXHA3WJM6SB
X-Message-ID-Hash: 52OLDIB7R2C64Q55PBLJNTXHA3WJM6SB
X-MailFrom: dan.carpenter@oracle.com
X-Mailman-Rule-Hits: nonmember-moderation
X-Mailman-Rule-Misses: dmarc-mitigation; no-senders; approved; emergency; loop; banned-address; member-moderation
CC: linux-nvdimm@lists.01.org
X-Mailman-Version: 3.1.1
Precedence: list
List-Id: "Linux-nvdimm developer list." <linux-nvdimm.lists.01.org>
Archived-At: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/message/52OLDIB7R2C64Q55PBLJNTXHA3WJM6SB/>
List-Archive: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/>
List-Help: <mailto:linux-nvdimm-request@lists.01.org?subject=help>
List-Post: <mailto:linux-nvdimm@lists.01.org>
List-Subscribe: <mailto:linux-nvdimm-join@lists.01.org>
List-Unsubscribe: <mailto:linux-nvdimm-leave@lists.01.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

Hello Dan Williams,

The patch 4d88a97aa9e8: "libnvdimm, nvdimm: dimm driver and base
libnvdimm device-driver infrastructure" from May 31, 2015, leads to
the following static checker warning:

	drivers/nvdimm/bus.c:511 nd_async_device_register()
	error: dereferencing freed memory 'dev'

drivers/nvdimm/bus.c
   502  static void nd_async_device_register(void *d, async_cookie_t cookie)
   503  {
   504          struct device *dev = d;
   505  
   506          if (device_add(dev) != 0) {
   507                  dev_err(dev, "%s: failed\n", __func__);
   508                  put_device(dev);
                        ^^^^^^^^^^^^^^^
   509          }
   510          put_device(dev);
                ^^^^^^^^^^^^^^
   511          if (dev->parent)
   512                  put_device(dev->parent);
   513  }

We call get_device() from __nd_device_register(), I guess.  It seems
buggy to call put device twice on error.

regards,
dan carpenter


regards,
dan carpenter
_______________________________________________
Linux-nvdimm mailing list -- linux-nvdimm@lists.01.org
To unsubscribe send an email to linux-nvdimm-leave@lists.01.org
