Return-Path: <linux-nvdimm-bounces@lists.01.org>
X-Original-To: lists+linux-nvdimm@lfdr.de
Delivered-To: lists+linux-nvdimm@lfdr.de
Received: from ml01.01.org (ml01.01.org [198.145.21.10])
	by mail.lfdr.de (Postfix) with ESMTPS id F2E2622FDAA
	for <lists+linux-nvdimm@lfdr.de>; Tue, 28 Jul 2020 01:29:13 +0200 (CEST)
Received: from ml01.vlan13.01.org (localhost [IPv6:::1])
	by ml01.01.org (Postfix) with ESMTP id EF8AA12433227;
	Mon, 27 Jul 2020 16:29:11 -0700 (PDT)
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=156.151.31.86; helo=userp2130.oracle.com; envelope-from=jane.chu@oracle.com; receiver=<UNKNOWN> 
Received: from userp2130.oracle.com (userp2130.oracle.com [156.151.31.86])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ml01.01.org (Postfix) with ESMTPS id 5151612433225
	for <linux-nvdimm@lists.01.org>; Mon, 27 Jul 2020 16:29:06 -0700 (PDT)
Received: from pps.filterd (userp2130.oracle.com [127.0.0.1])
	by userp2130.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 06RNR9kV151812;
	Mon, 27 Jul 2020 23:29:02 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=subject : to : cc :
 references : from : message-id : date : mime-version : in-reply-to :
 content-type : content-transfer-encoding; s=corp-2020-01-29;
 bh=3oqv2FA7q1XwQT+oZ4JAwa4FTrqeoCn7G+ZboGskePA=;
 b=iDL30jkjgg3LvOPE5OJ7BfYrg9Q94nJFzZDUEjWoMpAZFnkW7m/rKu+bmaGiYl4AK4VG
 zqgQXjcwM084uvdom6X5iAvXZG7MexJjoUa683oaoK7QI2EU/xiZuFBsUN6x/eZTYbP+
 QkmFldxHRahn6gkHfFLQABhwb5l2R/ou192y7m13YXXd6/xgcps1Lp0AVMxzUJL9dbtc
 7P6RmBx/a6GCeOkQOK1YQ8zMcg6hkNs5hyMItFcC7Zf5lc6WaJpHjs5N6gPxZ5bETfWP
 hnCbfeu/w9XS+1h33IHDIF3Kf8axJNCrXpRsx10iQs2O0wJuGPUUD/Qh1fPj10DqK2MC qA==
Received: from userp3020.oracle.com (userp3020.oracle.com [156.151.31.79])
	by userp2130.oracle.com with ESMTP id 32hu1j4cq1-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
	Mon, 27 Jul 2020 23:29:01 +0000
Received: from pps.filterd (userp3020.oracle.com [127.0.0.1])
	by userp3020.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 06RNSWkV054607;
	Mon, 27 Jul 2020 23:29:01 GMT
Received: from aserv0122.oracle.com (aserv0122.oracle.com [141.146.126.236])
	by userp3020.oracle.com with ESMTP id 32hu5rtgh0-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 27 Jul 2020 23:29:01 +0000
Received: from abhmp0007.oracle.com (abhmp0007.oracle.com [141.146.116.13])
	by aserv0122.oracle.com (8.14.4/8.14.4) with ESMTP id 06RNSxNP026427;
	Mon, 27 Jul 2020 23:28:59 GMT
Received: from [10.159.128.109] (/10.159.128.109)
	by default (Oracle Beehive Gateway v4.0)
	with ESMTP ; Mon, 27 Jul 2020 16:28:59 -0700
Subject: Re: [PATCH v3] dax: print error message by pr_info() in
 __generic_fsdax_supported()
To: Jan Kara <jack@suse.cz>
References: <20200725162450.95999-1-colyli@suse.de>
 <7366fc46-48ee-8c9a-c8f2-8e4e03919880@oracle.com>
 <20200727214447.GN5284@quack2.suse.cz>
