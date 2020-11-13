Return-Path: <linux-nvdimm-bounces@lists.01.org>
X-Original-To: lists+linux-nvdimm@lfdr.de
Delivered-To: lists+linux-nvdimm@lfdr.de
Received: from ml01.01.org (ml01.01.org [198.145.21.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 953BA2B235A
	for <lists+linux-nvdimm@lfdr.de>; Fri, 13 Nov 2020 19:09:40 +0100 (CET)
Received: from ml01.vlan13.01.org (localhost [IPv6:::1])
	by ml01.01.org (Postfix) with ESMTP id C17B5100EB330;
	Fri, 13 Nov 2020 10:09:38 -0800 (PST)
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=156.151.31.85; helo=userp2120.oracle.com; envelope-from=joao.m.martins@oracle.com; receiver=<UNKNOWN> 
Received: from userp2120.oracle.com (userp2120.oracle.com [156.151.31.85])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ml01.01.org (Postfix) with ESMTPS id 69C76100EB32C
	for <linux-nvdimm@lists.01.org>; Fri, 13 Nov 2020 10:09:36 -0800 (PST)
Received: from pps.filterd (userp2120.oracle.com [127.0.0.1])
	by userp2120.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 0ADI5P5T057506;
	Fri, 13 Nov 2020 18:09:21 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=subject : to :
 references : cc : from : message-id : date : mime-version : in-reply-to :
 content-type : content-transfer-encoding; s=corp-2020-01-29;
 bh=w30kjF3IvkMYC9EGxmwpXY7JR+ZtHECE1tYUqy4Z33w=;
 b=K/BgZbJGJZATy1tm0rq4TdjSSzuHjewexRbk411OHkBALNxoQKuz0Mx8xPxBM+xOnGtM
 T00+R6nHxZND4b8Eb3Lo8F49KA7/173Gq7MXePL4qg3MNBDjr1MRaiI1Z033I7t242dI
 /2xtVXgBNqVL25D4ovuywWiz3k2X99f1OIV7ZToHWeOLEADGswQ09X5X9YTAQzZV6tpO
 wzC/G446ry67Wdq+0ha4OrWw3NUIi70/+iJv3v1ppBpyZG0t3+Nw0hE488CfXY2+AV9F
 jEsEvu+TeR9wi1OISyyt30cdCO2kfpV5JXYf/r5rBfAvy3RCWf4feq8mCsHjkFU+l5L7 SQ==
Received: from userp3020.oracle.com (userp3020.oracle.com [156.151.31.79])
	by userp2120.oracle.com with ESMTP id 34p72f1t5y-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
	Fri, 13 Nov 2020 18:09:21 +0000
Received: from pps.filterd (userp3020.oracle.com [127.0.0.1])
	by userp3020.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 0ADI5OBm140700;
	Fri, 13 Nov 2020 18:07:21 GMT
Received: from userv0122.oracle.com (userv0122.oracle.com [156.151.31.75])
	by userp3020.oracle.com with ESMTP id 34rt589q39-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 13 Nov 2020 18:07:21 +0000
Received: from abhmp0004.oracle.com (abhmp0004.oracle.com [141.146.116.10])
	by userv0122.oracle.com (8.14.4/8.14.4) with ESMTP id 0ADI7G0J030581;
	Fri, 13 Nov 2020 18:07:17 GMT
Received: from [10.175.169.218] (/10.175.169.218)
	by default (Oracle Beehive Gateway v4.0)
	with ESMTP ; Fri, 13 Nov 2020 10:07:16 -0800
Subject: Re: [PATCH -next] device-dax: change error code from postive to
 negative in range_parse
To: Zhang Qilong <zhangqilong3@huawei.com>
References: <20201026110425.136629-1-zhangqilong3@huawei.com>
From: Joao Martins <joao.m.martins@oracle.com>
Message-ID: <0753306a-bac9-0b47-b21e-1831bbf9904f@oracle.com>
Date: Fri, 13 Nov 2020 18:07:12 +0000
MIME-Version: 1.0
In-Reply-To: <20201026110425.136629-1-zhangqilong3@huawei.com>
Content-Language: en-US
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9804 signatures=668682
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 spamscore=0 bulkscore=0 mlxscore=0
 mlxlogscore=999 suspectscore=1 adultscore=0 phishscore=0 malwarescore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2009150000
 definitions=main-2011130117
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9804 signatures=668682
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 bulkscore=0 mlxlogscore=999 mlxscore=0
 malwarescore=0 suspectscore=1 lowpriorityscore=0 adultscore=0 phishscore=0
 priorityscore=1501 spamscore=0 impostorscore=0 clxscore=1011
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2009150000
 definitions=main-2011130117
Message-ID-Hash: MIPSEMU6HU3NI2MIFJIINAKZCUQJMXEE
X-Message-ID-Hash: MIPSEMU6HU3NI2MIFJIINAKZCUQJMXEE
X-MailFrom: joao.m.martins@oracle.com
X-Mailman-Rule-Misses: dmarc-mitigation; no-senders; approved; emergency; loop; banned-address; member-moderation; nonmember-moderation; administrivia; implicit-dest; max-recipients; max-size; news-moderation; no-subject; suspicious-header
CC: linux-nvdimm@lists.01.org
X-Mailman-Version: 3.1.1
Precedence: list
List-Id: "Linux-nvdimm developer list." <linux-nvdimm.lists.01.org>
Archived-At: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/message/MIPSEMU6HU3NI2MIFJIINAKZCUQJMXEE/>
List-Archive: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/>
List-Help: <mailto:linux-nvdimm-request@lists.01.org?subject=help>
List-Post: <mailto:linux-nvdimm@lists.01.org>
List-Subscribe: <mailto:linux-nvdimm-join@lists.01.org>
List-Unsubscribe: <mailto:linux-nvdimm-leave@lists.01.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

On 10/26/20 11:04 AM, Zhang Qilong wrote:
> call trace:
> 	-> mapping_store()
> 		-> range_parse()
> 		......
> 		rc = -ENXIO;
> 
> According to context, the error return value of
> range_parse should be negative.
> 
> Signed-off-by: Zhang Qilong <zhangqilong3@huawei.com>

Reviewed-by: Joao Martins <joao.m.martins@oracle.com>

> ---
>  drivers/dax/bus.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/dax/bus.c b/drivers/dax/bus.c
> index 27513d311242..e15a1a7c2853 100644
> --- a/drivers/dax/bus.c
> +++ b/drivers/dax/bus.c
> @@ -1047,7 +1047,7 @@ static ssize_t range_parse(const char *opt, size_t len, struct range *range)
>  {
>  	unsigned long long addr = 0;
>  	char *start, *end, *str;
> -	ssize_t rc = EINVAL;
> +	ssize_t rc = -EINVAL;
>  
>  	str = kstrdup(opt, GFP_KERNEL);
>  	if (!str)
> 
_______________________________________________
Linux-nvdimm mailing list -- linux-nvdimm@lists.01.org
To unsubscribe send an email to linux-nvdimm-leave@lists.01.org
