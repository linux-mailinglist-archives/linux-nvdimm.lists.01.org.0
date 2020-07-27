Return-Path: <linux-nvdimm-bounces@lists.01.org>
X-Original-To: lists+linux-nvdimm@lfdr.de
Delivered-To: lists+linux-nvdimm@lfdr.de
Received: from ml01.01.org (ml01.01.org [IPv6:2001:19d0:306:5::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B9C5422F608
	for <lists+linux-nvdimm@lfdr.de>; Mon, 27 Jul 2020 19:04:22 +0200 (CEST)
Received: from ml01.vlan13.01.org (localhost [IPv6:::1])
	by ml01.01.org (Postfix) with ESMTP id D071D123CCCC8;
	Mon, 27 Jul 2020 10:04:20 -0700 (PDT)
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=141.146.126.78; helo=aserp2120.oracle.com; envelope-from=jane.chu@oracle.com; receiver=<UNKNOWN> 
Received: from aserp2120.oracle.com (aserp2120.oracle.com [141.146.126.78])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ml01.01.org (Postfix) with ESMTPS id 8DD05123C2E0B
	for <linux-nvdimm@lists.01.org>; Mon, 27 Jul 2020 10:04:18 -0700 (PDT)
Received: from pps.filterd (aserp2120.oracle.com [127.0.0.1])
	by aserp2120.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 06RH1mhh115294;
	Mon, 27 Jul 2020 17:04:15 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=subject : to : cc :
 references : from : message-id : date : mime-version : in-reply-to :
 content-type : content-transfer-encoding; s=corp-2020-01-29;
 bh=w//J/2mDfCHLIaLXFVh9GpgHfZ0i+OErWDD1y/jPnaA=;
 b=oHaF03+mMohgORSzI2bUndmENyCDPn9OoZj0ZqWRy4x2cfYeKwyQiOYsFnCGgHS8wsss
 lQZfBivQfvHadJ5J/v2NvGU15MTc+zdGiXsL6TtAbNoq6kFRJr9zzqkpwh2m1EgUlDXc
 2zgrHjt2VSw2vlmFhbRDv/wAz0PQuPBWfqNIybjKeNyX4PuhOOfZqs3Sh7oRh1KVoTvG
 h9DEcxarduydClC2youAycKxyWV/sBfJO1j+7IXQJleHmfu0BHn0cZ5/BQ4u/OK35qov
 pF6ConPlPEXdKgMrj9Efo38Z/vzpfs9YpWEKnQ5yi/Sfbfb7SQn4f3Or0cfgMC7Jltqy vQ==
Received: from aserp3030.oracle.com (aserp3030.oracle.com [141.146.126.71])
	by aserp2120.oracle.com with ESMTP id 32hu1j2rp2-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
	Mon, 27 Jul 2020 17:04:15 +0000
Received: from pps.filterd (aserp3030.oracle.com [127.0.0.1])
	by aserp3030.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 06RGgeuQ080737;
	Mon, 27 Jul 2020 17:02:15 GMT
Received: from userv0122.oracle.com (userv0122.oracle.com [156.151.31.75])
	by aserp3030.oracle.com with ESMTP id 32hu5swhnk-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 27 Jul 2020 17:02:15 +0000
Received: from abhmp0012.oracle.com (abhmp0012.oracle.com [141.146.116.18])
	by userv0122.oracle.com (8.14.4/8.14.4) with ESMTP id 06RH2Diw006807;
	Mon, 27 Jul 2020 17:02:13 GMT
Received: from [10.159.128.109] (/10.159.128.109)
	by default (Oracle Beehive Gateway v4.0)
	with ESMTP ; Mon, 27 Jul 2020 10:02:13 -0700
Subject: Re: [PATCH v3] dax: print error message by pr_info() in
 __generic_fsdax_supported()
To: Coly Li <colyli@suse.de>, dan.j.williams@intel.com,
        linux-nvdimm@lists.01.org
References: <20200725162450.95999-1-colyli@suse.de>
From: Jane Chu <jane.chu@oracle.com>
Organization: Oracle Corporation
Message-ID: <7366fc46-48ee-8c9a-c8f2-8e4e03919880@oracle.com>
Date: Mon, 27 Jul 2020 10:02:11 -0700
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <20200725162450.95999-1-colyli@suse.de>
Content-Language: en-US
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9695 signatures=668679
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 malwarescore=0
 mlxscore=0 adultscore=0 spamscore=0 phishscore=0 mlxlogscore=999
 bulkscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2006250000 definitions=main-2007270116
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9695 signatures=668679
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 spamscore=0 bulkscore=0 mlxlogscore=999
 lowpriorityscore=0 malwarescore=0 clxscore=1011 mlxscore=0 impostorscore=0
 phishscore=0 adultscore=0 suspectscore=0 priorityscore=1501
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2006250000
 definitions=main-2007270117
Message-ID-Hash: 7QR6IC4S3ZA5NKWHXXAHWBFAPSP2XUL7
X-Message-ID-Hash: 7QR6IC4S3ZA5NKWHXXAHWBFAPSP2XUL7
X-MailFrom: jane.chu@oracle.com
X-Mailman-Rule-Misses: dmarc-mitigation; no-senders; approved; emergency; loop; banned-address; member-moderation; nonmember-moderation; administrivia; implicit-dest; max-recipients; max-size; news-moderation; no-subject; suspicious-header
CC: msuchanek@suse.com, ailiopoulos@suse.com, Jan Kara <jack@suse.com>, Pankaj Gupta <pankaj.gupta.linux@gmail.com>
X-Mailman-Version: 3.1.1
Precedence: list
List-Id: "Linux-nvdimm developer list." <linux-nvdimm.lists.01.org>
Archived-At: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/message/7QR6IC4S3ZA5NKWHXXAHWBFAPSP2XUL7/>
List-Archive: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/>
List-Help: <mailto:linux-nvdimm-request@lists.01.org?subject=help>
List-Post: <mailto:linux-nvdimm@lists.01.org>
List-Subscribe: <mailto:linux-nvdimm-join@lists.01.org>
List-Unsubscribe: <mailto:linux-nvdimm-leave@lists.01.org>
Content-Type: text/plain; charset="us-ascii"; format="flowed"
Content-Transfer-Encoding: 7bit

Hi,

On 7/25/2020 9:24 AM, Coly Li wrote:
> It is not simple to make dax_supported() from struct dax_operations
> or __generic_fsdax_supported() to return exact failure type right now.
> So the simplest fix is to use pr_info() to print all the error messages
> inside __generic_fsdax_supported(). Then users may find informative clue
> from the kernel message at least.

I happen to notice that some servers set their printk levels at 4 by 
default to minimize console messages:
# cat /proc/sys/kernel/printk
  4   4   1  7
So I'm wondering if you would consider pr_error() instead of pr_info() ?

thanks,
-jane
_______________________________________________
Linux-nvdimm mailing list -- linux-nvdimm@lists.01.org
To unsubscribe send an email to linux-nvdimm-leave@lists.01.org