From: Jane Chu <jane.chu@oracle.com>
Organization: Oracle Corporation
Message-ID: <270fa891-becc-72db-277b-1ee8e81ba587@oracle.com>
Date: Mon, 27 Jul 2020 16:28:58 -0700
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <20200727214447.GN5284@quack2.suse.cz>
Content-Language: en-US
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9695 signatures=668679
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 adultscore=0 phishscore=0 bulkscore=0
 malwarescore=0 suspectscore=0 spamscore=0 mlxlogscore=999 mlxscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2006250000
 definitions=main-2007270159
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9695 signatures=668679
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 adultscore=0 clxscore=1011
 malwarescore=0 spamscore=0 suspectscore=0 bulkscore=0 priorityscore=1501
 phishscore=0 mlxlogscore=999 lowpriorityscore=0 impostorscore=0 mlxscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2006250000
 definitions=main-2007270159
Message-ID-Hash: TGLWKFMFCQRWP4AXKIYCMLT6CF7UGDML
X-Message-ID-Hash: TGLWKFMFCQRWP4AXKIYCMLT6CF7UGDML
X-MailFrom: jane.chu@oracle.com
X-Mailman-Rule-Misses: dmarc-mitigation; no-senders; approved; emergency; loop; banned-address; member-moderation; nonmember-moderation; administrivia; implicit-dest; max-recipients; max-size; news-moderation; no-subject; suspicious-header
CC: Coly Li <colyli@suse.de>, linux-nvdimm@lists.01.org, msuchanek@suse.com, ailiopoulos@suse.com, Jan Kara <jack@suse.com>, Pankaj Gupta <pankaj.gupta.linux@gmail.com>
X-Mailman-Version: 3.1.1
Precedence: list
List-Id: "Linux-nvdimm developer list." <linux-nvdimm.lists.01.org>
Archived-At: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/message/TGLWKFMFCQRWP4AXKIYCMLT6CF7UGDML/>
List-Archive: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/>
List-Help: <mailto:linux-nvdimm-request@lists.01.org?subject=help>
List-Post: <mailto:linux-nvdimm@lists.01.org>
List-Subscribe: <mailto:linux-nvdimm-join@lists.01.org>
List-Unsubscribe: <mailto:linux-nvdimm-leave@lists.01.org>
Content-Type: text/plain; charset="us-ascii"; format="flowed"
Content-Transfer-Encoding: 7bit

On 7/27/2020 2:44 PM, Jan Kara wrote:
> On Mon 27-07-20 10:02:11, Jane Chu wrote:
>> Hi,
>>
>> On 7/25/2020 9:24 AM, Coly Li wrote:
>>> It is not simple to make dax_supported() from struct dax_operations
>>> or __generic_fsdax_supported() to return exact failure type right now.
>>> So the simplest fix is to use pr_info() to print all the error messages
>>> inside __generic_fsdax_supported(). Then users may find informative clue
>>> from the kernel message at least.
>>
>> I happen to notice that some servers set their printk levels at 4 by default
>> to minimize console messages:
>> # cat /proc/sys/kernel/printk
>>   4   4   1  7
>> So I'm wondering if you would consider pr_error() instead of pr_info() ?
> 
> I don't think this is a good reason to raise priority of this message -
> with this logic applied, all info messages should be raised to error level
> because someone may find them useful :). And then people raise printk
> loglevel because the kernel is too noisy... Personally I think that
> pr_info() is fine because there will be error message about unsupported dax
> setup from the filesystem and if sysadmin wishes, (s)he can always lookup
> info messages in dmesg.
> 

Okay, sounds like the nature of the error isn't severe enough, and it 
isn't rare and random, rather, it's reproducible such that sysadmin can 
easily catch when raising the printk level.

thanks,
-jane

> 								Honza
> 
_______________________________________________
Linux-nvdimm mailing list -- linux-nvdimm@lists.01.org
To unsubscribe send an email to linux-nvdimm-leave@lists.01.org
